/datum/daemon
	var/name = "daemon"
	var/initial_offset = 0
	var/delay = 20
	var/suspend

/datum/daemon/New()
	setup()

/datum/daemon/proc/setup()
	return

/datum/daemon/proc/do_work()
	return

/datum/daemon/proc/start()
	set background = 1
	set waitfor = 0

	while(1)
		sleep(delay)
		check_suspend()
		do_work()

/datum/daemon/proc/status()
	return ""