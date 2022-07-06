/datum/research_node
	var/name = "Default Node"
	var/description = "Default Node"
	var/node_id = "default"
	var/starting_node = FALSE
	var/category = RESEARCH_CATEGORY_DEPT_ENGINEERING
	var/node_hidden = FALSE
	var/node_experimental = FALSE
	var/node_cost_type = RESEARCH_POINT_TYPE_ENGINEERING
	var/node_base_cost = 50
	var/list/designs

	var/list/theories_required = list(
		"default" = 2
	)
	var/list/requisite_nodes = list()
	var/list/exclusive_nodes = list()

	var/list/unlock_nodes = list()

	var/abstract = /datum/research_node
	var/list/grids

/datum/research_node/proc/get_grid_web(datum/research_grid/grid)
	for(var/datum/research_web/web as anything in grids)
		if(grids[web] == grid)
			return web

/datum/research_node/proc/get_web_grid(datum/research_web/web)
	return grids[web]

/datum/research_node/proc/do_completion(datum/research_grid/grid)
	var/datum/research_web/parent_web = grids[grid]
	parent_web.handle_node_research_completion(src)
	grid.refresh()

/datum/research_node/Destroy(force)
	if(!force)
		return QDEL_HINT_LETMELIVE
	stack_trace("Destroying a research node, this should never ever fucking happen")
	var/datum/research_web/any_web = grids[1]
	any_web.all_nodes -= node_id
	return ..()

/datum/research_node/proc/handle_other_completion(datum/research_node/other_node, datum/research_web/containing_web)
	return

/datum/research_node/proc/create_grid(mob/user, datum/research_web/web, obj/machinery/from)
	var/datum/research_grid/grid = grids[web]
	if(!grid)
		var/theory_total = length(theories_required)
		var/expected_size = max((theory_total * 2) + 1, 5) // 1-2: 5x5, 3: 7x7, 4: 9x9, etc; might need a better formula for this because it will get large FAST
		grid = new(src, expected_size, expected_size)
		grids[web] = grid
	grid.add_user(user, web, from)
	return TRUE
