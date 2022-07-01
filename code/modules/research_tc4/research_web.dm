/datum/research_web
	var/list/datum/theory_holder/points

	var/list/datum/research_node/nodes_researched
	var/list/datum/research_node/nodes_not_researched
	var/list/datum/research_node/nodes_can_research
	var/list/datum/research_node/nodes_can_not_research

	// these are here to prevent machinery from having to iterate through the internal node lists
	var/list/unlocked_surgeries
	var/list/unlocked_fabrications

	var/ruin = FALSE
	var/obj/machinery/research_server/parent

/datum/research_web/New(obj/machinery/research_server/parent)
	src.parent = parent
	points = new
	ruin = parent.is_ruin
	nodes_researched = new
	nodes_not_researched = new
	nodes_can_research = new
	nodes_can_not_research = new
	unlocked_surgeries = new
	unlocked_fabrications = new
	init_node_lists()
	if(ruin)
		do_ruin_unlocks()

/datum/research_web/Destroy(force, ...)
	QDEL_LIST(nodes_researched)
	QDEL_LIST(nodes_not_researched)
	QDEL_LIST(points)
	parent = null
	return ..()

/datum/research_web/proc/init_node_lists()
	for(var/datum/research_node/node as anything in nodes_researched)
		qdel(node)
	for(var/datum/research_node/node as anything in nodes_not_researched)
		qdel(node)

	ASSERT(!length(nodes_researched))
	ASSERT(!length(nodes_not_researched))
	ASSERT(!length(nodes_can_research))
	ASSERT(!length(nodes_can_not_research))

	for(var/datum/research_node/node_type as anything in subtypesof(/datum/research_node))
		if(initial(node_type.abstract) == node_type)
			continue
		nodes_not_researched.Add(new node_type(src))

/// Try not to call this, its incredibly costly
/datum/research_web/proc/calculate_node_requisites()
	if(ruin)
		return

	nodes_can_research.Cut()
	nodes_can_not_research.Cut()

	for(var/datum/research_node/researched as anything in nodes_researched)
		nodes_can_not_research.Add(researched)

	for(var/datum/research_node/not_researched as anything in nodes_not_researched)
		CHECK_TICK

		var/exclusive = FALSE
		for(var/datum/research_node/recursive in nodes_researched)
			if(recursive == not_researched)
				continue

			if(recursive.node_id in not_researched.exclusive_nodes)
				exclusive = FALSE
				break

			if(recursive.node_id in not_researched.requisite_nodes)
				not_researched.requisite_nodes.Remove(recursive.node_id)

		if(length(not_researched.requisite_nodes) || exclusive)
			nodes_can_not_research.Add(not_researched)
		else
			nodes_can_research.Add(not_researched)

/datum/research_web/proc/node_del(node)
	nodes_researched -= node
	nodes_not_researched -= node
	nodes_can_research -= node
	nodes_can_not_research -= node

/datum/research_web/proc/use_points(_type, amount, allow_partial=FALSE)
	if(ruin)
		return

	if(!(_type in points))
		return FALSE
	var/datum/theory_holder/holder = points[_type]
	return holder.use_points(amount, allow_partial)

/datum/research_web/proc/add_points(_type, amount, force=FALSE)
	if(ruin)
		return

	if(!(_type in points))
		points[_type] = new /datum/theory_holder(_type)
	var/datum/theory_holder/holder = points[_type]
	return holder.add_points(amount, force)

/datum/research_web/proc/handle_node_research_completion(datum/research_node/researched)
	ASSERT(researched in nodes_not_researched)
	ASSERT(researched in nodes_can_research)

	nodes_researched.Add(researched)
	nodes_not_researched.Remove(researched)

	if(ruin)
		return

	for(var/datum/research_node/other as anything in (nodes_not_researched | nodes_researched))
		if(other == researched)
			continue
		other.handle_other_completion(researched)

	for(var/datum/research_node/not_researched as anything in nodes_not_researched)
		CHECK_TICK // this likely wont cause any tick issues, but I'd rather be safe than sorry

		if(researched.node_id in not_researched.exclusive_nodes)
			nodes_can_research.Remove(not_researched)
			nodes_can_not_research.Add(not_researched)
			continue

		if(researched.node_id in not_researched.requisite_nodes)
			not_researched.requisite_nodes -= researched.node_id
			if(!length(not_researched.requisite_nodes))
				nodes_can_research.Add(not_researched)
				nodes_can_not_research.Remove(not_researched)
			continue

/datum/research_web/proc/__filter_hidden(list/nodes)
	. = nodes.Copy()
	for(var/datum/research_node/node as anything in nodes)
		if(node.node_hidden)
			. -= node

/datum/research_web/proc/__filter_dept(list/nodes, dept)
	. = list()
	for(var/datum/research_node/node as anything in nodes)
		if(node.category == dept)
			. += node

/datum/research_web/proc/get_visible_nodes(category, ignore_hidden=FALSE)
	if(ruin)
		return nodes_researched
	switch(category)
		if(RESEARCH_CATEGORY_NOT_RESEARCHED)
			. = nodes_not_researched
		if(RESEARCH_CATEGORY_RESEARCHED)
			. = nodes_researched
		if(RESEARCH_CATEGORY_CAN_RESEARCH)
			. = nodes_can_research
		if(RESEARCH_CATEGORY_CAN_NOT_RESEARCH)
			. = nodes_can_not_research
		else
			. = __filter_dept(nodes_can_research, category)
	if(!ignore_hidden)
		. = __filter_hidden(.)

/datum/research_web/proc/do_ruin_unlocks()
	if(!ruin)
		return

	var/list/prob_hit = new
	for(var/node_entry in parent.ruin_node_list)
		var/entry_prob = parent.ruin_node_list[node_entry]
		if(prob(entry_prob))
			prob_hit[node_entry] = entry_prob

	var/prob_spawned = 0
	while(length(prob_hit) && prob_spawned < parent.ruin_node_max)
		var/lowest_key
		var/lowest_prob
		for(var/entry in prob_hit)
			if(prob_hit[entry] < lowest_prob)
				lowest_prob = prob_hit[entry]
				lowest_key = entry
		prob_hit -= lowest_key

		var/found = FALSE
		for(var/datum/research_node/node as anything in nodes_not_researched)
			if(node.node_id == lowest_key)
				found = node
				break
		if(found)
			handle_node_research_completion(found)
			prob_spawned += 1
		else
			message_admins("attempted to force complete node for a ruin, but the given ID doesnt exist! --> '[lowest_key]'")
