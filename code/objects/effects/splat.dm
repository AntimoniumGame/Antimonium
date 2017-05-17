/obj/effect/random/splat
	name = "splatter"
	icon = 'icons/objects/effects/splat.dmi'
	random_states = 3
	random_state_prefix = "small"

	var/amount = 1
	var/list/splat_images = list()

/obj/effect/random/splat/Uncrossed(var/mob/crosser)
	if(istype(crosser) && amount && material_state == STATE_LIQUID)
		var/smearing = min(amount, 5)
		amount -= smearing
		crosser.smear_with(material, smearing)

/obj/effect/random/splat/melt()
	return

/obj/effect/random/splat/update_values()
	color = material.colour

/obj/effect/random/splat/update_strings()
	..()
	name = "[initial(name)] of [material.get_name()]"

/obj/effect/random/splat/New(var/newloc, var/material_path, var/atom/_donor, var/_amount)
	amount = _amount
	if(_donor)
		temperature = _donor.temperature
	..(newloc, material_path)
	for(var/obj/effect/random/splat/splat in get_turf(loc))
		if(splat == src || splat.material != material)
			continue
		if(!transform && splat.transform)
			transform = splat.transform
		splat_images |= splat.icon_state
		splat_images |= splat.splat_images
		amount += splat.amount
		qdel(splat)

	overlays = splat_images
	if(random_states && splat_images.len >= random_states)
		random_state_prefix = null
		icon_state = "[rand(1,random_states)]"
	..()

/obj/effect/random/splat/melt()
	material_state = STATE_LIQUID
	update_strings()
	update_values()

/obj/effect/random/splat/solidify()
	material_state = STATE_SOLID
	update_strings()
	update_values()

/obj/effect/random/splat/smear
	name = "smear"
	icon_state = "smear_from"
	random_states = 0

/obj/effect/random/splat/smear/New(var/newloc, var/material_path, var/atom/_donor, var/amount, var/_dir, var/_state)
	icon_state = "[_state]_[_dir]"
	..(newloc, material_path, _donor)
