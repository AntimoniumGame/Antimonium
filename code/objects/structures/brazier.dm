/obj/structure/brazier
	name = "brazier"
	icon = 'icons/objects/structures/brazier.dmi'
	hit_sound = 'sounds/effects/ding1.wav'
	weight = 5

	light_color = BRIGHT_ORANGE
	light_power = 10
	light_range = 5

	var/lit = TRUE
	var/next_burn_sound = 0

/obj/structure/brazier/New()
	..()
	set_light()
	processing_objects += src
	next_burn_sound = rand(10,20)

/obj/structure/brazier/update_icon()
	overlays.Cut()
	if(lit)
		overlays += image('icons/images/fire.dmi', "mid")
		set_light()
	else
		kill_light()

/obj/structure/brazier/destroy()
	processing_objects -= src
	. = ..()

/obj/structure/brazier/attacked_by(var/mob/user, var/obj/item/thing)
	if(istype(thing, /obj/item/torch))
		var/obj/item/torch/torch = thing
		if(!torch.lit && lit)
			user.notify_nearby("\The [user] lights \the [thing] in \the [src].")
			torch.lit = TRUE
			torch.update_light(user)
		else if(torch.lit && !lit)
			user.notify_nearby("\The [user] lights \the [src] with \the [thing].")
			lit = TRUE
			update_icon()

var/list/burn_sounds = list('sounds/effects/fire1.wav','sounds/effects/fire2.wav','sounds/effects/fire3.wav')
/obj/structure/brazier/process_temperature()
	if(temperature < TEMPERATURE_WOOD_FIRE)
		temperature = TEMPERATURE_WOOD_FIRE
	..()

/obj/structure/brazier/process()
	if(lit)
		if(world.time > next_burn_sound)
			next_burn_sound = world.time + rand(40,50)
			play_local_sound(src, pick(burn_sounds), 15, frequency = -1)
		radiate_heat(TEMPERATURE_WOOD_FIRE, 0)
		radiate_heat(TEMPERATURE_WARM, 3)
