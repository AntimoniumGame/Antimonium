/proc/InitializeReagentReactions()
	/*
	AddReagentReaction("test", min_temp = TEMPERATURE_FREEZING, max_temp = TEMPERATURE_BOILING, \
		consumed = list(/datum/material/water/alcohol = 10, /datum/material/herb/nightshade = 1), \
		products = list(/datum/material/water/alcohol/poisoned = 10))
	*/

//TODO make this a daemon
/proc/ProcessReagentReactions(var/atom/holder, var/list/reagents)
	for(var/thing in _glob.all_reagent_reactions)
		var/datum/reagent_reaction/reaction = thing
		if(reaction.CanReact(holder, reagents))
			reaction.DoReaction(holder, reagents)
			return

/proc/AddReagentReaction(var/ident, var/min_temp = TEMPERATURE_ZERO, var/max_temp = TEMPERATURE_MAX, var/list/consumed = list(), var/list/catalysts = list(), var/list/products = list())
	if(_glob.reagent_reactions_by_ident[ident])
		return
	var/datum/reagent_reaction/reaction = new()
	reaction.name = ident
	reaction.minimum_temperature = min_temp
	reaction.maximum_temperature = max_temp
	reaction.consumed_reagents =   consumed
	reaction.catalyzing_reagents = catalysts
	reaction.produced_reagents =   products
	_glob.reagent_reactions_by_ident[ident] = reaction
	_glob.all_reagent_reactions += reaction

/datum/reagent_reaction
	var/name
	var/minimum_temperature
	var/maximum_temperature
	var/list/consumed_reagents
	var/list/catalyzing_reagents
	var/list/produced_reagents

/datum/reagent_reaction/proc/CanReact(var/atom/holder, var/list/reagents)

	if(!reagents)
		return FALSE

	var/list/consuming = consumed_reagents.Copy()
	var/list/catalyzing = catalyzing_reagents.Copy()

	for(var/obj/item/stack/stack in reagents)

		if(!stack.material || stack.temperature < minimum_temperature || stack.temperature > maximum_temperature)
			continue

		if(consuming[stack.material.type])
			if(stack.GetAmount() >= consuming[stack.material.type])
				consuming[stack.material.type] = null
				consuming -= stack.material.type
			else
				consuming[stack.material.type] -= stack.GetAmount()
			continue

		if(catalyzing[stack.material.type])
			if(stack.GetAmount() >= catalyzing[stack.material.type])
				catalyzing[stack.material.type] = null
				catalyzing -= stack.material.type
			else
				catalyzing[stack.material.type] -= stack.GetAmount()
			continue

	return !(consuming.len || catalyzing.len)

/datum/reagent_reaction/proc/DoReaction(var/obj/holder, var/list/reagents)

	var/list/consuming = consumed_reagents.Copy()

	for(var/obj/item/stack/stack in reagents)
		if(!stack.material || stack.temperature < minimum_temperature || stack.temperature > maximum_temperature)
			continue
		if(consuming[stack.material.type])
			var/remove_amount
			if(stack.GetAmount() > consuming[stack.material.type])
				remove_amount = consuming[stack.material.type]
			else
				remove_amount = stack.GetAmount()
			consuming[stack.material.type] -= remove_amount
			if(consuming[stack.material.type] <= 0)
				consuming[stack.material.type] = null
				consuming -= stack.material.type
			stack.Remove(remove_amount)

	for(var/reagent in produced_reagents)
		holder.PutReagentInside(new /obj/item/stack/reagent(holder, reagent, produced_reagents[reagent], holder))
