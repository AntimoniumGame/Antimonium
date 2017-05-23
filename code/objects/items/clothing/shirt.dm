/obj/item/clothing/shirt
	name = "shirt"
	icon = 'icons/objects/clothing/shirt.dmi'
	slot_flags = SLOT_FLAG_UPPER_BODY
	shadow_size = 3

// Hardcoding this for now.
/obj/item/clothing/shirt/GetWornIcon(var/inventory_slot)
	if(inventory_slot == SLOT_UPPER_BODY)
		var/mob/owner = loc
		if(istype(owner))
			var/image/I = image(null)
			var/obj/item/limb/arm = owner.limbs[BP_LEFT_HAND]
			if(istype(arm) && arm.holding)
				I.overlays += image(icon, "left_shoulder_filled")
			else
				I.overlays += image(icon, "left_shoulder")

			arm = owner.limbs[BP_RIGHT_HAND]
			if(istype(arm) && arm.holding)
				I.overlays += image(icon, "right_shoulder_filled")
			else
				I.overlays += image(icon, "right_shoulder")
			return I
	return ..()
