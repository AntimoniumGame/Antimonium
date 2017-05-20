/obj/structure/brazier
	name = "brazier"
	icon = 'icons/objects/structures/brazier.dmi'
	hit_sound = 'sounds/effects/ding1.wav'
	weight = 5
	flags = FLAG_SIMULATED | FLAG_FLAMMABLE
	var/base_temperature = TEMPERATURE_WOOD_FIRE

// temp until fuel is added
/obj/structure/brazier/is_flammable()
	return TRUE
// end temp

/obj/structure/brazier/New()
	..()
	ignite()
	processing_objects += src
	next_burn_sound = rand(10,20)

/obj/structure/brazier/destroy()
	processing_objects -= src
	. = ..()

/obj/structure/brazier/process_temperature()
	if(temperature < base_temperature)
		temperature = base_temperature
	..()

/obj/structure/brazier/process_fire()
	..()
	radiate_heat(base_temperature, 0)
