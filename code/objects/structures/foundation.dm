/obj/structure/foundation
	name = "foundation"
	icon = 'icons/objects/structures/foundation.dmi'
	density = 0
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	layer = TURF_LAYER+0.95
	var/obj/item/stack/resources
	var/build_type

/obj/structure/foundation/Destroy()
	if(resources)
		QDel(resources)
		resources = null
	. = ..()

/obj/structure/foundation/New(var/newloc, var/material_path, var/_build_type, var/obj/item/stack/_resources)
	build_type = _build_type
	resources = _resources
	if(resources)
		resources.ForceMove(src)
	..(newloc, material_path)

/obj/structure/foundation/UpdateStrings()
	..()
	var/atom/thing = build_type
	name = "foundation - [material.GetName()] [initial(thing.name)]"

/obj/structure/foundation/AttackedBy(var/mob/user, var/obj/item/prop)
	if(prop.associated_skill & SKILL_ARCHITECTURE)
		if(user.intent.selecting == INTENT_HELP)
			var/list/buildings = material.GetBuildableTurfs(src)
			if(buildings.len)
				var/select_type = input("Select a building type.") as null|anything in buildings
				if(select_type)
					NotifyNearby("<span class='notice'>\The [user] adjusts \the [src] with \the [prop].</span>")
					build_type = select_type
				return TRUE
		else
			resources.ForceMove(get_turf(src))
			resources = null
			NotifyNearby("<span class='warning'>\The [user] knocks down \the [src].</span>")
			QDel(src)
			return TRUE

	if(prop.associated_skill & SKILL_CONSTRUCTION)
		var/atom/built = new build_type(get_turf(src), material.type)
		NotifyNearby("<span class='notice'>\The [user] finishes building \the [built] with \the [prop].</span>")
		QDel(src)
		return TRUE
	. = ..()