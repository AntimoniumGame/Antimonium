/mob/ExaminedBy(var/mob/clicker)
	. = ..()

	if(role)
		clicker.Dnotify("Role#\ref[role] - job: [role.job ? "[role.job.GetTitle(src)] (\ref[role.job])" : "null"], antag: [jointext(role.antagonist_roles, ", ")]")

	if(. && (src == clicker || clicker.intent.selecting == INTENT_HELP))
		clicker.NotifyNearby("\The [clicker] begins checking [src == clicker ? src.Themself() : "\the [src]"] over for injuries.")
		spawn()
			var/list/injuries = list()
			for(var/limb_id in limbs)
				var/result_line
				var/obj/item/limb/limb = GetLimb(limb_id)
				if(limb.wounds.len)
					result_line = "You find "
					var/i = 1
					for(var/thing in limb.wounds)
						var/datum/wound/wound = thing
						if(limb.wounds.len > 1)
							if(i < limb.wounds.len && i > 1)
								result_line += ", "
							else if(i == limb.wounds.len)
								result_line += " and "
						result_line += wound.GetDescriptor()
						i++
				if(result_line)
					injuries += "[result_line] on [Their()] [limb.name]."

			sleep(10)

			if(!clicker || !src || Deleted(src) || Deleted(clicker) || !IsAdjacentTo(clicker, src))
				return

			if(injuries.len)
				for(var/injury in injuries)
					if(!clicker || !src || Deleted(src) || Deleted(clicker) || !IsAdjacentTo(clicker, src))
						return
					clicker.Notify(injury)
					sleep(10)
			else
				clicker.Notify("You find no obvious injuries.")
