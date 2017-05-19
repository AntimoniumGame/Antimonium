/obj/check_temperature()
	if(!material)
		return

	switch(material_state)
		if(STATE_SOLID, STATE_POWDER)
			if(temperature >= material.melting_point)
				material.on_melt(src)
		if(STATE_LIQUID)
			if(temperature < material.melting_point)
				material.on_solidify(src)
			else if(temperature >= material.boiling_point)
				material.on_evaporate(src)
		if(STATE_GAS)
			if(temperature < material.boiling_point)
				material.on_condense(src)

/obj/proc/melt()
	if(loc)
		if(istype(loc, /turf))
			new /obj/effect/random/splat(get_turf(src), material.type, src, get_amount())
		else
			new /obj/item/stack/ingredient(loc, material.type, get_amount(), src)
	qdel(src)

/obj/proc/solidify()
	if(loc)
		new /obj/item/stack/ingredient(loc, material.type, get_amount(), src)
	qdel(src)

/obj/proc/evaporate()
	if(loc)
		if(loc.airtight())
			new /obj/item/stack/ingredient(loc, material.type, get_amount(), src)
		else
			new /obj/effect/gas(loc, src)
	qdel(src)

/obj/proc/condense()
	if(loc)
		new /obj/item/stack/ingredient(loc, material.type, get_amount(), src)
	qdel(src)
