/obj/item/limb
	name = "limb"
	icon = 'icons/objects/items/limbs/_default.dmi'

	var/root_limb = FALSE
	var/limb_id
	var/mob/human/owner
	var/obj/item/limb/parent
	var/list/children = list()

/obj/item/limb/New(var/mob/human/_owner, var/_name, var/_icon, var/_limb_id, var/_parent)
	..()
	owner = _owner
	name = _name
	icon = _icon
	limb_id = _limb_id
	if(_parent)
		parent = owner.limbs[_parent]
		parent.children += src

/obj/item/limb/root
	root_limb = TRUE
