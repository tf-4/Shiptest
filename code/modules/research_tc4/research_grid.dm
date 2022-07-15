#define GRID_PLUG(_type) "g_[_type]_p"
#define GRID_SOCK(_type) "g_[_type]_s"
#define GRID_LINE(_type) "g_[_type]_l"

/mob
	var/datum/research_grid/current_grid

/mob/Destroy(force, ...)
	current_grid?.user_logout(src)
	return ..()

/mob/Login()
	. = ..()
	current_grid?.user_login(src)

/proc/__loc_step(list/loc, dir)
	switch(dir)
		if(NORTH)
			return __loc(loc["x"], loc["y"] - 1)
		if(SOUTH)
			return __loc(loc["x"], loc["y"] + 1)
		if(EAST)
			return __loc(loc["x"] + 1, loc["y"])
		if(WEST)
			return __loc(loc["x"] - 1, loc["y"])
	CRASH("illegal loc step")

/proc/__loc(x, y)
	return list("x" = x, "y" = y)

/datum/research_grid
	var/name = "Research Grid"
	var/datum/research_node/node

	var/grid_width = 5
	var/grid_height = 5
	var/list/grid
	var/list/discovered
	var/list/last_check

	var/list/loc_plug
	var/list/loc_sock

	var/completed
	var/list/mob/users

	var/selected_type

	var/datum/research_web/parent_web

/datum/research_grid/New(node, parent_web, width = null, height = null)
	. = ..()
	src.node = node
	src.parent_web = parent_web
	name = "[initial(name)] ([src.node.name])"
	users = list()
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

/datum/research_grid/Destroy(force, ...)
	node = null
	parent_web = null
	for(var/user in users)
		user_logout(user)
	users.Cut()
	return ..()

/datum/research_grid/proc/add_user(mob/user, obj/machinery/from)
	if(QDELETED(src))
		return

	if(user.current_grid && user.current_grid != src)
		user.current_grid.user_logout(user)
	user.current_grid = src
	user_refresh(user, from)

/datum/research_grid/proc/user_login(mob/target)
	INVOKE_ASYNC(src, .proc/user_refresh, target)

/datum/research_grid/proc/refresh()
	if(QDELETED(src))
		return

	for(var/user in users)
		user_refresh(user)

/datum/research_grid/proc/user_refresh(mob/target, obj/machinery/from=null)
	if(QDELETED(src))
		return

	from = from || users[target]
	users[target] = from

	var/list/dat = list()
	dat += "<table>"
	for(var/y in 1 to grid_height)
		for(var/x in 1 to grid_width)
			var/click_func = "onClick=\"location.href='?src=[REF(src)];grid_button=[x]x[y]'\""
			dat += "<button [click_func]>[get_button_contents(x, y)]</button>"
		dat += "<br/>"
	dat += "</table>"
	dat += "<br />"
	var/datum/browser/popup = new(target, "rgrid", name, grid_width * 100, grid_height * 100)
	popup.set_content(dat.Join())
	popup.open()

/datum/research_grid/proc/user_logout(mob/target)
	target.current_grid = null
	users -= target
	target << browse(null, "window=rgrid")

/datum/research_grid/proc/__get_icon(state)
	var/static/list/valid_states = icon_states('grid_items.dmi')
	if(!(state in valid_states))
		CRASH("Attempt to get an invalid grid state")
	return icon('grid_items.dmi', state)

/datum/research_grid/proc/get_button_contents(x, y)
	var/_type = __loc2type(__loc(x, y))
	var/icon/base = __get_icon("base")

	if(!completed && !discovered[x][y])
		base.Blend(__get_icon("unknown"), ICON_OVERLAY)
		return icon2html(base, usr)

	var/icon/overlay
	switch(_type["grid"])
		if("s")
			overlay = __get_icon("socket")
		if("p")
			overlay = __get_icon("plug")
		if("l")
			return get_line_html(x, y)
		if("e")
			overlay = __get_icon("empty")
		else
			CRASH("unknown grid type? [_type["grid"]]")

	if(completed)
		base.Blend(rgb(0, 255, 0), ICON_ADD)
	else
		if(last_check)
			if(last_check[x][y])
				base.Blend(rgb(0, 255, 0), ICON_ADD)
			else
				base.Blend(rgb(255, 0, 0), ICON_ADD)

	if(selected_type && selected_type == _type["theory"])
		overlay.Blend(rgb(0, 0, 255), ICON_ADD)
	base.Blend(overlay, ICON_OVERLAY)

	return icon2html(base, usr)

/client/verb/rnd_debug()
	mob.CtrlShiftClick(mob)
	spawn(5)
		var/turf/t = get_turf(mob)
		var/obj/machinery/research_server/serv = new(t)
		for(var/pt in RESEARCH_POINT_TYPE_ALL)
			serv.web.add_points(pt, 50000, TRUE)
		var/obj/machinery/computer/rdconsole/comp = new(t)
		comp.stored_research = serv.web
		comp.research_node("biotech", mob)

/datum/research_grid/proc/get_line_html(x, y)
	var/state = "line-"
	for(var/dir in GLOB.cardinals)
		var/tx = x
		var/ty = y
		var/ta
		switch(dir)
			if(NORTH)
				ty -= 1
				ta = "n"
			if(SOUTH)
				ty += 1
				ta = "s"
			if(EAST)
				tx += 1
				ta = "e"
			if(WEST)
				tx -= 1
				ta = "w"
		if(tx < 1 || tx > grid_width || ty < 1 || ty > grid_height)
			continue
		if(can_connect(x, y, tx, ty))
			state = "[state][ta]"

	return icon2html(__get_icon(state), usr)

/datum/research_grid/proc/can_connect(x, y, tx, ty)
	var/_type1 = __loc2type(__loc(x, y))
	var/_type2 = __loc2type(__loc(tx, ty))

	return _type1["theory"] == _type2["theory"]

/datum/research_grid/proc/handle_button(x, y)
	if(istext(x))
		x = text2num(x)
	if(istext(y))
		y = text2num(y)
	if(completed)
		return

	var/_type = __loc2type(__loc(x, y))
	if(!discovered[x][y])
		var/can_afford = parent_web.use_points(node.node_cost_type, node.node_base_cost * GRID_COST_DISCOVER)
		if(!can_afford)
			to_chat(usr, "<span class='warning'>Not enough research points to reveal tile!</span>")
			return

		discovered[x][y] = TRUE
		refresh()
		return

	switch(_type["grid"])
		if("s")
			selected_type = _type["theory"]
			to_chat(usr, "<span class='notice'>Selected type is now: '[selected_type]'.</span>")
		if("p")
			var/can_afford = parent_web.use_points(node.node_cost_type, node.node_base_cost * GRID_COST_COMPLETE)
			if(!can_afford)
				to_chat(usr, "<span class='warning'>Not enough research points to attempt completion!</span>")
				return
			if(grid_completed())
				handle_completion()
				return // handle completion refreshes for us
		if("l")
			var/can_afford = parent_web.use_points(node.node_cost_type, node.node_base_cost * GRID_COST_LINE_REMOVE)
			if(!can_afford)
				to_chat(usr, "<span class='warning'>Not enough research points to remove line!</span>")
				return
			grid[x][y] = null
		if("e")
			var/can_afford = parent_web.use_points(node.node_cost_type, node.node_base_cost * GRID_COST_LINE_CREATE)
			if(!can_afford)
				to_chat(usr, "<span class='warning'>Not enough research points to create line!</span>")
				return
			if(!selected_type)
				to_chat(usr, "<span class='warning'>No socket type selected!</span>")
				return
			grid[x][y] = GRID_LINE(selected_type)
	refresh()

/datum/research_grid/proc/handle_completion()
	for(var/mob/user as anything in users)
		to_chat(user, "<span class='notice'>Research Grid finalized!</span>")
	completed = TRUE
	node.do_completion(src)
	refresh()
	for(var/mob/user as anything in users)
		var/obj/machinery/user_src = users[user]
		user_src?.ui_interact(user)

/datum/research_grid/Topic(href, list/href_list)
	if(href_list["grid_button"])
		var/list/loc = __text2loc(replacetext(href_list["grid_button"], "x", ";"))
		handle_button(arglist(loc))
		return

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
	last_check = create_empty_grid()
	for(var/loctext in loc_plug)
		var/loc = __text2loc(loctext)
		if(!check_connection(loc, last_check))
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
