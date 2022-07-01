/datum/research_node
	var/name = "Default Node"
	var/description = "Default Node"
	var/node_id = "default"
	var/starting_node = FALSE
	var/category = RESEARCH_CATEGORY_DEPT_ENGINEERING
	var/node_hidden = FALSE
	var/node_experimental = FALSE
	var/node_base_cost = 50
	var/list/designs

	var/list/theories_required = list(
		THEORY_BASIC = 1,
		THEORY_NORMAL = 1,
		THEORY_ADVANCED = 1,
		THEORY_COMPLEX = 1,
		THEORY_STELLAR = 1,
		THEORY_BLUESPACE = 1,
		THEORY_ALIEN = 1,
	)

	var/list/requisite_nodes = list()
	var/list/exclusive_nodes = list()

	var/list/unlock_nodes = list()

	// internal stuff
	var/datum/research_web/parent
	var/abstract = /datum/research_node
	var/list/datum/research_grid/grids

/datum/research_node/New(parent)
	src.parent = parent

/datum/research_node/proc/handle_completion()
	for(var/datum/research_grid/grid as anything in grids)
		grid.completed = TRUE
		grid.refresh()

	parent.handle_node_research_completion(src)

/datum/research_node/Destroy(force, ...)
	. = ..()
	parent.node_del(src)
	parent = null
	for(var/grid in grids)
		qdel(grid)
	grids.Cut()

/datum/research_node/proc/handle_other_completion(datum/research_node/other_node)
	return

/datum/research_node/proc/create_grid(mob/user)
	if(length(grids))
		if(tgui_alert(user, "Someone is already working on this node! Are you sure you want to work on it aswell? PROGRESS IS NOT SHARED BETWEEN MULTIPLE GRIDS", "NeoCatch", list("Yes", "No"), 5 SECONDS) != "Yes")
			return
		for(var/datum/research_grid/other as anything in grids)
			tgui_alert(other.user, "Someone has started working on this grid, please remember that progress is not shared.", "NeoCatch", list("Okay"), 5)

	var/theory_total = length(theories_required)
	var/expected_size = max((theory_total * 2) + 1, 5) // 1-2: 5x5, 3: 7x7, 4: 9x9, etc; might need a better formula for this because it will get large FAST

	grids.Add(new /datum/research_grid(src, user, expected_size, expected_size))
