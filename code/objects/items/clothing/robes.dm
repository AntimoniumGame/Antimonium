/obj/item/clothing/robes
	name = "robes"
	icon = 'icons/objects/clothing/robes/robes_white.dmi'
	slot_flags = SLOT_FLAG_OVER
	colour_to_icon = list(
		WHITE =         'icons/objects/clothing/robes/robes_white.dmi',
		PALE_BROWN =    'icons/objects/clothing/robes/robes_yellow.dmi',
		BRIGHT_YELLOW = 'icons/objects/clothing/robes/robes_yellow.dmi',
		BRIGHT_ORANGE = 'icons/objects/clothing/robes/robes_yellow.dmi',
		PALE_GREEN =    'icons/objects/clothing/robes/robes_green.dmi',
		DARK_GREEN =    'icons/objects/clothing/robes/robes_green.dmi',
		BROWN_GREEN =   'icons/objects/clothing/robes/robes_brown.dmi',
		PALE_BLUE =     'icons/objects/clothing/robes/robes_blue.dmi',
		BRIGHT_BLUE =   'icons/objects/clothing/robes/robes_blue.dmi',
		DARK_BLUE =     'icons/objects/clothing/robes/robes_blue.dmi',
		PALE_GREY =     'icons/objects/clothing/robes/robes_grey.dmi',
		DARK_GREY =     'icons/objects/clothing/robes/robes_grey.dmi',
		DARK_RED =      'icons/objects/clothing/robes/robes_red.dmi',
		BROWN_ORANGE =  'icons/objects/clothing/robes/robes_red.dmi',
		DARK_BROWN =    'icons/objects/clothing/robes/robes_brown.dmi',
		DARK_PURPLE =   'icons/objects/clothing/robes/robes_purple.dmi',
		BLACK =         'icons/objects/clothing/robes/robes_black.dmi'
		)

/obj/item/clothing/robes/GetWornIcon(var/inventory_slot)
	if(inventory_slot == SLOT_OVER)
		var/image/I = image(icon, "tail")
		I.overlays += ..()
		return I
	return ..()

/obj/item/clothing/robes/yellow
	icon = 'icons/objects/clothing/robes/robes_yellow.dmi'
	dyed = BRIGHT_YELLOW

/obj/item/clothing/robes/green
	icon = 'icons/objects/clothing/robes/robes_green.dmi'
	dyed = DARK_GREEN

/obj/item/clothing/robes/blue
	icon = 'icons/objects/clothing/robes/robes_blue.dmi'
	dyed = BRIGHT_BLUE

/obj/item/clothing/robes/grey
	icon = 'icons/objects/clothing/robes/robes_grey.dmi'
	dyed = PALE_GREY

/obj/item/clothing/robes/black
	icon = 'icons/objects/clothing/robes/robes_black.dmi'
	dyed = BLACK

/obj/item/clothing/robes/brown
	icon = 'icons/objects/clothing/robes/robes_brown.dmi'
	dyed = DARK_BROWN

/obj/item/clothing/robes/red
	icon = 'icons/objects/clothing/robes/robes_red.dmi'
	dyed = DARK_RED

/obj/item/clothing/robes/purple
	icon = 'icons/objects/clothing/robes/robes_purple.dmi'
	dyed = DARK_PURPLE

/obj/item/clothing/robes/occultist
	icon = 'icons/objects/clothing/robes/robes_occultist.dmi'
	dyed = BLACK
