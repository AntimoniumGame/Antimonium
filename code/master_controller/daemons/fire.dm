var/list/burning_atoms = list()
var/list/ignite_atoms = list()

/datum/daemon/fire
	name = "fire"
	delay = 10
	initial_offset = 10

/datum/daemon/fire/do_work()

	for(var/thing in burning_atoms)
		var/atom/atom = thing
		if(atom && !deleted(atom))
			atom.process_fire()
		check_suspend()

	for(var/thing in ignite_atoms)
		var/atom/burning = thing
		ignite_atoms -= thing
		for(var/other_thing in burning.contents)
			var/atom/atom = other_thing
			if(atom.is_flammable() && !atom.is_on_fire())
				atom.ignite()
			check_suspend()
		check_suspend()

/datum/daemon/fire/status()
	return "[burning_atoms.len]"