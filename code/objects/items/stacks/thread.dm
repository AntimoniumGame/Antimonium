/obj/item/stack/thread
	name = "thread"
	contact_size = 5
	icon = 'icons/objects/items/thread/thread_grey.dmi'
	singular_name = "thread"
	plural_name =   "thread"
	stack_name =    "spool"
	default_material_path = /datum/material/cloth
	var/dyed = WHITE

/obj/item/stack/thread/Initialize()
	. = ..()
	if(material)
		dyed = material.colour
	UpdateIcon()

/obj/item/stack/thread/UpdateIcon(var/list/supplying)
	switch(dyed)
		if(WHITE)
			icon = 'icons/objects/items/thread/thread_white.dmi'
		if(PALE_BROWN, BRIGHT_YELLOW, BRIGHT_ORANGE)
			icon = 'icons/objects/items/thread/thread_yellow.dmi'
		if(PALE_GREEN, DARK_GREEN, BROWN_GREEN)
			icon = 'icons/objects/items/thread/thread_green.dmi'
		if(PALE_BLUE, BRIGHT_BLUE, DARK_BLUE)
			icon = 'icons/objects/items/thread/thread_blue.dmi'
		if(PALE_GREY, DARK_GREY, BLACK)
			icon = 'icons/objects/items/thread/thread_grey.dmi'
		if(DARK_RED, BROWN_ORANGE, DARK_BROWN)
			icon = 'icons/objects/items/thread/thread_red.dmi'
		if(DARK_PURPLE)
			icon = 'icons/objects/items/thread/thread_purple.dmi'
	..(supplying)
