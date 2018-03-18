/datum/material

	var/general_name = "stuff"      // General purpose string for referring to the material.
	var/descriptor                  // Used by materials with a different adjective to their name (wood/wooden wall vs iron/iron wall)

	var/sharpness_modifier = 1      // Props of this material will multiply their default sharpness by this.
	var/weight_modifier = 1         // Props of this material will multiply their default weight by this.
	var/structural_integrity = 50   // Walls made of this material will use this value for max HP.
	var/smell_o_vision              // Whether or not objects of this material have NO_CLIENT_COLOR applied, for dog monochrome vision.

	// Descriptive strings for various item states.
	var/liquid_name
	var/solid_name
	var/gas_name
	var/powder_name
	var/solid_portion_name =         "lump"
	var/powder_portion_name =        "pinch"
	var/liquid_portion_name =        "measure"
	var/gas_portion_name =           "puff"
	var/solid_portion_name_plural =  "lumps"
	var/powder_portion_name_plural = "pinches"
	var/liquid_portion_name_plural = "measures"
	var/gas_portion_name_plural =    "puffs"

	// Phase state transition points. Temperatures are in Kelvin.
	var/melting_point =  TEMPERATURE_NEVER_HOT
	var/boiling_point =  TEMPERATURE_NEVER_HOT
	var/ignition_point = TEMPERATURE_NEVER_HOT

	var/colour = WHITE    // General purpose colour value.
	var/grindable = FALSE // Can be ground by the millstone or SKILL_ALCHEMY tools (mortar and pestle).
	var/spinnable = FALSE // Can be spun into thread at the loom.

	var/solid_icon = 'icons/objects/items/alchemy/solid_stone_grey.dmi' // Stack icon used for solid lumps.
	var/powder_icon = 'icons/objects/items/alchemy/powder_grey.dmi'     // Stack icon used for ground/powdered pinches.
	var/thermal_insulation = 0 // Temperature against which clothing of this materiaal protects the wearer.

	var/demolition_skill = SKILL_MINING                  // If set, props must be associated with this skill to damage walls of this material.
	var/construction_sound = 'sounds/effects/click1.ogg' // General purpose building sound for structures of this material.
	var/hit_sound = 'sounds/effects/chisel1.ogg'         // General purpose impact sound for atoms made from this materiala.
	var/list/crafting_recipe_paths = list()              // A list of crafting recipe path types valid for this material.
	var/list/recipes = list()                            // A list of instanced crafting recipes for this material.
	var/value_modifier = 1                               // Multiplier for worth of items made from this material.

	// Turf vars.
	var/turf_effect_overlay                              // If specified, will apply this state from the turf_floor_icon as an overlay.
	var/turf_floor_icon                                  // Icon file to use for a floor made of this material.
	var/turf_wall_icon                                   // Icon file to use for a wall made of this material.
	var/turf_is_diggable                                 // Floors of this material can be dug into pits or farms with a shovel.
	var/turf_edge_layer                                  // Floors will use this value for the layer of edge images drawn over neighboring turfs.
	var/turf_base_states = 1                             // How many base floor states are in the turf_floor_icon file. Updated at runtime.
	var/turf_wall_is_dense = 1                           // Are walls of this material dense?
	var/turf_wall_is_transparent = 0                     // Are walls of this material transparent?

/datum/material/New()

	if(!general_name) general_name = "matter"
	if(!descriptor)   descriptor =   general_name
	if(!solid_name)   solid_name =   general_name
	if(!powder_name)  powder_name =  "[general_name] dust"
	if(!liquid_name)  liquid_name =  "molten [general_name]"
	if(!gas_name)     gas_name =     "[general_name] vapour"

	turf_edge_layer = glob.turf_edge_layer_offset * glob.turf_edge_layers_by_path.Find(type)

	for(var/recipe in crafting_recipe_paths)
		recipes += GetUniqueDataByPath(recipe)

	if(turf_floor_icon)
		var/list/istates = icon_states(turf_floor_icon)
		var/has_edges = ("edges" in istates)
		turf_base_states = istates.len-1
		if(has_edges)
			turf_base_states--
		if(turf_effect_overlay && (turf_effect_overlay in istates))
			turf_base_states--
	..()

/datum/material/proc/GetRecipesFor(var/skills, var/atom/craft_at, var/obj/item/stack/crafting_with)
	if(!skills || !craft_at || !crafting_with)
		return list()
	var/list/valid_recipes = list()
	for(var/datum/crafting_recipe/crecipe in recipes)
		if((skills & crecipe.required_skills) && crecipe.CanCraft(craft_at, crafting_with))
			valid_recipes += crecipe
	return valid_recipes

/datum/material/proc/GetConstructionSound()
	return construction_sound

/datum/material/proc/GetDescriptor()
	return descriptor ? descriptor : GetName()

/datum/material/proc/GetBuildableTurfs(var/obj/item/stack/building_with)
	return list()

/datum/material/proc/GetBuildableStructures(var/obj/item/stack/building_with)
	return list()

/datum/material/proc/GetTurfCost()
	return 10

/datum/material/proc/GetStructureCost()
	return 10

/datum/material/proc/IsFlammable()
	return (ignition_point <= TEMPERATURE_MAX)

/datum/material/proc/GetName(var/material_state)
	if(material_state)
		switch(material_state)
			if(STATE_SOLID)
				return solid_name
			if(STATE_POWDER)
				return powder_name
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
	reagent.NotifyNearby("\The [reagent] melts!", MESSAGE_VISIBLE)
	reagent.material_state = STATE_LIQUID
	reagent.Melt()

/datum/material/proc/OnSolidify(var/obj/reagent)
	reagent.NotifyNearby("\The [reagent] solidifies!", MESSAGE_VISIBLE)
	reagent.material_state = STATE_SOLID
	reagent.Solidify()

/datum/material/proc/OnEvaporate(var/obj/reagent)
	reagent.NotifyNearby("\The [reagent] evaporates!", MESSAGE_VISIBLE)
	reagent.material_state = STATE_GAS
	reagent.Evaporate()

/datum/material/proc/OnCondense(var/obj/reagent)
	reagent.NotifyNearby("\The [reagent] condenses!", MESSAGE_VISIBLE)
	reagent.material_state = STATE_LIQUID
	reagent.Condense()

/datum/material/proc/GetDebris(var/amount)
	return new /obj/item/stack/reagent(material_path = type, _amount = amount)

/datum/material/proc/ConvertToRuin(var/loc)
	new /turf/floor/dirt(loc)

/datum/material/proc/OnTurfEntry(var/turf/crossing, var/atom/movable/crosser)
	return

/datum/material/proc/OnTurfAttack(var/turf/target, var/mob/user, var/obj/item/prop)
	return

/datum/material/proc/HandleConsumedEffects(var/mob/consumer)
	return
