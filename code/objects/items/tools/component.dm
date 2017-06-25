/obj/item/component
	name = "axe head"
	icon = 'icons/objects/items/components/axe.dmi'
	var/builds_to = /obj/item/weapon/axe
	var/builds_with = /obj/item/stack/sticks

/obj/item/component/AttackedBy(var/mob/user, var/obj/item/prop)
	. = ..()
	if(!. && material && istype(prop, builds_with) && prop.material)
		var/obj/item/stack/stack = prop
		var/obj/item/weapon/built = new builds_to(get_turf(src), material_path = material.type, secondary_material_path = stack.material.type)
		NotifyNearby("<span class='notice'>\The [user] builds \a [built] from \the [src] and \a [stack.singular_name].</span>")
		stack.Remove(1)
		QDel(src)
		return TRUE

/obj/item/component/construction_hammer
	name = "construction hammer head"
	icon = 'icons/objects/items/components/hammer_construction.dmi'
	builds_to = /obj/item/weapon/construction_hammer

/obj/item/component/chisel
	name = "chisel blade"
	icon = 'icons/objects/items/components/chisel.dmi'
	builds_to = /obj/item/weapon/chisel

/obj/item/component/mallet
	name = "mallet head"
	icon = 'icons/objects/items/components/hammer_mallet.dmi'
	builds_to = /obj/item/weapon/mallet

/obj/item/component/forge_hammer
	name = "forging hammer head"
	icon = 'icons/objects/items/components/hammer_forge.dmi'
	builds_to = /obj/item/weapon/hammer

/obj/item/component/handsaw
	name = "sawblade"
	icon = 'icons/objects/items/components/handsaw.dmi'
	builds_to = /obj/item/weapon/handsaw

/obj/item/component/pickaxe
	name = "pickaxe head"
	icon = 'icons/objects/items/components/pickaxe.dmi'
	builds_to = /obj/item/weapon/pickaxe

/obj/item/component/shovel
	name = "shovel blade"
	icon = 'icons/objects/items/components/shovel.dmi'
	builds_to = /obj/item/weapon/shovel

/obj/item/component/sword
	name = "sword blade"
	icon = 'icons/objects/items/components/sword.dmi'
	builds_to = /obj/item/weapon/sword