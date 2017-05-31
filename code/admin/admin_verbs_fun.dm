/datum/admin_permissions/fun
	associated_permission = PERMISSIONS_FUN
	verbs = list(
		/client/proc/ChangeMob,
		/client/proc/Gibself,
		/client/proc/DressSelf
		)

/client/proc/Gibself()

	set name = "Gibself"
	set category = "Fun"

	Splatter(mob, mob.blood_material)
	var/mob/victim = mob
	while(victim.limbs.len > 1)
		var/obj/item/limb/limb = victim.limbs[pick(victim.limbs - BP_CHEST)]
		limb.SeverLimb()
		sleep(-1)
	if(mob != victim)
		QDel(victim)

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
	QDel(old_mob)

/client/proc/DressSelf()

	set name = "Dress Self"
	set category = "Fun"

	var/mob/human/human = mob
	if(!istype(human))
		Anotify("Only works on humans, sorry.")
		return

	if(!mob.GetEquipped(SLOT_UPPER_BODY))
		mob.CollectItemOrDel(new /obj/item/clothing/shirt(), SLOT_UPPER_BODY)
	if(!mob.GetEquipped(SLOT_LOWER_BODY))
		mob.CollectItemOrDel(new /obj/item/clothing/pants(), SLOT_LOWER_BODY)
	if(!mob.GetEquipped(SLOT_FEET))
		mob.CollectItemOrDel(new /obj/item/clothing/boots(), SLOT_FEET)
	if(!mob.GetEquipped(SLOT_HANDS))
		mob.CollectItemOrDel(new /obj/item/clothing/gloves(), SLOT_HANDS)

	Anotify("Mob dressed.")