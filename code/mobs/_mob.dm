/*
Mob interactions:
	attack_self() - the mob is attacking itself with a bare hand.
	attack(var/mob/target) - the mob is attacking a target with a bare hand.
*/

/mob
	icon = 'icons/mobs/_default.dmi'
	layer = MOB_LAYER
	see_invisible = SEE_INVISIBLE_LIVING

/mob/New()
	..()
	gender = pick(MALE, FEMALE, NEUTER, PLURAL)
	mob_list += src

/mob/destroy()
	mob_list -= src
	return ..()
