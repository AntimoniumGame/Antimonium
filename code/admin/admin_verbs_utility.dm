// These are included in Debug verbs for the sake of not making a whole new category. Tick
// this file only if you want to use the procs, there's zero reason to use it on a live server.

/datum/admin_permissions/debug/New()
	verbs |= /client/proc/ProduceSkinTones
	verbs |= /client/proc/ProduceColouredStates
	..()

var/list/clothing_colour_maps = list(
	"template" = list(
		DARK_GREY,
		PALE_GREY,
		GREY_BLUE,
		PALE_BLUE
		),
	"steel" = list(
		NAVY_BLUE,
		DARK_PURPLE,
		PALE_GREY,
		GREY_BLUE
	),
	"yellow" = list(
		GREEN_BROWN,
		PALE_BROWN,
		BRIGHT_ORANGE,
		BRIGHT_YELLOW
	),
	"black" = list(
		NAVY_BLUE,
		DARK_BLUE_GREY,
		DARK_GREY,
		PALE_GREY
	),
	"grey" = list(
		DARK_GREY,
		PALE_GREY,
		LIGHT_GREY,
		GREY_BLUE
	),
	"green" = list(
		DARK_BLUE_GREY,
		GREEN_BROWN,
		DARK_GREEN,
		BLUE_GREEN
	),
	"brown" = list(
		DARK_PURPLE,
		GREEN_BROWN,
		DARK_BROWN,
		PALE_BROWN
	),
	"red" = list(
		DARK_PURPLE,
		DARK_RED,
		PALE_RED,
		PINK
	),
	"purple" = list(
		NAVY_BLUE,
		DARK_PURPLE,
		INDIGO,
		PURPLE
	),
	"blue" = list(
		DARK_BLUE_GREY,
		INDIGO,
		BLUE,
		LIGHT_BLUE
	)
)

/client/proc/ProduceColouredStates()

	set name = "Produce Coloured Icon States"
	set category = "Utility"

	var/list/icon_choices = list(
		/obj/item/clothing/shirt,
		/obj/item/clothing/pants,
		/obj/item/clothing/shorts,
		/obj/item/clothing/boots,
		/obj/item/clothing/gloves,
		/obj/item/clothing/gloves/fingerless,
		/obj/item/clothing/over/robes,
		/obj/item/clothing/over/apron,
		"All",
		"Done"
		)

	var/list/icons_to_compile = list()
	var/choice = input("Which path(s) do you wish to compile icons for?") as null|anything in icon_choices
	while(choice)
		if(choice == "All")
			icon_choices -= "All"
			icon_choices -= "Done"
			for(var/nchoice in icon_choices)
				var/atom/_atom = nchoice
				icons_to_compile[replacetext(replacetext(initial(_atom.name), " ", "_"),"'", "")] = list(icon(icon = initial(_atom.icon), moving = FALSE), icon(icon = initial(_atom.icon), moving = TRUE))
			break
		else if(choice == "Done")
			break
		else
			icon_choices -= choice
			var/atom/_atom = choice
			icons_to_compile[replacetext(replacetext(initial(_atom.name), " ", "_"),"'", "")] = list(icon(icon = initial(_atom.icon), moving = FALSE), icon(icon = initial(_atom.icon), moving = TRUE))
			choice = input("Which path(s) do you wish to compile icons for?") as null|anything in icon_choices

	if(icons_to_compile && icons_to_compile.len)
		CompileColouredIcons("dump\\clothing", icons_to_compile, clothing_colour_maps)

var/list/skin_colour_maps = list(
	"template" = list(
		DARK_BROWN,
		PALE_BROWN,
		BRIGHT_ORANGE,
		DARK_PINK,
		PALE_PINK
	),
	"pallid" = list(
		INDIGO,
		DARK_BLUE,
		GREY_BLUE,
		PALE_BLUE,
		WHITE
	),
	"dark" = list(
		NAVY_BLUE,
		DARK_PURPLE,
		DARK_BROWN,
		PALE_BROWN,
		BROWN_ORANGE
	)
)

/client/proc/ProduceSkinTones()

	set name = "Produce Skin Tones"
	set category = "Utility"

	CompileColouredIcons("dump\\bodytypes", list(
		"[BP_CHEST]" =      list(
			icon(icon = 'icons/mobs/limbs/human/pale/chest.dmi',      moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/chest.dmi',      moving = TRUE)
		),
		"[BP_GROIN]" =      list(
			icon(icon = 'icons/mobs/limbs/human/pale/groin.dmi',      moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/groin.dmi',      moving = TRUE)
		),
		"[BP_LEFT_ARM]" =   list(
			icon(icon = 'icons/mobs/limbs/human/pale/left_arm.dmi',   moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/left_arm.dmi',   moving = TRUE)
		),
		"[BP_RIGHT_ARM]" =  list(
			icon(icon = 'icons/mobs/limbs/human/pale/right_arm.dmi',  moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/right_arm.dmi',  moving = TRUE)
		),
		"[BP_HEAD]" =       list(
			icon(icon = 'icons/mobs/limbs/human/pale/head.dmi',       moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/head.dmi',       moving = TRUE)
		),
		"[BP_LEFT_HAND]" =  list(
			icon(icon = 'icons/mobs/limbs/human/pale/left_hand.dmi',  moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/left_hand.dmi',  moving = TRUE)
		),
		"[BP_RIGHT_HAND]" = list(
			icon(icon = 'icons/mobs/limbs/human/pale/right_hand.dmi', moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/right_hand.dmi', moving = TRUE)
		),
		"[BP_LEFT_LEG]" =   list(
			icon(icon = 'icons/mobs/limbs/human/pale/left_leg.dmi',   moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/left_leg.dmi',   moving = TRUE)
		),
		"[BP_RIGHT_LEG]" =  list(
			icon(icon = 'icons/mobs/limbs/human/pale/right_leg.dmi',  moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/right_leg.dmi',  moving = TRUE)
		),
		"[BP_LEFT_FOOT]" =  list(
			icon(icon = 'icons/mobs/limbs/human/pale/left_foot.dmi',  moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/left_foot.dmi',  moving = TRUE)
		),
		"[BP_RIGHT_FOOT]" = list(
			icon(icon = 'icons/mobs/limbs/human/pale/right_foot.dmi', moving = FALSE),
			icon(icon = 'icons/mobs/limbs/human/pale/right_foot.dmi', moving = TRUE)
		)
	), skin_colour_maps, dump_by_ident = TRUE)

/client/proc/CompileColouredIcons(var/dumppath = "dump", var/list/icons_to_compile, var/list/colour_maps, var/dump_by_ident = FALSE)

	Dnotify("Compiling icon recolours.")

	for(var/dumpname in icons_to_compile)

		var/list/icon_data = icons_to_compile[dumpname]
		var/icon/_icon_static = icon_data[1]
		var/icon/_icon_moving = icon_data[2]

		for(var/ident in colour_maps)
			if(ident == "template") continue
			var/list/template_colours = colour_maps["template"]
			var/list/map_colours = colour_maps[ident]
			var/icon/compiled_icon = icon()

			for(var/_icon_state in icon_states(_icon_static))
				var/icon/new_icon = icon(icon = _icon_static, icon_state = _icon_state)
				for(var/i = 1;i<=template_colours.len;i++)
					new_icon.SwapColor(template_colours[i], map_colours[i])
				compiled_icon.Insert(new_icon, _icon_state)

			for(var/_icon_state in icon_states(_icon_moving))
				var/icon/new_icon = icon(icon = _icon_moving, icon_state = _icon_state)
				for(var/i = 1;i<=template_colours.len;i++)
					new_icon.SwapColor(template_colours[i], map_colours[i])
				compiled_icon.Insert(new_icon, _icon_state, moving = TRUE)

			var/dumpstr
			if(dump_by_ident)
				dumpstr = "[dumppath]\\[ident]\\[dumpname].dmi"
			else
				dumpstr = "[dumppath]\\[dumpname]\\[dumpname]_[ident].dmi"
			Dnotify("State recolour for [dumpname] complete, dumped to [dumpstr].")
			fcopy(compiled_icon, dumpstr)