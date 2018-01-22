/obj/ui/radial_button/mob_strip
	icon = 'icons/images/ui.dmi'
	icon_state = "square_base"
	var/atom/refer_atom

/obj/ui/radial_button/mob_strip/GetAtom()
	return refer_atom

/obj/ui/radial_button/mob_strip/Destroy()
	refer_atom = null
	. = ..()

/obj/ui/radial_button/mob_strip/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu, var/atom/_refer_atom)
	refer_atom = _refer_atom
	name = refer_atom.name
	..(_owner, _parent_menu)

/obj/ui/radial_button/mob_strip/UpdateAppearance()
	overlays.Cut()
	var/obj/item/prop = refer_atom
	if(istype(prop))
		var/image/I = new()
		I.appearance = prop.GetInvIcon()
		I.plane = plane
		I.layer = FLOAT_LAYER
		overlays += I
		draw_shadow_underlay = TRUE
	else
		var/image/I = new()
		I.appearance = refer_atom
		I.plane = plane
		I.layer = FLOAT_LAYER
		overlays += I
		var/atom/movable/atom = refer_atom
		if(!istype(atom) || atom.draw_shadow_underlay)
			draw_shadow_underlay = TRUE
	..()

/obj/ui/radial_button/mob_strip/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		clicker.NotifyNearby("<span class='danger'>\The [clicker] is trying to remove \the [refer_atom] from \the [refer_atom.loc]!</span>")
		if(clicker.DoAfter(30, refer_atom.loc, list("loc", "dir"), list("loc")))
			var/mob/M = refer_atom.loc
			if(istype(M)) M.DropItem(refer_atom)
	parent_menu.UpdateButtons()

/obj/ui/radial_button/mob_strip/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.RightClickedOn(clicker, slot)
	parent_menu.UpdateButtons()

/obj/ui/radial_button/mob_strip/MiddleClickedOn(var/mob/clicker)
	. = ..()
	if(.  && refer_atom && !Deleted(refer_atom) && IsAdjacentTo(clicker, refer_atom))
		refer_atom.MiddleClickedOn(clicker)
