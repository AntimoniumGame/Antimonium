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
	SetLight()
	processing_objects += src
	next_burn_sound = rand(10,20)

/obj/structure/brazier/UpdateIcon()
	overlays.Cut()
	if(lit)
		overlays += image('icons/images/fire.dmi', "mid")
		SetLight()
	else
		KillLight()

/obj/structure/brazier/Destroy()
	processing_objects -= src
	. = ..()

/obj/structure/brazier/AttackedBy(var/mob/user, var/obj/item/thing)
	if(istype(thing, /obj/item/torch))
		var/obj/item/torch/torch = thing
		if(!torch.lit && lit)
			user.NotifyNearby("\The [user] lights \the [thing] in \the [src].")
			torch.lit = TRUE
			torch.UpdateLight(user)
		else if(torch.lit && !lit)
			user.NotifyNearby("\The [user] lights \the [src] with \the [thing].")
			lit = TRUE
			UpdateIcon()

var/list/burn_sounds = list('sounds/effects/fire1.wav','sounds/effects/fire2.wav','sounds/effects/fire3.wav')
/obj/structure/brazier/ProcessTemperature()
	if(temperature < TEMPERATURE_WOOD_FIRE)
		temperature = TEMPERATURE_WOOD_FIRE
	..()

/obj/structure/brazier/Process()
	if(lit)
		if(world.time > next_burn_sound)
			next_burn_sound = world.time + rand(40,50)
			PlayLocalSound(src, pick(burn_sounds), 15, frequency = -1)
		RadiateHeat(TEMPERATURE_WOOD_FIRE, 0)
		RadiateHeat(TEMPERATURE_WARM, 3)
