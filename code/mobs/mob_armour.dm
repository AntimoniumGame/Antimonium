/mob
	var/list/coverage_by_bodypart

/mob/New()
	..()
	coverage_by_bodypart = list()
	appearance_flags |= NO_CLIENT_COLOR

/mob/proc/CheckCoverage(var/bodypart = BP_CHEST)
	return length(coverage_by_bodypart[bodypart])

/mob/proc/RemoveCoverage(var/obj/item/clothing/clothes)
	if(istype(clothes) && length(clothes.body_coverage))
		for(var/bodypart in clothes.body_coverage)
			if(coverage_by_bodypart[bodypart]) coverage_by_bodypart[bodypart] -= clothes

/mob/proc/AddCoverage(var/obj/item/clothing/clothes)
	if(istype(clothes) && length(clothes.body_coverage))
		for(var/bodypart in clothes.body_coverage)
			if(!coverage_by_bodypart[bodypart])
				coverage_by_bodypart[bodypart] = list()
			coverage_by_bodypart[bodypart] += clothes
