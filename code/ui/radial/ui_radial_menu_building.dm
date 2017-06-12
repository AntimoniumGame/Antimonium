/obj/ui/radial_button/building
	var/build_turf

/obj/ui/radial_button/building/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu, var/_build_turf)
	build_turf = _build_turf
	..(_owner, _parent_menu)

/obj/ui/radial_button/building/UpdateAppearance()
	var/turf/turf = build_turf
	icon = initial(turf.icon)
	icon_state = initial(turf.icon_state)
	..()

/obj/ui/radial_button/building/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		var/obj/item/prop = clicker.GetEquipped(slot)
		if(prop == parent_menu.GetAdditionalMenuData())
			parent_menu.ReceiveInput(build_turf)

/obj/ui/radial_button/building/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		var/obj/item/prop = clicker.GetEquipped(slot)
		if(prop == parent_menu.GetAdditionalMenuData())
			parent_menu.ReceiveInput(build_turf)

/obj/ui/radial_menu/prop/building
	menu_type = RADIAL_MENU_BUILDING
	button_type = /obj/ui/radial_button/building

/obj/ui/radial_menu/prop/building/ReceiveInput(var/thing_input)

	if(locate(/obj/structure/foundation) in get_turf(source_atom))
		owner.Notify("<span class='warning'>There is already a foundation in that location.</span>")
		QDel(src)
		return

	if(locate(/obj/structure) in get_turf(source_atom))
		owner.Notify("<span class='warning'>There is a structure occupying that location.</span>")
		QDel(src)
		return

	var/obj/item/stack/building_with = source_atom
	if(istype(building_with))

		if(building_with.GetAmount() < building_with.material.GetTurfCost())
			owner.Notify("<span class='warning'>You need at least [building_with.material.GetTurfCost()] [building_with.plural_name] to build that.")
			return

		owner.NotifyNearby("<span class='notice'>\The [owner] lays out a foundation.</span>")
		new /obj/structure/foundation(get_turf(building_with), building_with.material.type, thing_input, new type(null, building_with.material.type, building_with.material.GetTurfCost()))
		building_with.Remove(building_with.material.GetTurfCost())
	QDel(src)
