/obj/ui/radial_button/structure
	var/build_struct

/obj/ui/radial_button/structure/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu, var/_build_struct)
	build_struct = _build_struct
	..(_owner, _parent_menu)

/obj/ui/radial_button/structure/UpdateAppearance()
	var/obj/structure/struct = build_struct
	icon = initial(struct.icon)
	icon_state = initial(struct.icon_state)
	..()

/obj/ui/radial_button/structure/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		var/obj/item/prop = clicker.GetEquipped(slot)
		if(prop == parent_menu.GetAdditionalMenuData())
			parent_menu.ReceiveInput(build_struct)

/obj/ui/radial_button/structure/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		var/obj/item/prop = clicker.GetEquipped(slot)
		if(prop == parent_menu.GetAdditionalMenuData())
			parent_menu.ReceiveInput(build_struct)

/obj/ui/radial_menu/prop/structures
	menu_type = RADIAL_MENU_STRUCTURES
	button_type = /obj/ui/radial_button/structure

/obj/ui/radial_menu/prop/structures/ReceiveInput(var/thing_input)
	if(locate(/obj/structure) in get_turf(source_atom))
		owner.Notify("<span class='warning'>There is a structure occupying that location.</span>")
		QDel(src)
		return
	var/obj/item/stack/building_with = source_atom
	if(istype(building_with))
		if(building_with.GetAmount() < building_with.material.GetStructureCost())
			owner.Notify("<span class='warning'>There is not enough in \the [src] to build that.</span>")
			return
		var/atom/thing = new thing_input(get_turf(source_atom), material_path = building_with.material.type)
		owner.NotifyNearby("<span class='notice'>\The [owner] builds \a [thing].</span>")
		building_with.Remove(building_with.material.GetStructureCost())
	QDel(src)
