/mob/human/face_atom()
	if(!prone || dragged)
		. = ..()

/mob/human/left_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_LEFT_HAND, BP_LEFT_HAND))
		..()

/mob/human/right_click_on(var/atom/thing, var/ctrl, var/alt)
	if(!try_general_interaction(thing, ctrl, alt, SLOT_RIGHT_HAND, BP_RIGHT_HAND))
		..()

/mob/human/proc/try_general_interaction(var/atom/thing, var/ctrl, var/alt, var/slot, var/limb)
	face_atom(thing)
	if(ctrl && thing.is_grabbable())
		if(check_hand(limb))
			grab_atom(thing, slot)
		return TRUE
	else if(alt && (istype(thing, /turf) || istype(thing.loc, /turf)))
		var/obj/item/throwing = get_equipped(slot)
		if(throwing && throwing.throw_at(src, thing))
			return TRUE
	return FALSE

/mob/human/middle_clicked_on(var/mob/clicker)
	if(src == clicker || is_adjacent_to(get_turf(src), get_turf(clicker)))
		clicker.notify_nearby("\The [clicker] begins checking [src == clicker ? src.themself() : "\the [src]"] over for injuries.")
		for(var/limb_id in limbs)
			var/obj/item/limb/limb = limbs[limb_id]
			var/result_line = "<b>[capitalize(limb.name)]:</b> "
			if(limb.wounds.len)
				var/first = TRUE
				for(var/thing in limb.wounds)
					var/data/wound/wound = thing
					if(first)
						first = FALSE
					else
						result_line += ", "
					result_line += wound.get_descriptor()
			else
				result_line += "nothing"
			clicker.notify("[result_line].")
	else
		..()

/mob/human/proc/grab_atom(var/atom/movable/grabbing, var/grabbing_with)

	if(get_equipped(grabbing_with))
		notify("You need a free hand to grab \the [grabbing].")
		return

	var/obj/item/grab/grab = new(src, grabbing)
	collect_item(grab, grabbing_with)
	to_chat(world, "\The [grab.owner] grabbed \the [grab.grabbed]!")
