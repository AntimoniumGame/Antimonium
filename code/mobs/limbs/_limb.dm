/obj/item/limb
	name = "limb"
	icon = 'icons/objects/items/limbs/_default.dmi'
	contact_size = 5
	weight = 10
	sharpness = 1
	attack_verbs = list("bludgeons", "batters", "whacks")
	default_material_path = /datum/material/meat
	flags = FLAG_SIMULATED | FLAG_IS_EDIBLE | FLAG_THROWN_SPIN | FLAG_ANCHORED // FLAG_ANCHORED is because, for some reason, you can pick the fucking limbs up during spawn.

	var/limb_name
	var/root_limb = FALSE
	var/limb_id
	var/mob/human/owner
	var/obj/item/limb/parent
	var/list/children = list()
	var/vital = FALSE
	var/grasp_name
	var/grasp_plural
	var/not_moving = FALSE

/obj/item/limb/proc/SetNotMoving(var/_not_moving, var/update_icon = FALSE)
	not_moving = _not_moving
	if(not_moving)
		owner.UpdateIcon()

/obj/item/limb/GetWornIcon(var/inventory_slot)
	if(inventory_slot != "mob")
		return ..()
	return image(icon = icon, icon_state = (not_moving ? "mob_static" : "mob"))

/obj/item/limb/GetInvIcon()
	return GetWornIcon("world")

/obj/item/limb/New(var/mob/human/_owner, var/_name, var/_icon, var/_limb_id, var/_parent, var/_root, var/_vital, var/_size, var/_grasp_name, var/_grasp_plural)
	..(_owner)
	owner = _owner
	limb_name = _name
	name = limb_name
	icon = _icon
	limb_id = _limb_id
	vital = _vital
	root_limb = _root
	grasp_name = _grasp_name ? _grasp_name : name
	grasp_plural = _grasp_plural
	owner.limbs += src
	contact_size = _size  // Reusing contact_size as an 'effective limb
	weight = contact_size // size' for the purposes of bleeding etc.

	if(_limb_id == BP_HEAD)
		remains_type = owner.skull_type
		remains_multi = FALSE

	if(_parent)
		parent = owner.GetLimb(_parent)
		parent.children += src

/obj/item/limb/UpdateStrings()
	name = limb_name

/obj/item/limb/proc/IsBleeding()
	if(wounds.len)
		for(var/thing in wounds)
			var/datum/wound/wound = thing
			if(wound.wound_type == WOUND_CUT && wound.bleed_amount)
				return TRUE
	return FALSE

/obj/item/limb/proc/IsDextrous(var/silent)
	if(!silent) owner.Notify("Your [grasp_name] [grasp_plural ? "aren't" : "isn't"] dextrous enough for that.")
	return FALSE
