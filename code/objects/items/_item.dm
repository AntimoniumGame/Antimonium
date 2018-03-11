/obj/item

	name = "item"
	icon_state = "world"
	icon = 'icons/objects/items/_default.dmi'
	draw_shadow_underlay = TRUE

	var/quality = 1
	var/slot_flags = 0
	var/contact_size = 1
	var/weight = 1
	var/sharpness = 1
	var/list/attack_verbs = list("bashes")
	var/name_prefix
	var/associated_skill
	var/occupies_two_hands = FALSE
	var/has_variant_inhand_icon = FALSE

	var/hit_sound = 'sounds/effects/punch1.ogg'
	var/collect_sound = 'sounds/effects/click1.ogg'
	var/equip_sound = 'sounds/effects/rustle1.ogg'

/obj/item/TakeDamage(var/dam, var/source)
	damage = max(min(damage+dam, max_damage),0)
	if(damage == max_damage && !Deleted(src))
		Destroyed()
	..()

/obj/item/proc/Destroyed()
	QDel(src, "destroyed")

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
			user.NotifyNearby("<span class='danger'>\The [user] empties \the [src].</span>", MESSAGE_VISIBLE)
		return TRUE
	return ((flags & FLAG_IS_EDIBLE) && Eaten(user))

/obj/item/proc/GetInHandAppearanceAtom()
	return src

/obj/item/proc/GetWornIcon(var/inventory_slot)

	// Hardcoding this for now. I am sure a better system will come along in the future.
	var/list/limb_check_list = list()
	if(inventory_slot == SLOT_UPPER_BODY || inventory_slot == SLOT_OVER)
		limb_check_list = list(BP_LEFT_ARM, BP_RIGHT_ARM)
	else if(inventory_slot == SLOT_LOWER_BODY)
		limb_check_list = list(BP_LEFT_LEG, BP_RIGHT_LEG)
	else if(inventory_slot == SLOT_RIGHT_RING)
		limb_check_list = list(BP_RIGHT_HAND)
	else if(inventory_slot == SLOT_LEFT_RING)
		limb_check_list = list(BP_LEFT_HAND)
	else if(inventory_slot == SLOT_HANDS)
		limb_check_list = list(BP_LEFT_HAND, BP_RIGHT_HAND)
	else if(inventory_slot == SLOT_FEET)
		limb_check_list = list(BP_LEFT_FOOT, BP_RIGHT_FOOT)

	var/image/I
	if(inventory_slot == SLOT_LEFT_HAND || inventory_slot == SLOT_RIGHT_HAND || inventory_slot == SLOT_MOUTH)
		if(inventory_slot != SLOT_MOUTH && (occupies_two_hands || has_variant_inhand_icon))
			I = image(icon = icon, icon_state = (inventory_slot == SLOT_LEFT_HAND ? "inhand_left" : "inhand_right"))
		else
			I = new() //todo cache this
			I.appearance = GetInHandAppearanceAtom()
			I.layer = FLOAT_LAYER
			var/matrix/M = matrix()
			M.Scale(1, -1)
			var/offset_x = 0
			var/offset_y = -8
			if(inventory_slot == SLOT_RIGHT_HAND)
				offset_x = -8
			else if(inventory_slot == SLOT_LEFT_HAND)
				offset_x = 8
				M.Scale(-1, 1)
			else if(inventory_slot == SLOT_MOUTH)
				M.Turn(90)
				offset_x = -5
				offset_y = -6

			M.Translate(offset_x, offset_y)
			I.transform = M

	if(!I && limb_check_list.len)
		var/mob/owner = loc
		if(istype(owner))
			I = image(null)
			for(var/limb in limb_check_list)
				var/obj/item/limb/bp = owner.GetLimb(limb)
				if(istype(bp))
					if(bp.not_moving)
						I.overlays += image(icon, "[limb]_static")
					else
						I.overlays += image(icon, "[limb]")
				else
					I.overlays += image(icon, "[limb]_missing")
	if(!I)
		I = image(icon = icon, icon_state = inventory_slot)

	if(inventory_slot != "held")
		var/mob/holder = loc
		if(I && istype(holder))
			if(holder.clothing_offset_x || holder.clothing_offset_y)
				var/matrix/M = I.transform ? I.transform : matrix()
				M.Translate(holder.clothing_offset_x, holder.clothing_offset_y)
				I.transform = M
	. = I

/obj/item/proc/GetProneWornIcon(var/inventory_slot)

#ifdef DEBUG
	if(!("[inventory_slot]_prone" in icon_states(icon)))
		world.log << "Missing prone icon state '[inventory_slot]_prone' for [type]."
		return
#endif

	var/image/I = image(icon = icon, icon_state = "[inventory_slot]_prone")
	if(inventory_slot == SLOT_HAT)
		var/matrix/M = matrix()
		M.Translate(0, 16)
		I.transform = M
	return I

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

/obj/item/GetMonetaryWorth()
	var/amt = GetBaseMonetaryWorth()
	. = ..()
	if(quality)
		. += amt * quality
