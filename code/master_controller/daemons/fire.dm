/datum/daemon/fire
	name = "fire"
	delay = 10
	initial_offset = 10

/datum/daemon/fire/DoWork()

	for(var/thing in glob.burning_atoms)
		var/atom/atom = thing
		if(atom && !Deleted(atom))
			atom.ProcessFire()
		CHECK_SUSPEND

	for(var/thing in glob.ignite_atoms)
		var/atom/burning = thing
		glob.ignite_atoms -= thing

		if(burning.IsFlammable() && !burning.IsOnFire())
			burning.Ignite()

		for(var/other_thing in burning.contents)
			var/atom/atom = other_thing
			if(atom.IsFlammable() && !atom.IsOnFire())
				atom.Ignite()
			CHECK_SUSPEND
		CHECK_SUSPEND

/datum/daemon/fire/Status()
	return "[glob.burning_atoms.len]"