/obj/item/limb
	var/pain = 0
	var/last_pain_message = 0

/obj/item/limb/proc/show_pain()
	if(world.time > last_pain_message && pain >= 10)
		last_pain_message = world.time + rand(300,600)
		switch(pain)
			if(75 to 101)
				owner.notify("Your [name] pulses with unreleting, crippling pain!")
			if(50 to 75)
				owner.notify("Your [name] throbs agonizingly.")
			if(25 to 50)
				owner.notify("Your [name] hurts.")
			if(10 to 25)
				owner.notify("Your [name] is a little sore.")

/obj/item/limb/proc/adjust_pain(var/amount)
	pain = min(100,max(0,pain+amount))

/obj/item/limb/proc/set_pain(var/amount)
	pain = min(100,max(0,amount))
