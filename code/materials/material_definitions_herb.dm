/datum/material/herb
	general_name = "leaf"
	ignition_point = 400

/datum/material/herb/New()
	if(!powder_name)
		powder_name = "powdered [general_name]"
	..()

// placeholders for now
/datum/material/herb/ginseng
	general_name = "ginseng"
	colour = PALE_BROWN
	grindable = TRUE
	powder_icon = 'icons/objects/items/alchemy/powder_orange.dmi'

/datum/material/herb/nightshade
	general_name = "belladonna"
	colour = DARK_PURPLE
	grindable = TRUE
	powder_icon = 'icons/objects/items/alchemy/powder_purple.dmi'

/datum/material/herb/nightshade/HandleConsumedEffects(var/mob/consumer)

	var/obj/item/organ/brain = consumer.GetOrganByKey(ORGAN_BRAIN)
	if(brain)
		brain.TakeDamage(rand(1,3))

	if(prob(15))
		switch(rand(1,9))
			if(1, 2, 3)
				consumer.Notify("<span class='danger'>The world spins dizzily around you!</span>")
				if(!consumer.prone)
					consumer.ToggleProne()
				consumer.SetActionCooldown(15)
			if(4, 5, 6)
				if(consumer.blinded <= 0)
					consumer.Notify("<span class='danger'>Your eyes begin to twitch and spasm!</span>")
				consumer.SetBlinded(5)
			if(7, 8)
				if(consumer.IsConscious())
					consumer.Notify("<span class='danger'>You black out!</span>")
				consumer.SetUnconscious(5)
				if(brain) brain.TakeDamage(rand(2,5))
			if(9)
				if(consumer.IsConscious())
					consumer.Notify("<span class='danger'>You are overcome by a sudden, violent seizure!</span>")
					consumer.SetUnconscious(10)
				if(brain) brain.TakeDamage(rand(5,10))

/datum/material/herb/wheat
	general_name = "wheat"
	powder_name = "flour"
	grindable = TRUE
	powder_icon = 'icons/objects/items/alchemy/powder_white.dmi'
	colour = PALE_BROWN
