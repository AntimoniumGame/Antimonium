// These exist solely because lists of list are untrustworthy.
/datum/coord
	var/x = 0
	var/y = 0
	var/z = 1

/datum/coord/New(var/_x, var/_y, var/_z)
	x = _x
	y = _y
	z = _z

/datum/coord/proc/GetTurf()
	return locate(x,y,z)

/datum/single_list
	var/list/contents = list()

/datum/single_list/Destroy()
	contents.Cut()
	. = ..()
