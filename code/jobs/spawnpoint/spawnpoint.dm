/obj/spawnpoint
	name = "spawn point"
	flags = FLAG_ANCHORED
	invisibility = 101

/obj/spawnpoint/Initialize()
	var/datum/single_list/spawning = _glob.spawnpoints[name]
	if(!istype(spawning))
		spawning = new
		_glob.spawnpoints[name] = spawning
	spawning.contents += new /datum/coord(x,y,z)
	QDel(src, "initialized")

/proc/GetSpawnPoint(var/key)
	if(istype(_glob.spawnpoints[key], /datum/single_list))
		var/datum/single_list/spawnpoint = _glob.spawnpoints[key]
		var/datum/coord/spawn_coord = pick(spawnpoint.contents)
		if(istype(spawn_coord))
			return spawn_coord.GetTurf()