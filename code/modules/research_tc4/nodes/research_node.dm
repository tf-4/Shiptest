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

	// internal stuff
	var/datum/research_web/parent
	var/abstract = /datum/research_node
	var/datum/research_grid/grid

/datum/research_node/New(parent)
	src.parent = parent

/datum/research_node/proc/handle_completion()
	grid.completed = TRUE
	parent.handle_node_research_completion(src)
	grid.refresh()

/datum/research_node/Destroy(force, ...)
	. = ..()
	parent.node_del(src)
	parent = null
	QDEL_NULL(grid)

/datum/research_node/proc/handle_other_completion(datum/research_node/other_node)
	return

/datum/research_node/proc/create_grid(mob/user)
	if(!grid)
		var/theory_total = length(theories_required)
		var/expected_size = max((theory_total * 2) + 1, 5) // 1-2: 5x5, 3: 7x7, 4: 9x9, etc; might need a better formula for this because it will get large FAST
		grid = new(src, expected_size, expected_size)
	grid.add_user(user)
	return TRUE
