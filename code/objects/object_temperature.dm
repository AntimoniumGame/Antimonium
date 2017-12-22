/obj/CheckTemperature()
	if(!material)
		return

	switch(material_state)
		if(STATE_SOLID, STATE_POWDER)
			if(temperature >= material.melting_point)
				material.OnMelt(src)
		if(STATE_LIQUID)
			if(temperature < material.melting_point)
				material.OnSolidify(src)
			else if(temperature >= material.boiling_point)
				material.OnEvaporate(src)
		if(STATE_GAS)
			if(temperature < material.boiling_point)
				material.OnCondense(src)

/obj/proc/Melt()
	if(loc)
		if(istype(loc, /turf))
			new /obj/effect/random/splat(get_turf(src), material.type, src, GetAmount())
		else
			new /obj/item/stack/reagent(loc, material.type, GetAmount(), src)
	QDel(src, "melted")

/obj/proc/Solidify()
	if(loc)
		new /obj/item/stack/reagent(loc, material.type, GetAmount(), src)
	QDel(src, "solidified")

/obj/proc/Evaporate()
	if(loc)
		if(loc.Airtight())
			new /obj/item/stack/reagent(loc, material.type, GetAmount(), src)
		else
			new /obj/effect/gas(loc, src)
	QDel(src, "evaporated")

/obj/proc/Condense()
	if(loc)
		new /obj/item/stack/reagent(loc, material.type, GetAmount(), src)
	QDel(src, "condensed")