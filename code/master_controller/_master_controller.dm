/proc/CheckSuspend()
	if(world.tick_usage >= 100)
		sleep(world.tick_lag)

var/datum/master_controller/mc

/datum/master_controller
	var/list/daemons = list()
	var/list/next_daemon_proc = list()

/datum/master_controller/New()

	. = ..()
	if(mc)
		daemons = mc.daemons
		QDel(mc)
		mc = src
	else
		Setup()

	StartProcessing()

/datum/master_controller/Destroy()
	daemons.Cut()
	. = ..()

/datum/master_controller/proc/Setup()
	for(var/dtype in (typesof(/datum/daemon)-/datum/daemon))
		var/datum/daemon/daemon = GetUniqueDataByPath(dtype)
		daemons += daemon
		next_daemon_proc["\ref[daemon]"] = world.time

/datum/master_controller/proc/StartProcessing()
	set waitfor = 0
	set background = 1
	for(var/datum/daemon/daemon in daemons)
		spawn(daemon.initial_offset)
			daemon.Start()
