#define CHECK_SUSPEND if(world.tick_usage >= 100) sleep(world.tick_lag)
/datum/master_controller
	var/list/daemons = list()

/datum/master_controller/New()

	. = ..()
	if(_glob.mc)
		daemons = _glob.mc.daemons
		QDel(_glob.mc, "mc restart")
		_glob.mc = src
	else
		Setup()

	StartProcessing()

/datum/master_controller/Destroy()
	daemons.Cut()
	. = ..()

/datum/master_controller/proc/Setup()
	for(var/dtype in (typesof(/datum/daemon)-/datum/daemon))
		daemons += GetUniqueDataByPath(dtype)

/datum/master_controller/proc/StartProcessing()
	set waitfor = 0
	set background = 1
	for(var/datum/daemon/daemon in daemons)
		spawn(daemon.initial_offset)
			daemon.Start()
