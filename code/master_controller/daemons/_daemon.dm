/datum/daemon
	var/name = "daemon"
	var/initial_offset = 0
	var/delay = 20
	var/suspend

/datum/daemon/New()
	Setup()

/datum/daemon/proc/Setup()
	return

/datum/daemon/proc/DoWork()
	return

/datum/daemon/proc/Start()
	set background = 1
	set waitfor = 0

	while(1)
		if(suspend)
			break
		sleep(delay)
		CheckSuspend()
		DoWork()

/datum/daemon/proc/Status()
	return ""