/obj/ui/radial_button/crafting
	var/datum/crafting_recipe/recipe

/obj/ui/radial_button/crafting/New(var/mob/_owner, var/obj/ui/radial_menu/_parent_menu, var/datum/crafting_recipe/_recipe)
	recipe = _recipe
	..(_owner, _parent_menu)

/obj/ui/radial_button/crafting/GetAtom()
	return recipe.example_atom

/obj/ui/radial_button/crafting/UpdateAppearance()
	var/obj/item/prop = recipe.example_atom
	if(istype(prop))
		appearance = prop.GetInvIcon()
		draw_shadow_underlay = TRUE
	else
		appearance = recipe.example_atom
		var/atom/movable/atom = recipe.example_atom
		if(!istype(atom) || atom.draw_shadow_underlay)
			draw_shadow_underlay = TRUE
	..()

/obj/ui/radial_button/crafting/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.)
		var/obj/item/prop = clicker.GetEquipped(slot)
		if(prop == parent_menu.GetAdditionalMenuData())
			parent_menu.ReceiveInput(recipe)

/obj/ui/radial_button/crafting/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.)
		var/obj/item/prop = clicker.GetEquipped(slot)
		if(prop == parent_menu.GetAdditionalMenuData())
			parent_menu.ReceiveInput(recipe)

/obj/ui/radial_menu/crafting
	menu_type = RADIAL_MENU_CRAFTING
	button_type = /obj/ui/radial_button/crafting
	var/obj/item/crafting_prop

/obj/ui/radial_menu/crafting/New(var/mob/_owner, var/list/_source_atom, var/obj/item/_crafting_prop)
	crafting_prop = _crafting_prop
	..(_owner, _source_atom)

/obj/ui/radial_menu/crafting/GetAdditionalMenuData()
	return crafting_prop

/obj/ui/radial_menu/crafting/ReceiveInput(var/thing_input)
	var/datum/crafting_recipe/crecipe = thing_input
	if(!crecipe || !source_atom || !crecipe.CanCraft(get_turf(source_atom), source_atom) || !IsAdjacentTo(owner, source_atom))
		return FALSE
	var/obj/item/result = crecipe.Craft(get_turf(source_atom), source_atom)
	owner.DoAttackAnimation(get_turf(source_atom))
	owner.NotifyNearby("<span class='notice'>\The [owner] [crecipe.action_third_person] \a [crecipe.result_name] out of [result.material.GetName()].</span>")
	UpdateButtons()
