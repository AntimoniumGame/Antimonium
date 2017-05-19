/obj/structure/brazier
	name = "brazier"
	icon = 'icons/objects/structures/brazier.dmi'
	hit_sound = 'sounds/effects/ding1.wav'
	weight = 5

	light_color = BRIGHT_ORANGE
	light_power = 8
	light_range = 4

	flags = FLAG_SIMULATED | FLAG_FLAMMABLE

	var/next_burn_sound = 0
	var/base_temperature = TEMPERATURE_WOOD_FIRE

/obj/structure/brazier/ignite(var/mob/user)
	. = ..()
	set_light()

/obj/structure/brazier/New()
	..()
	ignite()
	processing_objects += src
	next_burn_sound = rand(10,20)

/obj/structure/brazier/update_icon()
	overlays.Cut()
	if(on_fire)
		overlays += image('icons/images/fire.dmi', "mid")
		set_light()
	else
		kill_light()

/obj/structure/brazier/destroy()
	processing_objects -= src
	. = ..()

var/list/burn_sounds = list('sounds/effects/fire1.wav','sounds/effects/fire2.wav','sounds/effects/fire3.wav')
/obj/structure/brazier/process_temperature()
	if(temperature < base_temperature)
		temperature = base_temperature
	..()

/obj/structure/brazier/process()
	if(on_fire)
		if(world.time > next_burn_sound)
			next_burn_sound = world.time + rand(40,50)
			play_local_sound(src, pick(burn_sounds), 15, frequency = -1)
		radiate_heat(base_temperature, 0)
		radiate_heat(TEMPERATURE_WARM, 3)
