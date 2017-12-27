/datum/admin_permissions/fun
	associated_permission = PERMISSIONS_FUN
	verbs = list(
		/client/proc/ChangeMob,
		/client/proc/Gibself,
		/client/proc/DressSelf,
		/client/proc/ProduceColouredStates
		)

/client/proc/Gibself()

	set name = "Gibself"
	set category = "Fun"

	mob.Gib()

/client/proc/ChangeMob()

	set name = "Change Mob"
	set category = "Fun"

	var/mob_type = input("Select a mob type.") as null|anything in typesof(/mob/animal)
	if(!mob_type)
		return

	var/mob/doggo = new mob_type(get_turf(mob))
	if(!doggo.loc)
		doggo.ForceMove(locate(3,3,1))

	var/old_mob = mob
	doggo.key = mob.key
	doggo.UpdateStrings()
	doggo.Notify("You are now \a [initial(doggo.name)].")
	QDel(old_mob, "doggo'd")

/client/proc/DressSelf()

	set name = "Dress Self"
	set category = "Fun"

	var/mob/human/human = mob
	if(!istype(human))
		Anotify("Only works on humans, sorry.")
		return

	var/datum/outfit/chosen_outfit = input("Which outfit do you wish to use?") as null|anything in all_outfits
	if(chosen_outfit)
		chosen_outfit.EquipTo(human)
		Anotify("Mob dressed.")

/client/proc/ProduceColouredStates()

	set name = "Produce Coloured Icon States"
	set category = "Fun" // Probably should be 'utility'

	var/list/icons_to_compile = list(
		/obj/item/clothing/shirt,
		/obj/item/clothing/pants
		)

	var/list/template_colours = list(
		DARK_GREY,
		PALE_GREY,
		GREY_BLUE,
		PALE_BLUE
		)

	var/list/colour_maps = list(
		list(
			"ident" = "yellow",
			"colours" = list(
				GREEN_BROWN,
				PALE_BROWN,
				BRIGHT_ORANGE,
				BRIGHT_YELLOW
				)
			),
		list(
			"ident" = "grey",
			"colours" = list(
				DARK_GREY,
				PALE_GREY,
				LIGHT_GREY,
				GREY_BLUE
				)
			),
		list(
			"ident" = "green",
			"colours" = list(
				DARK_BLUE_GREY,
				GREEN_BROWN,
				DARK_GREEN,
				BLUE_GREEN
				)
			),
		list(
			"ident" = "brown",
			"colours" = list(
				DARK_PURPLE,
				GREEN_BROWN,
				DARK_BROWN,
				PALE_BROWN
				)
			),
		list(
			"ident" = "red",
			"colours" = list(
				DARK_PURPLE,
				DARK_RED,
				PALE_RED,
				PINK
				)
			),
		list(
			"ident" = "purple",
			"colours" = list(
				NAVY_BLUE,
				DARK_PURPLE,
				INDIGO,
				PURPLE
				)
			),
		list(
			"ident" = "blue",
			"colours" = list(
				DARK_BLUE_GREY,
				INDIGO,
				BLUE,
				LIGHT_BLUE
				)
			)
		)

	Dnotify("Compiling icon recolours.")

	for(var/upath in icons_to_compile)
		var/atom/_atom = upath
		var/icon/_icon_static = icon(icon = initial(_atom.icon), moving = FALSE)
		var/icon/_icon_moving = icon(icon = initial(_atom.icon), moving = TRUE)

		for(var/list/colour_map in colour_maps)
			var/icon/compiled_icon = icon()
			var/ident = colour_map["ident"]
			var/list/map_colours = colour_map["colours"]

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

			var/dumpstr = "dump\\[initial(_atom.name)]_[ident].dmi"
			Dnotify("State recolour complete, dumped to [dumpstr].")
			fcopy(compiled_icon, dumpstr)