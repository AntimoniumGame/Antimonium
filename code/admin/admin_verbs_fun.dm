/datum/admin_permissions/fun
	associated_permission = PERMISSIONS_FUN
	verbs = list(
		/client/proc/ChangeMob,
		/client/proc/Gibself,
		/client/proc/Decayself,
		/client/proc/DressSelf
	)

/client/proc/Decayself()

	set name = "Decay Self"
	set category = "Fun"

	mob.Decay()

/client/proc/Gibself()

	set name = "Gib Self"
	set category = "Fun"

	mob.Gib()

/client/proc/ChangeMob()

	set name = "Change Mob"
	set category = "Fun"

	var/mob_type = input("Select a mob type.") as null|anything in typesof(/mob/animal)
	if(!mob_type)
		return

	var/mob/doggo = new mob_type(get_turf(mob))
	if(!doggo.loc)
		doggo.ForceMove(locate(3,3,1))

	var/old_mob = mob
	doggo.key = mob.key
	doggo.UpdateStrings()
	doggo.Notify("You are now \a [initial(doggo.name)].")
	QDel(old_mob, "doggo'd")

/client/proc/DressSelf()

	set name = "Dress Self"
	set category = "Fun"

	var/mob/human/human = mob
	if(!istype(human))
		Anotify("Only works on humans, sorry.")
		return

	var/datum/outfit/chosen_outfit = input("Which outfit do you wish to use?") as null|anything in glob.all_outfits
	if(chosen_outfit)
		chosen_outfit.EquipTo(human)
		Anotify("Mob dressed.")
