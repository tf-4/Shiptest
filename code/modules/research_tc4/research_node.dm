/datum/research_node
	var/abstract = /datum/research_node

	var/name = "Default Node"
	var/node_id = "default"

	var/datum/research_web/parent

	var/list/datum/research_grid/grids

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
