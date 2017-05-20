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

/datum/material/proc/GetDescriptor()
	return descriptor ? descriptor : GetName()

/datum/material/proc/GetName(var/material_state)
	if(material_state)
		switch(material_state)
			if(STATE_SOLID, STATE_POWDER)
				return solid_name
			if(STATE_LIQUID)
				return liquid_name
			if(STATE_GAS)
				return gas_name
	return general_name

/datum/material/proc/GetTerm(var/material_state, var/amount)
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

/datum/material/proc/GetSharpnessMod()
	return sharpness_modifier

/datum/material/proc/GetWeightMod()
	return weight_modifier

/datum/material/proc/IsTemperatureSensitive()
	return (melting_point != TEMPERATURE_NEVER_COLD || ignition_point != TEMPERATURE_NEVER_HOT || boiling_point != TEMPERATURE_NEVER_HOT)

/datum/material/proc/OnMelt(var/obj/reagent)
	reagent.NotifyNearby("\The [reagent] melts!")
	reagent.material_state = STATE_LIQUID
	reagent.Melt()

/datum/material/proc/OnSolidify(var/obj/reagent)
	reagent.NotifyNearby("\The [reagent] solidifies!")
	reagent.material_state = STATE_SOLID
	reagent.Solidify()

/datum/material/proc/OnEvaporate(var/obj/reagent)
	reagent.NotifyNearby("\The [reagent] evaporates!")
	reagent.material_state = STATE_GAS
	reagent.Evaporate()

/datum/material/proc/OnCondense(var/obj/reagent)
	reagent.NotifyNearby("\The [reagent] condenses!")
	reagent.material_state = STATE_LIQUID
	reagent.Condense()
