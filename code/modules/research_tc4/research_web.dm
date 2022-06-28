/datum/research_web
	var/list/points_list
	var/list/points_max

	var/list/datum/research_node/nodes_researched
	var/list/datum/research_node/nodes_not_researched
	var/list/datum/research_node/nodes_can_research
	var/list/datum/research_node/nodes_can_not_research

/datum/research_web/New()
	nodes_researched = new
	nodes_not_researched = new
	nodes_can_research = new
	nodes_can_not_research = new

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

/datum/research_web/proc/calculate_node_requisites()
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
			nodes_can_research.Add(not_researched)

/datum/research_web/proc/node_del(node)
	nodes_researched -= node
	nodes_not_researched -= node
	nodes_can_research -= node
	nodes_can_not_research -= node

/datum/research_web/proc/use_points(_type, amount, allow_partial=FALSE)
	if(!(_type in points_list))
		return FALSE
	if(points_list[_type] < amount)
		. = allow_partial ? round(points_list[_type]) : 0
	else
		. = amount

	if(.)
		points_list[_type] -= .
	return .

/datum/research_web/proc/add_points(_type, amount, force=FALSE)
	if(!(_type in points_max))
		if(!force)
			return FALSE
		points_list[_type] += amount
		return amount

	. = points_max[_type] - points_list[_type]
	. = min(., amount)
	points_list[_type] += .
	return .

/datum/research_web/proc/handle_node_research_completion(datum/research_node/researched)
	ASSERT(researched in nodes_not_researched)
	ASSERT(researched in nodes_can_research)

	nodes_researched.Add(researched)
	nodes_not_researched.Remove(researched)

	for(var/datum/research_node/not_researched as anything in nodes_not_researched)
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
