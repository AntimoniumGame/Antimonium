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
	if(istype(loc, /turf))
		new /obj/item/stack/ingredient(get_turf(src), /datum/material/slag, get_weight(), src)
	else
		new /obj/item/stack/ingredient(get_turf(src), material.type, get_weight(), src)
	qdel(src)

/obj/proc/solidify()
	new /obj/item/stack/ingredient(get_turf(src), material.type, get_weight(), src)
	qdel(src)

/obj/proc/evaporate()
	if(loc.airtight())
		new /obj/item/stack/ingredient(get_turf(src), material.type, get_weight(), src)
	else
		new /obj/effect/gas(loc, src)
	qdel(src)

/obj/proc/condense()
	new /obj/item/stack/ingredient(get_turf(src), material.type, get_weight(), src)
	qdel(src)
