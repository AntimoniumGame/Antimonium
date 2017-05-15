/datum/admin_rank
	var/ckey
	var/permissions = 0
	var/title

/datum/admin_rank/New(var/_ckey, var/_permissions = 0, var/_title = "Administrator")
	ckey = _ckey
	permissions = _permissions
	title = _title
	..()
