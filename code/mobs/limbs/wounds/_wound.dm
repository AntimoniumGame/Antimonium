/datum/wound
	var/obj/item/limb/owner
	var/wound_type = WOUND_BRUISE
	var/depth = 1
	var/size = 1
	var/bleed_amount = 0
	var/left_by
	var/bandaged

/datum/wound/New(var/obj/item/limb/_owner, var/_wound_type, var/_wound_depth, var/_wound_size, var/attacked_with)
	..()
	owner = _owner
	wound_type = _wound_type
	depth = _wound_depth
	size = _wound_size
	if(wound_type == WOUND_CUT)
		bleed_amount = round((size * depth) / 10)
	left_by = attacked_with
