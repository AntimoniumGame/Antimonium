/obj/item/grab
	icon = 'icons/objects/items/grab.dmi'
	simulated = FALSE
	var/mob/human/owner
	var/atom/movable/grabbed

/obj/item/grab/New(var/mob/human/_owner, var/atom/movable/_grabbed)
	..()
	owner = _owner
	owner.active_grabs += src
	grabbed = _grabbed
	name = "grip on \the [grabbed]"
	processing_items += src

/obj/item/grab/after_dropped()
	qdel(src)

/obj/item/grab/destroy()
	if(owner)
		owner.active_grabs -= src
		if(owner == loc)
			owner.drop_item(src)
	grabbed = null
	owner = null
	processing_items -= src
	. = ..()

/obj/item/grab/process()
	check_state()

/obj/item/grab/proc/check_state()
	if(!owner || loc != owner || !grabbed || !is_adjacent_to(grabbed, owner))
		qdel(src)

