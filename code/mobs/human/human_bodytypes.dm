/datum/human_bodytype
	var/name
	var/list/icons_by_limb = list()

/datum/human_bodytype/proc/GetIcon(var/bodypart, var/given_gender)
	if(!bodypart || !icons_by_limb[bodypart]) return 'icons/mobs/_default.dmi'
	var/list/bodypart_icons = icons_by_limb[bodypart]
	if(!given_gender || !bodypart_icons[given_gender]) given_gender = "default"
	return bodypart_icons[given_gender]

/datum/human_bodytype/dark
	name = "Dark"
	icons_by_limb = list(
		BP_CHEST =      list("default" = 'icons/mobs/limbs/human/dark/chest_f.dmi', MALE = 'icons/mobs/limbs/human/dark/chest_m.dmi'),
		BP_GROIN =      list("default" = 'icons/mobs/limbs/human/dark/groin_f.dmi', MALE = 'icons/mobs/limbs/human/dark/groin_m.dmi'),
		BP_LEFT_ARM =   list("default" = 'icons/mobs/limbs/human/dark/left_arm.dmi'),
		BP_RIGHT_ARM =  list("default" = 'icons/mobs/limbs/human/dark/right_arm.dmi'),
		BP_HEAD =       list("default" = 'icons/mobs/limbs/human/dark/head.dmi'),
		BP_LEFT_HAND =  list("default" = 'icons/mobs/limbs/human/dark/left_hand.dmi'),
		BP_RIGHT_HAND = list("default" = 'icons/mobs/limbs/human/dark/right_hand.dmi'),
		BP_LEFT_LEG =   list("default" = 'icons/mobs/limbs/human/dark/left_leg.dmi'),
		BP_RIGHT_LEG =  list("default" = 'icons/mobs/limbs/human/dark/right_leg.dmi'),
		BP_LEFT_FOOT =  list("default" = 'icons/mobs/limbs/human/dark/left_foot.dmi'),
		BP_RIGHT_FOOT = list("default" = 'icons/mobs/limbs/human/dark/right_foot.dmi')
	)

/datum/human_bodytype/pallid
	name = "Pallid"
	icons_by_limb = list(
		BP_CHEST =      list("default" = 'icons/mobs/limbs/human/pallid/chest_f.dmi', MALE = 'icons/mobs/limbs/human/pallid/chest_m.dmi'),
		BP_GROIN =      list("default" = 'icons/mobs/limbs/human/pallid/groin_f.dmi', MALE = 'icons/mobs/limbs/human/pallid/groin_m.dmi'),
		BP_LEFT_ARM =   list("default" = 'icons/mobs/limbs/human/pallid/left_arm.dmi'),
		BP_RIGHT_ARM =  list("default" = 'icons/mobs/limbs/human/pallid/right_arm.dmi'),
		BP_HEAD =       list("default" = 'icons/mobs/limbs/human/pallid/head.dmi'),
		BP_LEFT_HAND =  list("default" = 'icons/mobs/limbs/human/pallid/left_hand.dmi'),
		BP_RIGHT_HAND = list("default" = 'icons/mobs/limbs/human/pallid/right_hand.dmi'),
		BP_LEFT_LEG =   list("default" = 'icons/mobs/limbs/human/pallid/left_leg.dmi'),
		BP_RIGHT_LEG =  list("default" = 'icons/mobs/limbs/human/pallid/right_leg.dmi'),
		BP_LEFT_FOOT =  list("default" = 'icons/mobs/limbs/human/pallid/left_foot.dmi'),
		BP_RIGHT_FOOT = list("default" = 'icons/mobs/limbs/human/pallid/right_foot.dmi')
	)

/datum/human_bodytype/pale
	name = "Pale"
	icons_by_limb = list(
		BP_CHEST =      list("default" = 'icons/mobs/limbs/human/pale/chest_f.dmi', MALE = 'icons/mobs/limbs/human/pale/chest_m.dmi'),
		BP_GROIN =      list("default" = 'icons/mobs/limbs/human/pale/groin_f.dmi', MALE = 'icons/mobs/limbs/human/pale/groin_m.dmi'),
		BP_LEFT_ARM =   list("default" = 'icons/mobs/limbs/human/pale/left_arm.dmi'),
		BP_RIGHT_ARM =  list("default" = 'icons/mobs/limbs/human/pale/right_arm.dmi'),
		BP_HEAD =       list("default" = 'icons/mobs/limbs/human/pale/head.dmi'),
		BP_LEFT_HAND =  list("default" = 'icons/mobs/limbs/human/pale/left_hand.dmi'),
		BP_RIGHT_HAND = list("default" = 'icons/mobs/limbs/human/pale/right_hand.dmi'),
		BP_LEFT_LEG =   list("default" = 'icons/mobs/limbs/human/pale/left_leg.dmi'),
		BP_RIGHT_LEG =  list("default" = 'icons/mobs/limbs/human/pale/right_leg.dmi'),
		BP_LEFT_FOOT =  list("default" = 'icons/mobs/limbs/human/pale/left_foot.dmi'),
		BP_RIGHT_FOOT = list("default" = 'icons/mobs/limbs/human/pale/right_foot.dmi')
	)