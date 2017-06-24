/obj/item
	name = "item"
	icon_state = "world"
	icon = 'icons/objects/items/_default.dmi'
	draw_shadow_underlay = TRUE

	var/slot_flags = 0
	var/contact_size = 1
	var/weight = 1
	var/sharpness = 1
	var/list/attack_verbs = list("bashes")
	var/name_prefix
	var/associated_skill

	var/hit_sound = 'sounds/effects/punch1.ogg'
	var/collect_sound = 'sounds/effects/click1.ogg'
	var/equip_sound = 'sounds/effects/rustle1.ogg'

/obj/item/Initialize()
	..()
	if(!pixel_x && !pixel_y)
		RandomizePixelOffset()

/obj/item/proc/GetHeatInsulation()
	return (material ? material.thermal_insulation : 0)

/obj/item/GetWeight()
	return weight

/obj/item/UpdateValues()
	sharpness = initial(sharpness)
	weight =    initial(weight)
	if(material)
		sharpness *= material.GetSharpnessMod()
		weight    *= material.GetWeightMod()

/obj/item/UpdateStrings()
	if(material)
		if(name_prefix)
			name = "[name_prefix] [material.GetDescriptor()] [initial(name)]"
		else
			name = "[material.GetDescriptor()] [initial(name)]"
	else
		if(name_prefix)
			name = "[name_prefix] [initial(name)]"
		else
			name = "[initial(name)]"

// this should be called last in the supercall sequence as it should update its holder last (if it has one)
/obj/item/UpdateIcon()
	..() // hence why we do the supercall to /obj/UpdateIcon() first, then run the holder update code
	var/mob/holder = loc
	if(istype(holder))
		holder.UpdateInventory()
		holder.UpdateIcon()

/obj/item/proc/Eaten(var/mob/user)
	return FALSE

/obj/item/proc/Use(var/mob/user)
	if(user.intent.selecting == INTENT_HARM && IsReagentContainer())
		if(!contains_reagents.len)
			user.Notify("<span class='warning'>\The [src] is empty.</span>")
		else
			for(var/thing in contains_reagents)
				var/obj/prop = thing
				prop.ForceMove(get_turf(user))
			contains_reagents.Cut()
			current_reagent_volume = 0
			UpdateIcon()
			user.NotifyNearby("<span class='danger'>\The [user] empties \the [src].</span>")
		return TRUE
	return ((flags & FLAG_IS_EDIBLE) && Eaten(user))

/obj/item/proc/GetWornIcon(var/inventory_slot)
	// Hardcoding this for now. I am sure a better system will come along in the future.
	var/list/limb_check_list = list()
	if(inventory_slot == SLOT_UPPER_BODY)
		limb_check_list = list(BP_LEFT_ARM, BP_RIGHT_ARM)
	else if(inventory_slot == SLOT_LOWER_BODY)
		limb_check_list = list(BP_LEFT_LEG, BP_RIGHT_LEG)
	else if(inventory_slot == SLOT_HANDS)
		limb_check_list = list(BP_LEFT_HAND, BP_RIGHT_HAND)
	else if(inventory_slot == SLOT_FEET)
		limb_check_list = list(BP_LEFT_FOOT, BP_RIGHT_FOOT)

	if(limb_check_list.len)
		var/mob/owner = loc
		if(istype(owner))
			var/image/I = image(null)
			for(var/limb in limb_check_list)
				var/obj/item/limb/bp = owner.GetLimb(limb)
				if(istype(bp))
					if(bp.not_moving)
						I.overlays += image(icon, "[limb]_static")
					else
						I.overlays += image(icon, "[limb]")
				else
					I.overlays += image(icon, "[limb]_missing")
			return I
	return image(icon = icon, icon_state = inventory_slot)


/obj/item/proc/GetProneWornIcon(var/inventory_slot)
	return image(icon = icon, icon_state = "prone_[inventory_slot]")

/obj/item/proc/GetInvIcon()
	return GetWornIcon("held")

/obj/item/Destroy()
	if(istype(loc, /mob))
		var/mob/owner = loc
		owner.DropItem(src)
	else if(istype(loc, /obj/structure))
		var/obj/structure/struct = loc
		if(istype(struct.contains, /list))
			struct.contains -= src
	. = ..()

/obj/item/GetAmount()
	return initial(weight)

/obj/item/AttackedBy(var/mob/user, var/obj/item/prop)
	if((prop.associated_skill & SKILL_ALCHEMY) && Grind(user))
		return TRUE
	. = ..()
