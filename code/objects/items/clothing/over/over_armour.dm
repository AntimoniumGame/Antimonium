/obj/item/clothing/over/breastplate
	name = "breastplate"
	icon = 'icons/objects/clothing/armour/breastplate.dmi'
	default_material_path = /datum/material/metal/iron
	mob_can_equip = list(/mob/human, /mob/animal/dog)
	alternate_icons = list(/mob/animal/dog = 'icons/objects/clothing/armour/breastplate_dog.dmi')

/obj/item/clothing/over/leather_armour
	name = "chestpiece"
	icon = 'icons/objects/clothing/armour/leather.dmi'
	default_material_path = /datum/material/cloth/leather
	body_coverage = list(BP_GROIN, BP_CHEST, BP_LEFT_ARM, BP_RIGHT_ARM)
	mob_can_equip = list(/mob/human, /mob/animal/dog)
	alternate_icons = list(/mob/animal/dog = 'icons/objects/clothing/armour/leather_dog.dmi')

/obj/item/clothing/over/chainmail
	name = "hauberk"
	icon = 'icons/objects/clothing/armour/chainmail.dmi'
	default_material_path = /datum/material/metal/iron
	body_coverage = list(BP_GROIN, BP_CHEST, BP_LEFT_ARM, BP_RIGHT_ARM)
	mob_can_equip = list(/mob/human, /mob/animal/dog)
	alternate_icons = list(/mob/animal/dog = 'icons/objects/clothing/armour/chainmail_dog.dmi')

/obj/item/clothing/over/full_plate
	name = "full plate"
	icon = 'icons/objects/clothing/armour/full_plate.dmi'
	default_material_path = /datum/material/metal/iron
