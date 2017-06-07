var/list/burning_atoms = list()
var/list/ignite_atoms = list()

/datum/daemon/fire
	name = "fire"
	delay = 10
	initial_offset = 10

/datum/daemon/fire/DoWork()

	for(var/thing in burning_atoms)
		var/atom/atom = thing
		if(atom && !Deleted(atom))
			atom.ProcessFire()
		CheckSuspend()

	for(var/thing in ignite_atoms)
		var/atom/burning = thing
		ignite_atoms -= thing

		if(burning.IsFlammable() && !burning.IsOnFire())
			burning.Ignite()

		for(var/other_thing in burning.contents)
			var/atom/atom = other_thing
			if(atom.IsFlammable() && !atom.IsOnFire())
				atom.Ignite()
			CheckSuspend()
		CheckSuspend()

/datum/daemon/fire/Status()
	return "[burning_atoms.len]"