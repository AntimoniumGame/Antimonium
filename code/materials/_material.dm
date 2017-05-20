/datum/material

	var/descriptor
	var/general_name = "stuff"

	var/strength = 1
	var/sharpness_modifier = 1
	var/weight_modifier = 1

	var/liquid_name
	var/solid_name
	var/gas_name

	var/solid_portion_name =         "lump"
	var/powder_portion_name =        "pinch"
	var/liquid_portion_name =        "measure"
	var/gas_portion_name =           "puff"
	var/solid_portion_name_plural =  "lumps"
	var/powder_portion_name_plural = "pinches"
	var/liquid_portion_name_plural = "measures"
	var/gas_portion_name_plural =    "puffs"

	// Temperatures are in Kelvin.
	var/melting_point =  TEMPERATURE_NEVER_HOT
	var/boiling_point =  TEMPERATURE_NEVER_HOT
	var/ignition_point = TEMPERATURE_NEVER_HOT

	var/colour = WHITE

/datum/material/New()

	if(!general_name) general_name = "matter"
	if(!descriptor)   descriptor =   general_name
	if(!solid_name)   solid_name =   general_name
	if(!liquid_name)  liquid_name =  "molten [general_name]"
	if(!gas_name)     gas_name =     "[general_name] vapour"
	..()

/datum/material/proc/get_descriptor()
	return descriptor ? descriptor : get_name()

/datum/material/proc/is_flammable()
	return (ignition_point <= TEMPERATURE_MAX)

/datum/material/proc/get_name(var/material_state)
	if(material_state)
		switch(material_state)
			if(STATE_SOLID, STATE_POWDER)
				return solid_name
			if(STATE_LIQUID)
				return liquid_name
			if(STATE_GAS)
				return gas_name
	return general_name

/datum/material/proc/get_term(var/material_state, var/amount)
	if(material_state)
		switch(material_state)
			if(STATE_SOLID)
				return amount == 1 ? solid_portion_name : solid_portion_name_plural
			if(STATE_POWDER)
				return amount == 1 ? powder_portion_name : powder_portion_name_plural
			if(STATE_LIQUID)
				return amount == 1 ? liquid_portion_name : liquid_portion_name_plural
			if(STATE_GAS)
				return amount == 1 ? gas_portion_name : gas_portion_name_plural
	return amount == 1 ? "piece" : "pieces"

/datum/material/proc/get_sharpness_mod()
	return sharpness_modifier

/datum/material/proc/get_weight_mod()
	return weight_modifier

/datum/material/proc/is_temperature_sensitive()
	return (melting_point != TEMPERATURE_NEVER_COLD || ignition_point != TEMPERATURE_NEVER_HOT || boiling_point != TEMPERATURE_NEVER_HOT)

/datum/material/proc/on_melt(var/obj/reagent)
	reagent.notify_nearby("\The [reagent] melts!")
	reagent.material_state = STATE_LIQUID
	reagent.melt()

/datum/material/proc/on_solidify(var/obj/reagent)
	reagent.notify_nearby("\The [reagent] solidifies!")
	reagent.material_state = STATE_SOLID
	reagent.solidify()

/datum/material/proc/on_evaporate(var/obj/reagent)
	reagent.notify_nearby("\The [reagent] evaporates!")
	reagent.material_state = STATE_GAS
	reagent.evaporate()

/datum/material/proc/on_condense(var/obj/reagent)
	reagent.notify_nearby("\The [reagent] condenses!")
	reagent.material_state = STATE_LIQUID
	reagent.condense()
