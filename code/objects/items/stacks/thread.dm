/obj/item/stack/thread
	name = "thread"
	contact_size = 5
	icon = 'icons/objects/items/thread/thread_grey.dmi'
	singular_name = "thread"
	plural_name =   "threads"
	stack_name =    "spool"
	default_material_path = /datum/material/cloth
	can_craft_with = FALSE
	var/is_thread = TRUE

	var/dyed = WHITE
	var/list/colour_to_icon = list(
		WHITE =         'icons/objects/items/thread/thread_white.dmi',
		PALE_BROWN =    'icons/objects/items/thread/thread_yellow.dmi',
		BRIGHT_YELLOW = 'icons/objects/items/thread/thread_yellow.dmi',
		BRIGHT_ORANGE = 'icons/objects/items/thread/thread_yellow.dmi',
		PALE_GREEN =    'icons/objects/items/thread/thread_green.dmi',
		DARK_GREEN =    'icons/objects/items/thread/thread_green.dmi',
		BROWN_GREEN =   'icons/objects/items/thread/thread_green.dmi',
		PALE_BLUE =     'icons/objects/items/thread/thread_blue.dmi',
		BRIGHT_BLUE =   'icons/objects/items/thread/thread_blue.dmi',
		DARK_BLUE =     'icons/objects/items/thread/thread_blue.dmi',
		PALE_GREY =     'icons/objects/items/thread/thread_grey.dmi',
		DARK_GREY =     'icons/objects/items/thread/thread_grey.dmi',
		BLACK =         'icons/objects/items/thread/thread_grey.dmi',
		DARK_RED =      'icons/objects/items/thread/thread_red.dmi',
		BROWN_ORANGE =  'icons/objects/items/thread/thread_red.dmi',
		DARK_BROWN =    'icons/objects/items/thread/thread_red.dmi',
		DARK_PURPLE =   'icons/objects/items/thread/thread_purple.dmi'
		)

/obj/item/stack/thread/Initialize()
	. = ..()
	if(material)
		dyed = material.colour
	UpdateIcon()

/obj/item/stack/thread/cloth
	name = "cloth"
	contact_size = 5
	icon = 'icons/objects/items/thread/cloth_grey.dmi'
	singular_name = "bolt"
	plural_name =   "bolts"
	stack_name =    "stack"
	default_material_path = /datum/material/cloth
	can_craft_with = TRUE

	colour_to_icon = list(
			WHITE =         'icons/objects/items/thread/cloth_white.dmi',
			PALE_BROWN =    'icons/objects/items/thread/cloth_yellow.dmi',
			BRIGHT_YELLOW = 'icons/objects/items/thread/cloth_yellow.dmi',
			BRIGHT_ORANGE = 'icons/objects/items/thread/cloth_yellow.dmi',
			PALE_GREEN =    'icons/objects/items/thread/cloth_green.dmi',
			DARK_GREEN =    'icons/objects/items/thread/cloth_green.dmi',
			BROWN_GREEN =   'icons/objects/items/thread/cloth_green.dmi',
			PALE_BLUE =     'icons/objects/items/thread/cloth_blue.dmi',
			BRIGHT_BLUE =   'icons/objects/items/thread/cloth_blue.dmi',
			DARK_BLUE =     'icons/objects/items/thread/cloth_blue.dmi',
			PALE_GREY =     'icons/objects/items/thread/cloth_grey.dmi',
			DARK_GREY =     'icons/objects/items/thread/cloth_grey.dmi',
			BLACK =         'icons/objects/items/thread/cloth_grey.dmi',
			DARK_RED =      'icons/objects/items/thread/cloth_red.dmi',
			BROWN_ORANGE =  'icons/objects/items/thread/cloth_red.dmi',
			DARK_BROWN =    'icons/objects/items/thread/cloth_red.dmi',
			DARK_PURPLE =   'icons/objects/items/thread/cloth_purple.dmi'
			)

/obj/item/stack/thread/cloth/Attacking(var/mob/user, var/mob/target)
	if(user.intent.selecting == INTENT_HELP && !is_thread)
		var/obj/item/limb/limb = target.limbs_by_key[user.target_zone.selecting]
		if(!istype(limb))
			user.Notify("<span class='warning'>\The [target] is missing that limb.</span>")
		else
			for(var/thing in limb.wounds)
				var/datum/wound/wound = thing
				if(wound.CanBandage())
					wound.Bandage()
					user.NotifyNearby("<span class='notice'>\The [user] bandages [wound.GetDescriptor()] on \the [target]'s [limb.name].</span>")
					Remove(1)
					return TRUE
			user.Notify("<span class='warning'>\The [target]'s [limb.name] bears no treatable wounds.</span>")
		return TRUE
	. = ..()