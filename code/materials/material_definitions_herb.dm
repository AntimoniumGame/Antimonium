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
				if(!consumer.HasEffect(EFFECT_DIZZY))
					consumer.Notify("<span class='danger'>The world spins dizzily around you!</span>")
				consumer.AddEffect(/datum/effect/cumulative, EFFECT_DIZZY, 30, 50)
			if(4, 5, 6)
				if(!consumer.HasEffect(EFFECT_BLINDED))
					consumer.Notify("<span class='danger'>Your vision goes dark!</span>")
				consumer.AddEffect(/datum/effect, EFFECT_BLINDED, 5)
			if(7, 8)
				if(!consumer.HasEffect(EFFECT_UNCONSCIOUS))
					consumer.Notify("<span class='danger'>You black out!</span>")
				consumer.AddEffect(/datum/effect, EFFECT_UNCONSCIOUS, 5)
				if(brain) brain.TakeDamage(rand(2,5))
			if(9)
				if(!consumer.HasEffect(EFFECT_UNCONSCIOUS))
					consumer.Notify("<span class='danger'>You are overcome by a sudden, violent seizure!</span>")
				consumer.AddEffect(/datum/effect, EFFECT_UNCONSCIOUS, 10)
				consumer.AddEffect(/datum/effect/cumulative, EFFECT_CONFUSED, 30, 50)
				consumer.AddEffect(/datum/effect/cumulative, EFFECT_DIZZY, 30, 50)
				if(brain) brain.TakeDamage(rand(5,10))

/datum/material/herb/wheat
	general_name = "wheat"
	powder_name = "flour"
	grindable = TRUE
	powder_icon = 'icons/objects/items/alchemy/powder_white.dmi'
	colour = PALE_BROWN
