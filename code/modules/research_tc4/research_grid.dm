#define GRID_PLUG(_type) "g_[_type]_p"
#define GRID_SOCK(_type) "g_[_type]_s"
#define GRID_LINE(_type) "g_[_type]_l"

/mob
	var/datum/research_grid/grid

/mob/verb/test_grid()
	var/datum/research_node/tnode = new
	tnode.theories_required = list(
		THEORY_BASIC = 2
	)
	grid = new(tnode)
	grid.ui_interact(src)

/datum/research_grid
	var/name = "Research Grid"
	var/datum/research_node/node

	var/grid_width = 5
	var/grid_height = 5
	var/list/grid
	var/list/discovered

	var/list/loc_plug
	var/list/loc_sock

	var/completed

/datum/research_grid/New(node, width = null, height = null)
	. = ..()
	src.node = node
	grid_width = width || grid_width
	grid_height = height || grid_height
	if(grid_width < 5 || grid_height < 5)
		CRASH("Minimum size for a grid is 5x5")
	if(!grid_init())
		stack_trace("failed to initialize grid, trying again with optimistic values")
		grid_width = 9
		grid_height = 9
		if(!grid_init())
			message_admins("[src] failed to initialize grid with optimistic values, non-recoverable.")
			addtimer(CALLBACK(.proc/qdel_self), 0)
			return

/datum/research_grid/ui_interact(mob/user)
	var/list/dat = list()
	dat += "<table>"
	for(var/y in 1 to grid_height)
		for(var/x in 1 to grid_width)
			var/click_func = "onClick=\"location.href='?src=[REF(src)];grid_button=[x]x[y]'\""
			dat += "<button [click_func]>[get_button_contents(x, y, user)]</button>"
		dat += "<br/>"
	dat += "</table>"
	var/datum/browser/popup = new(user, "rgrid", name, 400, 400)
	popup.set_content(dat.Join())
	popup.open()

/datum/research_grid/proc/__get_icon(state)
	return mutable_appearance('grid_items.dmi', state)

/datum/research_grid/proc/get_button_contents(x, y, mob/user)
	var/_type = __loc2type(__loc(x, y))
	var/mutable_appearance/base
	if(!completed && !discovered[x][y])
		base = __get_icon("unknown")
	else
		switch(_type["grid"])
			if("s")
				base = __get_icon("socket")
			if("p")
				base = __get_icon("plug")
			if("l")
				base = __get_icon("line")
			if("e")
				base = __get_icon("empty")
			else
				CRASH("unknown grid type? [_type["grid"]]")
	return icon2html(base, user)

/datum/research_grid/proc/handle_button(x, y)
	if(istext(x))
		x = text2num(x)
	if(istext(y))
		y = text2num(y)
	if(completed)
		return

	world.log << "Handling button: [x]|[y]"
	if(!discovered[x][y])
		var/can_afford = TRUE // todo: consume research points
		if(!can_afford)
			to_chat(usr, "<span class='warning'>Not enough research points to reveal tile!</span>")
			return

		discovered[x][y] = TRUE
		ui_interact(usr) // update the window state
		return

	var/_type = __loc2type(__loc(x, y))
	switch(_type["grid"])
		if("s")
			// do nothing
		if("p")
			if(grid_completed())
				handle_completion()
		if("l")
			var/can_afford = TRUE // todo: see above
			if(!can_afford)
				to_chat(usr, "<span class='warning'>Not enough research points to remove line!</span>")
				return
			grid[x][y] = null
		if("e")
			var/can_afford = TRUE // todo: see above
			if(!can_afford)
				to_chat(usr, "<span class='warning'>Not enough research points to create line!</span>")
				return
			grid[x][y] = GRID_LINE(_type["theory"])
	ui_interact(usr)

/datum/research_grid/proc/handle_completion()
	to_chat(usr, "<span class='notice'>Research Grid finalized!</span>")
	completed = TRUE
	//todo: node.on_research_completion()

/datum/research_grid/Topic(href, list/href_list)
	if(href_list["grid_button"])
		var/list/loc = __text2loc(replacetext(href_list["grid_button"], "x", ";"))
		handle_button(arglist(loc))
		return

/datum/research_grid/Destroy(force, ...)
	. = ..()
	node = null
	grid.Cut()
	loc_plug.Cut()
	loc_sock.Cut()

#define INIT_PLUG 1
#define INIT_SOCKET 2

/datum/research_grid/proc/grid_init()
	grid = create_empty_grid()
	discovered = create_empty_grid()
	loc_plug = new
	loc_sock = new
	var/needed_total = 0

	for(var/_type in node.theories_required)
		var/t_needed = node.theories_required[_type]
		for(var/plug_or_socket in INIT_PLUG to INIT_SOCKET)
			needed_total += t_needed
			for(var/idx in 1 to t_needed)
				var/t_x
				var/t_y
				var/tries = 0
				do
					tries += 1
					if(tries > 5)
						stack_trace("[src] took too long to place grid items, possibly too small a grid for the theories needed. Failed at '[needed_total]' when grid size is [grid_width]x[grid_height]")
						return FALSE
					t_x = rand(2, grid_width - 1)
					t_y = rand(2, grid_height - 1)
				while(grid[t_x][t_y])
				var/t_loc = __loc(t_x, t_y)
				switch(plug_or_socket)
					if(INIT_PLUG)
						grid[t_x][t_y] = GRID_PLUG(_type)
						loc_plug.Add(__loc2text(t_loc))
					if(INIT_SOCKET)
						grid[t_x][t_y] = GRID_SOCK(_type)
						loc_sock.Add(__loc2text(t_loc))
	return TRUE

#undef INIT_PLUG
#undef INIT_SOCKET

/datum/research_grid/proc/create_empty_grid()
	. = new /list(grid_width)
	for(var/x in 1 to grid_width)
		.[x] = new /list(grid_height)
		for(var/y in 1 to grid_height)
			.[x][y] = FALSE

/datum/research_grid/proc/__loc(x, y)
	return list("x" = x, "y" = y)

/datum/research_grid/proc/__loc2text(list/loc)
	return "[loc["x"]];[loc["y"]]"

/datum/research_grid/proc/__text2loc(text)
	var/list/split = splittext(text, ";")
	. = list()
	.["x"] = text2num(split[1])
	.["y"] = text2num(split[2])

/datum/research_grid/proc/__loc2type(list/loc)
	var/entry = grid[loc["x"]][loc["y"]]
	if(!entry)
		entry = "g_none_e"
	var/split = splittext(entry, "_")
	ASSERT(split[1]=="g")
	return list("theory" = split[2], "grid" = split[3])

/datum/research_grid/proc/grid_completed()
	var/list/used = create_empty_grid()
	for(var/loctext in loc_plug)
		var/loc = __text2loc(loctext)
		if(!check_connection(loc, used))
			return FALSE
	return TRUE

/datum/research_grid/proc/check_connection(list/plug_loc, list/used = null)
	if(used == null)
		used = create_empty_grid()
	var/_type = __loc2type(plug_loc)
	for(var/dir in GLOB.cardinals)
		var/c_x = plug_loc["x"]
		var/c_y = plug_loc["y"]
		var/t_x = c_x
		var/t_y = c_y
		switch(dir)
			if(NORTH)
				t_y = c_y + 1
			if(SOUTH)
				t_y = c_y - 1
			if(EAST)
				t_x = c_x + 1
			if(WEST)
				t_x = c_x - 1
		if(!t_x || !t_y)
			continue
		if(t_x > grid_width || t_y > grid_height)
			continue
		if(used[t_x][t_y])
			continue

		var/found = grid[t_x][t_y]
		if(found == GRID_SOCK(_type["theory"]))
			// found a socket, mark us and them as used
			used[t_x][t_y] = TRUE
			used[c_x][c_y] = TRUE
			return TRUE
		if(found == GRID_LINE(_type["theory"]))
			var/f_loc = __loc(t_x, t_y)
			// mark ourselves as used to prevent infinite recurses
			used[c_x][c_y] = TRUE
			if(check_connection(f_loc, used))
				used[t_x][t_y] = TRUE
				return TRUE
			else
				// if a connection wasnt found reset our use state
				used[c_x][c_y] = FALSE
	return FALSE

#undef GRID_PLUG
#undef GRID_SOCK
