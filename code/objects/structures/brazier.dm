/obj/structure/brazier
	name = "brazier"
	icon = 'icons/objects/structures/brazier.dmi'
	hit_sound = 'sounds/effects/ding1.wav'
	weight = 5

	light_color = BRIGHT_ORANGE
	light_power = 10
	light_range = 5

	var/burning = TRUE
	var/next_burn_sound = 0

/obj/structure/brazier/New()
	..()
	set_light()
	processing_objects += src
	next_burn_sound = rand(10,20)

/obj/structure/brazier/destroy()
	processing_objects -= src
	. = ..()

var/list/burn_sounds = list('sounds/effects/fire1.wav','sounds/effects/fire2.wav','sounds/effects/fire3.wav')

/obj/structure/brazier/process_temperature()
	if(temperature < TEMPERATURE_WOOD_FIRE)
		temperature = TEMPERATURE_WOOD_FIRE
	..()

/obj/structure/brazier/process()
	if(burning)
		if(world.time > next_burn_sound)
			next_burn_sound = world.time + rand(40,50)
			play_local_sound(src, pick(burn_sounds), 15, frequency = -1)
		radiate_heat(TEMPERATURE_WOOD_FIRE, 0)
		radiate_heat(TEMPERATURE_WARM, 3)
