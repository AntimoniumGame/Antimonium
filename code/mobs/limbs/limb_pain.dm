/obj/item/limb
	var/pain = 0
	var/last_pain_message = 0

/obj/item/limb/proc/ShowPain()
	if(world.time > last_pain_message && pain >= 10)
		last_pain_message = world.time + rand(300,600)
		switch(pain)
			if(75 to 101)
				owner.Notify("<span class='danger'>Your [name] pulses with unrelenting, crippling pain!</span>")
			if(50 to 75)
				owner.Notify("<span class='danger'>Your [name] throbs agonizingly.</span>")
			if(25 to 50)
				owner.Notify("<span class='warning'>Your [name] hurts.</span>")
			if(10 to 25)
				owner.Notify("<span class='warning'>Your [name] is a little sore.</span>")

/obj/item/limb/proc/AdjustPain(var/amount)
	pain = min(100,max(0,pain+amount))

/obj/item/limb/proc/SetPain(var/amount)
	pain = min(100,max(0,amount))
