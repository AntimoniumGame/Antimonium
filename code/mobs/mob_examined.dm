/mob/examined_by(var/mob/clicker)
	. = ..()

	if(. && (src == clicker || clicker.intent.selecting == INTENT_HELP))
		clicker.notify_nearby("\The [clicker] begins checking [src == clicker ? src.themself() : "\the [src]"] over for injuries.")
		spawn()
			var/list/injuries = list()
			for(var/limb_id in limbs)
				var/result_line
				var/obj/item/limb/limb = limbs[limb_id]
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
						result_line += wound.get_descriptor()
						i++
				if(result_line)
					injuries += "[result_line] on [their()] [limb.name]."

			sleep(10)

			if(!clicker || !src || deleted(src) || deleted(clicker) || !is_adjacent_to(clicker, src))
				return

			if(injuries.len)
				for(var/injury in injuries)
					if(!clicker || !src || deleted(src) || deleted(clicker) || !is_adjacent_to(clicker, src))
						return
					clicker.notify(injury)
					sleep(10)
			else
				clicker.notify("You find no obvious injuries.")
