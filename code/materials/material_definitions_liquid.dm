/datum/material/water
	general_name = "water"
	solid_name = "ice"
	gas_name = "steam"
	melting_point =  TEMPERATURE_FREEZING
	boiling_point =  TEMPERATURE_BOILING
	colour = PALE_BLUE
	turf_effect_overlay = "gleam"
	turf_floor_icon = 'icons/turfs/water_floor.dmi'

/datum/material/water/OnTurfEntry(var/turf/crossing, var/atom/movable/crosser)
	if(crosser.IsOnFire())
		crossing.NotifyNearby("A cloud of hissing steam rises up as \the [crosser] enters \the [crossing]!", MESSAGE_VISIBLE)
		crosser.Extinguish()

/datum/material/water/OnTurfAttack(var/turf/target, var/mob/user, var/obj/item/prop)
	if(prop.IsOnFire())
		target.NotifyNearby("A cloud of hissing steam rises up as \the [user] dips \the [prop] into the water!", MESSAGE_VISIBLE)
		prop.Extinguish()
		return TRUE
	. = ..()

/datum/material/water/blood
	general_name = "blood"
	solid_name = "frozen blood"
	gas_name = "vaporized blood"
	colour = DARK_RED

/datum/material/water/ichor
	general_name = "ichor"
	solid_name = "frozen ichor"
	gas_name = "vaporized ichor"
	colour = PALE_GREEN
