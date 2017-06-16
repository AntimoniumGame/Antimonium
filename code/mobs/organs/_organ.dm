/proc/CreateDefaultInternalOrgans(var/mob/owner)
	owner.organs += new /obj/item/organ/paired(owner, _left_side = TRUE,   _organ_key = ORGAN_EYE,     _limb_key = BP_HEAD,  _max_damage = 20)
	owner.organs += new /obj/item/organ/paired(owner, _left_side = FALSE,  _organ_key = ORGAN_EYE,     _limb_key = BP_HEAD,  _max_damage = 20)
	owner.organs += new /obj/item/organ/paired(owner, _left_side = TRUE,   _organ_key = ORGAN_LUNG,    _limb_key = BP_CHEST, _max_damage = 40)
	owner.organs += new /obj/item/organ/paired(owner, _left_side = FALSE,  _organ_key = ORGAN_LUNG,    _limb_key = BP_CHEST, _max_damage = 40)
	owner.organs += new /obj/item/organ/paired(owner, _left_side = TRUE,   _organ_key = ORGAN_KIDNEY,  _limb_key = BP_GROIN, _max_damage = 30)
	owner.organs += new /obj/item/organ/paired(owner, _left_side = FALSE,  _organ_key = ORGAN_KIDNEY,  _limb_key = BP_GROIN, _max_damage = 30)
	owner.organs += new /obj/item/organ(       owner, _vital = TRUE,       _organ_key = ORGAN_BRAIN,   _limb_key = BP_HEAD,  _max_damage = 200)
	owner.organs += new /obj/item/organ(       owner, _vital = TRUE,       _organ_key = ORGAN_HEART,   _limb_key = BP_CHEST, _max_damage = 100)
	owner.organs += new /obj/item/organ(       owner,                      _organ_key = ORGAN_STOMACH, _limb_key = BP_CHEST, _max_damage = 50)
	owner.organs += new /obj/item/organ(       owner,                      _organ_key = ORGAN_SPLEEN,  _limb_key = BP_GROIN, _max_damage = 50)
	owner.organs += new /obj/item/organ(       owner,                      _organ_key = ORGAN_LIVER,   _limb_key = BP_GROIN, _max_damage = 50)

/obj/item/organ
	name = "organ"
	flags = FLAG_SIMULATED | FLAG_IS_EDIBLE | FLAG_THROWN_SPIN
	icon = 'icons/objects/items/organ/organ.dmi'

	var/damage =               0
	var/impairment_threshold = 50
	var/max_damage =           100
	var/min_bruised_damage
	var/min_broken_damage
	var/mob/owner
	var/dead
	var/vital
	var/organ_key
	var/limb_key
	var/list/effects = list()

/obj/item/organ/Destroy()
	if(owner)
		owner.organs -= src
		var/list/organ_list = owner.organs_by_key[organ_key]
		organ_list -= src
		if(!organ_list.len)
			owner.organs_by_key[organ_key] = null
			owner.organs_by_key -= organ_key
		owner = null
	var/obj/item/limb/limb = loc
	if(istype(limb))
		limb.organs -= src
	. = ..()

/obj/item/organ/proc/IsHealthy()
	return !dead && !IsBroken()

/obj/item/organ/proc/IsBruised()
	return (damage >= min_bruised_damage)

/obj/item/organ/proc/IsBroken()
	return (damage >= min_broken_damage)

/obj/item/organ/proc/TakeDamage(var/amt)
	damage = max(min(damage+amt, max_damage),0)
	if(damage == max_damage && !dead)
		Die()

/obj/item/organ/proc/Die()
	if(dead)
		return
	name = "dead [name]"
	dead = TRUE
	if(owner && vital)
		owner.Die("vital organ failure")

/obj/item/organ/New(var/newloc, var/material_path = /datum/material/meat, var/_left_side = FALSE, var/_organ_key, var/_vital, var/_limb_key, var/_max_damage)

	organ_key = _organ_key
	limb_key = _limb_key
	name = organ_key
	vital = _vital

	max_damage = _max_damage
	min_bruised_damage = round(max_damage * 0.35)
	min_broken_damage =  round(max_damage * 0.7)

	..(newloc, material_path)

	if(istype(loc, /mob))
		owner = loc
		if(!owner.organs_by_key[organ_key])
			owner.organs_by_key[organ_key] = list()
		owner.organs_by_key[organ_key] += src

	var/obj/item/limb/limb = owner.GetLimb(limb_key)
	if(!limb)
		QDel(src)
		return
	ForceMove(limb)
	limb.organs += src

/obj/item/organ/UpdateStrings()
	name = organ_key

/obj/item/organ/Process()
	if(!owner)
		return FALSE
	return TRUE

/obj/item/organ/paired
	var/left_side

/obj/item/organ/paired/New(var/newloc, var/material_path = /datum/material/meat, var/_left_side = FALSE, var/_organ_key, var/_vital, var/_limb_key, var/_max_damage)
	left_side = _left_side
	..(newloc, material_path, _left_side, _organ_key, _vital, _limb_key, _max_damage)

/obj/item/organ/paired/UpdateStrings()
	if(left_side)
		name = "left [organ_key]"
	else
		name = "right [organ_key]"
		var/matrix/flip = matrix()
		flip.Scale(-1,1)
		transform = flip

/obj/item/organ/proc/Remove(var/bleed = FALSE)

	var/matrix/M = matrix()
	M.Turn(pick(0,90,180,270))
	transform = M

	var/blood_mat
	if(owner)
		if(bleed)
			blood_mat = owner.blood_material
		owner.organs -= src
		var/list/organ_list = owner.organs_by_key[organ_key]
		organ_list -= src
		if(!organ_list.len)
			owner.organs_by_key[organ_key] = null
			owner.organs_by_key -= organ_key
		ForceMove(get_turf(owner))
		if(vital)
			owner.Die("loss of a vital organ")
		owner = null

	if(blood_mat)
		spawn(1)
			Splatter(loc, blood_mat)

/obj/item/organ/paired/Remove()
	..()
	if(left_side)
		var/matrix/M = transform
		M.Scale(-1,1)
		transform = M