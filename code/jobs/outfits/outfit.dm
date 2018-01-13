/* Valid equip slots for equip_to_slot:
	SLOT_FEET
	SLOT_LOWER_BODY
	SLOT_UPPER_BODY
	SLOT_OVER
	SLOT_BACK
	SLOT_LEFT_RING
	SLOT_RIGHT_RING
	SLOT_HANDS
	SLOT_FACE
	SLOT_EYES
	SLOT_NECK
	SLOT_HAT
	SLOT_LEFT_HAND
	SLOT_RIGHT_HAND
*/

var/list/all_outfits = list()

/proc/InitializeOutfits()
	for(var/outfit in typesof(/datum/outfit))
		var/datum/outfit/check_outfit = outfit
		if(!initial(check_outfit.name))
			continue
		all_outfits += GetUniqueDataByPath(outfit)

/datum/outfit
	var/name = "Drifter"
	var/list/equip_to_slot = list(
		SLOT_FEET = /obj/item/clothing/boots,
		SLOT_LOWER_BODY = /obj/item/clothing/pants,
		SLOT_UPPER_BODY = /obj/item/clothing/shirt
	)

/datum/outfit/proc/EquipTo(var/mob/equipping_mob)
	if(!equipping_mob || !equipping_mob.inventory_slots || !equipping_mob.inventory_slots.len)
		return FALSE
	for(var/equip_slot in equip_to_slot)
		var/obj/ui/inv/inv_slot = equipping_mob.inventory_slots[equip_slot]
		if(istype(inv_slot) && !inv_slot.holding)
			var/equipping = equip_to_slot[equip_slot]
			equipping_mob.CollectItem(new equipping, equip_slot)
	return TRUE
