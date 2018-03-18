/proc/InitializeHairstyles()
	for(var/htype in typesof(/datum/hairstyle))
		var/datum/hairstyle/hairstyle = GetUniqueDataByPath(htype)
		_glob.hair_styles[hairstyle.name] = hairstyle

/datum/hairstyle
	var/name = "Bald"
	var/icon = 'icons/mobs/hair/_bald.dmi'

/datum/hairstyle/tonsure
	name = "Tonsure"
	icon = 'icons/mobs/hair/tonsure.dmi'
