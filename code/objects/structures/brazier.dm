/obj/structure/brazier
	name = "brazier"
	icon = 'icons/objects/structures/brazier.dmi'
	hit_sound = 'sounds/effects/ding1.ogg'
	weight = 5
	flags = FLAG_SIMULATED | FLAG_FLAMMABLE
	var/base_temperature = TEMPERATURE_WOOD_FIRE

// temp until fuel is added
/obj/structure/brazier/IsFlammable()
	return TRUE
// end temp

/obj/structure/brazier/Initialize()
	..()
	next_burn_sound = rand(10,20)

/obj/structure/brazier/Initialize()
	..()
	Ignite()
	processing_objects += src

/obj/structure/brazier/Destroy()
	processing_objects -= src
	. = ..()

/obj/structure/brazier/ProcessTemperature()
	if(temperature < base_temperature)
		temperature = base_temperature
	..()

/obj/structure/brazier/ProcessFire()
	..()
	RadiateHeat(temperature, 0)

/obj/structure/brazier/GetFireIcon()
	var/image/I = image('icons/images/fire.dmi', "mid")
	I.layer = MOB_LAYER + 0.9
	return I

/obj/structure/brazier/HandleFireDamage()
	return
