/obj/structure/table
	name = "table"
	icon = 'icons/objects/structures/table.dmi'
	icon_state = "wooden_table"
	weight = 50
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_ANCHORED

/obj/structure/table/AttackedBy(var/mob/user, var/obj/item/thing)
	if(user.intent.selecting == INTENT_HELP && user.DropItem(thing))
		if(!thing || Deleted(thing)) //grabs
			return
		thing.ForceMove(src.loc)
		user.NotifyNearby("\The [user] places \the [thing] on \the [src].")
	else
		..()
