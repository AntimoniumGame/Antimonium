/obj/structure/table
	name = "table"
	icon = 'icons/objects/structures/table.dmi'
	icon_state = "wooden_table"
	weight = 50
	default_material_path = /datum/material/wood
	flags = FLAG_SIMULATED | FLAG_ANCHORED

/obj/structure/table/attacked_by(var/mob/user, var/obj/item/thing)
	if(user.intent.selecting == INTENT_HELP && user.drop_item(thing))
		if(!thing || deleted(thing)) //grabs
			return
		thing.force_move(src.loc)
		user.notify_nearby("\The [user] places \the [thing] on \the [src].")
	else
		..()
