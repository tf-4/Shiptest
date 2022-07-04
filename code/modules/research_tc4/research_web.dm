/datum/research_web
	var/list/datum/theory_holder/points

	var/list/datum/research_node/nodes_researched
	var/list/datum/research_node/nodes_not_researched
	var/list/datum/research_node/nodes_can_research
	var/list/datum/research_node/nodes_hidden
	var/list/datum/research_node/nodes_can_not_research

	// these are here to prevent machinery from having to iterate through the internal node lists
	var/static/list/all_designs
	var/static/list/all_mutations // so this is apparentally just a fucking list of types, why on god

	var/list/datum/surgery/unlocked_designs
	var/list/datum/mutation/unlocked_mutations
	var/list/slime_already_researched

	var/largest_bomb_value
	var/old_tech_largest_bomb_value

	var/list/consoles_accessing

	var/ruin = FALSE
	var/admin = FALSE
	var/obj/machinery/parent

/datum/research_web/integrated
	ruin = TRUE

/datum/research_web/integrated/New(obj/machinery/parent, buildtypes)
	. = ..(parent)
	if(!buildtypes)
		return
	if(!islist(buildtypes))
		buildtypes = list(buildtypes)
	for(var/datum/design/design as anything in all_designs)
		design = all_designs[design]
		if(!(design.build_type in buildtypes))
			continue
		unlocked_designs[design.id] = design

/datum/research_web/admin
	admin = TRUE

/datum/research_web/New(obj/machinery/parent)
	if(!all_designs)
		all_designs = list()
		all_mutations = list()
		for(var/datum/design/dtype as anything in subtypesof(/datum/design))
			if(initial(dtype.id) == DESIGN_ID_IGNORE)
				continue
			all_designs[initial(dtype.id)] = new dtype
		for(var/mutation in subtypesof(/datum/mutation))
			all_mutations += mutation
	src.parent = parent
	slime_already_researched = new
	points = new
	ruin = ruin || (("is_ruin" in parent.vars) ? parent:is_ruin : FALSE) // unsafe var access, but we check for the var existing first
	nodes_researched = new
	nodes_not_researched = new
	nodes_can_research = new
	nodes_can_not_research = new
	nodes_hidden = new
	unlocked_designs = new
	unlocked_mutations = new
	consoles_accessing = new
	init_node_lists()
	if(ruin)
		do_ruin_unlocks()

/datum/research_web/Destroy(force, ...)
	nodes_hidden.Cut()
	QDEL_LIST(nodes_researched)
	QDEL_LIST(nodes_not_researched)
	unlocked_designs.Cut()
	slime_already_researched.Cut()
	consoles_accessing.Cut()
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
		if(admin)
			nodes_researched.Add(new node_type(src))
		else
			if(initial(node_type.starting_node))
				nodes_researched.Add(new node_type(src))
			else
				nodes_not_researched.Add(new node_type(src))

	calculate_node_unlocks()
	calculate_node_requisites()

	if(admin)
		recalculate_unlocked_designs()

/// This does not check for circular dependencies; because I don't know a way to do that without being recursively recursive
/datum/research_web/proc/calculate_node_unlocks()
	for(var/datum/research_node/node as anything in (nodes_researched | nodes_not_researched))
		node.unlock_nodes.Cut()

	for(var/datum/research_node/node as anything in (nodes_researched | nodes_not_researched))
		CHECK_TICK

		for(var/datum/research_node/req_node as anything in node.requisite_nodes)
			req_node = node_by_id(req_node)
			req_node.unlock_nodes |= node.node_id

/// Try not to call this, its incredibly costly
/datum/research_web/proc/calculate_node_requisites()
	if(ruin || admin)
		return

	nodes_can_research.Cut()
	nodes_can_not_research.Cut()

	for(var/datum/research_node/researched as anything in nodes_researched)
		nodes_can_not_research.Add(researched)

	for(var/datum/research_node/not_researched as anything in nodes_not_researched)
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
			if(not_researched.node_hidden)
				nodes_hidden.Add(not_researched)
			else
				nodes_can_research.Add(not_researched)

/datum/research_web/proc/node_del(node)
	nodes_researched -= node
	nodes_not_researched -= node
	nodes_can_research -= node
	nodes_can_not_research -= node

/datum/research_web/proc/node_by_id(id)
	for(var/datum/research_node/node as anything in (nodes_not_researched | nodes_researched))
		if(node.node_id == id)
			return node

/datum/research_web/proc/add_points_from_note(obj/item/research_notes/note)
	return //TODO

/datum/research_web/proc/create_point_information_header()
	var/list/dat = list("<div id='rnd-points'>")
	for(var/datum/theory_holder/pnt_holder as anything in points)
		dat += "<p>[pnt_holder]: "
		pnt_holder = points[pnt_holder]
		dat += "[pnt_holder.points](/[pnt_holder.points_max])"
	dat += "</div>"
	return dat.Join()

/datum/research_web/proc/use_points(_type, amount, allow_partial=FALSE)
	if(ruin)
		return

	if(admin)
		return amount

	if(!(_type in points))
		return FALSE
	var/datum/theory_holder/holder = points[_type]
	return holder.use_points(amount, allow_partial)

/datum/research_web/proc/add_points(_type, amount, force=FALSE)
	if(ruin || admin)
		return

	if(!(_type in points))
		points[_type] = new /datum/theory_holder(_type)
	var/datum/theory_holder/holder = points[_type]
	return holder.add_points(amount, force)

/datum/research_web/proc/recalculate_unlocked_designs()
	unlocked_designs.Cut()
	for(var/datum/research_node/node as anything in nodes_researched)
		for(var/design in node.designs)
			unlocked_designs[design] = all_designs[design]

/datum/research_web/proc/handle_node_research_completion(datum/research_node/researched)
	ASSERT(researched in nodes_not_researched)
	ASSERT(researched in nodes_can_research)

	nodes_researched.Add(researched)
	nodes_not_researched.Remove(researched)

	for(var/design in researched.designs)
		unlocked_designs[design] = all_designs[design]

	if(ruin)
		return

	for(var/datum/research_node/other as anything in (nodes_not_researched | nodes_researched))
		if(other == researched)
			continue
		other.handle_other_completion(researched)
	
	calculate_node_requisites()

	for(var/obj/machinery/console as anything in consoles_accessing)
		console.say("Research Complete: [researched.name]")
		console.updateDialog()

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

/datum/research_web/proc/get_designs(category)
	. = list()
	for(var/datum/design/design as anything in unlocked_designs)
		if(category in design.category)
			. += design

/datum/research_web/proc/do_ruin_unlocks()
	if(!ruin || !("ruin_node_list" in src.parent.vars))
		return

	var/list/prob_hit = new
	var/obj/machinery/research_server/parent = src.parent // the var we want exists, pretend its a research server even though we dont know for certain
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
