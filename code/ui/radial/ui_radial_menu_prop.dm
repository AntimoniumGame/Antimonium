/obj/ui/radial_menu/prop
	menu_type = RADIAL_MENU_CRAFTING
	button_type = /obj/ui/radial_button/crafting
	var/obj/item/crafting_prop

/obj/ui/radial_menu/prop/New(var/mob/_owner, var/list/_source_atom, var/obj/item/_crafting_prop)
	crafting_prop = _crafting_prop
	..(_owner, _source_atom)

/obj/ui/radial_menu/prop/GetAdditionalMenuData()
	return crafting_prop
