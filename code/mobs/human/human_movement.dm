/mob/human/Move()
	if(prone)
		return FALSE
	. = ..()
