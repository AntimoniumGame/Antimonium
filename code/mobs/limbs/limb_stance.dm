/obj/item/limb/stance
	var/support_value = 1

/obj/item/limb/stance/Initialize()
	..()
	if(limb_id == BP_RIGHT_LEG || limb_id == BP_LEFT_LEG || limb_id == BP_CHEST || limb_id == BP_GROIN)
		support_value = 2

/obj/item/limb/stance/HandleSeverEffects()
	owner.UpdateStance()

/obj/item/limb/stance/HandleBreakEffects()
	owner.UpdateStance()
