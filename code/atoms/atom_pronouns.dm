/atom/proc/Them()
	switch(gender)
		if(FEMALE)
			return "her"
		if(MALE)
			return "him"
		if(PLURAL)
			return "them"
	return "it"

/atom/proc/Their()
	switch(gender)
		if(FEMALE)
			return "her"
		if(MALE)
			return "his"
		if(PLURAL)
			return "their"
	return "its"

/atom/proc/They()
	switch(gender)
		if(FEMALE)
			return "she"
		if(MALE)
			return "he"
		if(PLURAL)
			return "they"
	return "it"

/atom/proc/s()
	return (gender == PLURAL) ? "" : "s"

/atom/proc/Themself()
	switch(gender)
		if(FEMALE)
			return "herself"
		if(MALE)
			return "himself"
		if(PLURAL)
			return "themself"
	return "itself"
