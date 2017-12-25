/datum/antagonist/thief
	role_name = "\improper Thief"
	role_name_plural = "\improper Thieves"
	welcome_text = "This town is rich in precious things, ripe for the taking...."
	maximum_spawn_count = 0.1

/datum/antagonist/thief/GenerateObjectives(var/datum/role/generating)
	generating.objectives += new /datum/objective/steal(generating, src)
	generating.objectives += new /datum/objective/escape(generating, src)

// Thief objectives.
/datum/objective/steal
	text = "Fence a certain amount of items."
	var/theft_value = 0
	var/stolen_value = 0

/datum/objective/steal/SetObjective()
	theft_value = rand(1500,2000)
	text = "Fence at least $[theft_value] worth of items."

/datum/objective/steal/Completed()
	return (stolen_value >= theft_value && holder && holder.mob && !holder.mob.dead)

// PLACEHOLDERS FOR A FENCE NPC.
/proc/FenceObject(var/mob/fencer, var/obj/fencing)
	if(fencer && fencer.role && fencing)
		var/datum/objective/steal/steal_obj = locate() in fencer.role.objectives
		if(istype(steal_obj))
			var/amount = fencing.GetMonetaryWorth()
			steal_obj.stolen_value += amount
			fencer.DropItem(fencing)
			QDel(fencing, "fenced")
			return amount
	return 0

/datum/antagonist/thief/Equip(var/mob/equipping)
	equipping = ..()
	equipping.verbs |= /mob/human/proc/MobFenceObject
	return equipping

/mob/human/proc/MobFenceObject()

	set name = "Fence Object"
	set desc = "Sell an object."
	set category = "Debug"

	var/list/can_fence = list()
	for(var/inv_slot in inventory_slots)
		var/obj/ui/inv/equipping = inventory_slots[inv_slot]
		if(equipping.holding)
			can_fence += equipping.holding

	var/obj/fencing = input("What do you wish to fence?") as null|anything in can_fence
	if(fencing)
		var/fencing_name = "[fencing.name]" // Since a successful fence qdels
		var/fenced_for = FenceObject(src, fencing)
		if(fenced_for)
			Notify("You fenced \the [fencing_name] for [fenced_for].")
		else
			Notify("The [fencing_name] cannot be fenced or is worthless.")
// END DEBUG PLACEHOLDER.