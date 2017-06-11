/obj/ui/radial_button/show_atom
	var/atom/refer_atom

/obj/ui/radial_button/show_atom/GetAtom()
	return refer_atom

/obj/ui/radial_button/show_atom/Destroy()
	refer_atom = null
	. = ..()

/obj/ui/radial_button/show_atom/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu, var/atom/_refer_atom)
	refer_atom = _refer_atom
	name = refer_atom.name
	..(_owner, _parent_menu)

/obj/ui/radial_button/show_atom/UpdateAppearance()
	var/obj/item/prop = refer_atom
	if(istype(prop))
		appearance = prop.GetInvIcon()
		draw_shadow_underlay = TRUE
	else
		appearance = refer_atom
		var/atom/movable/atom = refer_atom
		if(!istype(atom) || atom.draw_shadow_underlay)
			draw_shadow_underlay = TRUE
	..()

/obj/ui/radial_button/show_atom/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.LeftClickedOn(clicker, slot)
	parent_menu.UpdateButtons()

/obj/ui/radial_button/show_atom/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.RightClickedOn(clicker, slot)
	parent_menu.UpdateButtons()

/obj/ui/radial_button/show_atom/MiddleClickedOn(var/mob/clicker)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.MiddleClickedOn(clicker)
