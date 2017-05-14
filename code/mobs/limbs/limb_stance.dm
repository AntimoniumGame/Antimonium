/obj/item/limb/stance
	var/support_value = 1

/obj/item/limb/stance/New(var/mob/human/_owner, var/_name, var/_icon, var/_limb_id, var/_parent, var/_root, var/_vital, var/_size)
	..()
	if(limb_id == BP_RIGHT_LEG || limb_id == BP_LEFT_LEG)
		support_value = 2

/obj/item/limb/stance/handle_sever_effects()
	owner.update_stance()

/obj/item/limb/stance/handle_break_effects()
	owner.update_stance()
