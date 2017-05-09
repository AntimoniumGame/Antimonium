/proc/check_suspend()
	if(world.tick_usage > 100)
		sleep(world.tick_lag)

var/data/master_controller/mc

/data/master_controller
	var/list/daemons = list()
	var/list/next_daemon_proc = list()

/data/master_controller/New()

	. = ..()
	if(mc)
		daemons = mc.daemons
		qdel(mc)
		mc = src
	else
		setup()

	start_processing()

/data/master_controller/destroy()
	daemons.Cut()
	return ..()

/data/master_controller/proc/setup()
	for(var/dtype in (typesof(/data/daemon)-/data/daemon))
		var/data/daemon/daemon = get_unique_data_by_path(dtype)
		daemons += daemon
		next_daemon_proc["\ref[daemon]"] = world.time

/data/master_controller/proc/start_processing()
	set waitfor = 0
	set background = 1
	for(var/data/daemon/daemon in daemons)
		daemon.start()

/mob/verb/debug_controller()

	set name = "Master Controller Status"
	set category = "Debug"

	if(!mc)
		src << "MC doesn't exist."
		return
	src << "Daemons: [mc.daemons.len]"
	for(var/data/daemon/daemon in mc.daemons)
		src << "[daemon.name]: [daemon.status()]"