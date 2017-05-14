/data/daemon
	var/name = "daemon"
	var/delay = 20
	var/suspend

/data/daemon/New()
	setup()

/data/daemon/proc/setup()
	return

/data/daemon/proc/do_work()
	return

/data/daemon/proc/start()
	set background = 1
	set waitfor = 0

	while(1)
		sleep(delay)
		check_suspend()
		do_work()

/data/daemon/proc/status()
	return ""