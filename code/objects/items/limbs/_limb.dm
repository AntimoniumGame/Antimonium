/obj/item/limb
	name = "limb"
	icon = 'icons/objects/items/limbs/_default.dmi'
	var/mob/human/owner
	var/obj/item/limb/parent
	var/list/children = list()

/obj/item/limb/New(var/mob/human/_owner, var/_name, var/_icon, var/_parent)
	..()
	owner = _owner
	name = _name
	icon = _icon
	if(_parent)
		parent = owner.limbs[_parent]
		parent.children += src

//todo
/obj/item/limb/stance
/obj/item/limb/grasp