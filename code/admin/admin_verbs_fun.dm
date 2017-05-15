/datum/admin_permissions/fun
	associated_permission = PERMISSIONS_FUN
	verbs = list(
		/client/proc/doggo,
		/client/proc/gibself,
		/client/proc/dress_self
		)

/client/proc/gibself()

	set name = "Gibself"
	set category = "Fun"

	blood_splatter(mob, mob)
	var/mob/victim = mob
	while(victim.limbs.len > 1)
		var/obj/item/limb/limb = victim.limbs[pick(victim.limbs - BP_CHEST)]
		limb.sever_limb()
		sleep(-1)
	if(mob != victim)
		qdel(victim)

/client/proc/doggo()

	set name = "Doggo"
	set category = "Fun"

	var/mob/animal/doggo = new(get_turf(mob))
	if(!doggo.loc)
		doggo.force_move(locate(3,3,1))

	var/old_mob = mob
	doggo.key = mob.key
	doggo.update_strings()
	doggo.notify("Woof woof.")
	qdel(old_mob)


/client/proc/dress_self()

	set name = "Dress Self"
	set category = "Fun"

	var/mob/human/human = mob
	if(!istype(human))
		anotify("Only works on humans, sorry.")
		return

	if(!mob.get_equipped(SLOT_UPPER_BODY))
		mob.collect_item_or_del(new /obj/item/clothing/shirt(), SLOT_UPPER_BODY)
	if(!mob.get_equipped(SLOT_LOWER_BODY))
		mob.collect_item_or_del(new /obj/item/clothing/pants(), SLOT_LOWER_BODY)
	if(!mob.get_equipped(SLOT_FEET))
		mob.collect_item_or_del(new /obj/item/clothing/boots(), SLOT_FEET)

	anotify("Mob dressed.")