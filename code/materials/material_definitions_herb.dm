/datum/material/herb
	general_name = "leaf"
	ignition_point = 400

/datum/material/herb/New()
	..()
	powder_name = "powdered [general_name]"

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
