/obj/item/plant
	name = "plant"
	icon = 'icons/objects/items/plants/cotton.dmi'
	default_material_path = null
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	shadow_size = 1

	var/growth_stage = 1
	var/max_growth_stage = 4
	var/obj/structure/earthworks/farm/growing_in
	var/growth_stage_threshold = 100
	var/seed_type
	var/product_type
	var/growth = 0
	var/min_harvest_amount = 2
	var/max_harvest_amount = 4

/obj/item/plant/cotton
	name = "cotton plant"
	seed_type = /obj/item/stack/seed/cotton
	product_type = /obj/item/stack/cotton

/obj/item/plant/New(var/newloc, var/obj/structure/earthworks/farm/_growing_in)
	..()
	growing_in = _growing_in
	if(growing_in)
		processing_objects += src

/obj/item/plant/Destroy()
	..()
	if(growing_in)
		for(var/pkey in growing_in.occupied_spots)
			if(growing_in.occupied_spots[pkey] == src)
				growing_in.occupied_spots[pkey] = null
				growing_in.occupied_spots -= pkey
				break
		growing_in = null
	processing_objects -= src

/obj/item/plant/Move()
	. = ..()
	if(. && growing_in)
		Harvested()

/obj/item/plant/BeforePickedUp(var/mob/user)
	Harvested(user)
	return FALSE

/obj/item/plant/proc/CanGrow()
	return TRUE

/obj/item/plant/proc/Harvested(var/mob/harvester)
	if(harvester)
		NotifyNearby("\The [src] has been uprooted by \the [harvester].")
	else
		NotifyNearby("\The [src] has been uprooted from \the [growing_in].")

	if(seed_type && prob(growth_stage * 25))
		new seed_type(get_turf(src), _amount = rand(1,growth_stage))
	if(growth_stage >= max_growth_stage && product_type)
		new product_type(get_turf(src), _amount = rand(min_harvest_amount,max_harvest_amount))
	QDel(src)

/obj/item/plant/New()
	..()
	pixel_x = rand(-1,1)
	pixel_y = rand(-1,1)

/obj/item/plant/Process()
	if(CanGrow())
		growth += rand(1,3)
		if(growth >= growth_stage_threshold)
			growth -= growth_stage_threshold
			growth_stage = min(max_growth_stage,max(1,growth_stage+1))
		UpdateIcon()

/obj/item/plant/UpdateIcon(var/list/supplying = list())
	. = ..(supplying)
	icon_state = "[growth_stage]"
