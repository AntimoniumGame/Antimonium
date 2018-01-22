/obj/item/clothing/over/breastplate
	name = "breastplate"
	icon = 'icons/objects/clothing/armour/breastplate.dmi'
	default_material_path = /datum/material/metal/iron
	armour = list(WOUND_CUT = 3, WOUND_BURN = 1, WOUND_BRUISE = 3)
	mob_can_equip = list(/mob/human, /mob/animal/dog)
	alternate_icons = list(/mob/animal/dog = 'icons/objects/clothing/armour/breastplate_dog.dmi')

/obj/item/clothing/over/leather_armour
	name = "chestpiece"
	icon = 'icons/objects/clothing/armour/leather.dmi'
	default_material_path = /datum/material/cloth/leather
	body_coverage = list(BP_GROIN, BP_CHEST, BP_LEFT_ARM, BP_RIGHT_ARM)
	armour = list(WOUND_CUT = 2, WOUND_BURN = 2, WOUND_BRUISE = 1)
	mob_can_equip = list(/mob/human, /mob/animal/dog)
	alternate_icons = list(/mob/animal/dog = 'icons/objects/clothing/armour/leather_dog.dmi')

/obj/item/clothing/over/chainmail
	name = "hauberk"
	icon = 'icons/objects/clothing/armour/chainmail.dmi'
	default_material_path = /datum/material/metal/iron
	body_coverage = list(BP_GROIN, BP_CHEST, BP_LEFT_ARM, BP_RIGHT_ARM)
	armour = list(WOUND_CUT = 3, WOUND_BURN = 0, WOUND_BRUISE = 1)
	mob_can_equip = list(/mob/human, /mob/animal/dog)
	alternate_icons = list(/mob/animal/dog = 'icons/objects/clothing/armour/chainmail_dog.dmi')
