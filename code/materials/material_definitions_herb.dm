/datum/material/herb
	general_name = "leaf"
	ignition_point = 400

/datum/material/herb/New()
	..()
	powder_name = "powdered [general_name]"

// placeholders for now
/datum/material/herb/ginseng
	general_name = "ginseng root"
	descriptor = "ginseng"
	colour = PALE_BROWN
	grindable = TRUE

/datum/material/herb/nightshade
	general_name = "belladonna flower"
	colour = DARK_PURPLE
	grindable = TRUE
