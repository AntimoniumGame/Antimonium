/data/material
	var/name = "iron"
	var/descriptor
	var/strength = 1
	var/sharpness_modifier = 1
	var/weight_modifier = 1

/data/material/proc/get_descriptor()
	return descriptor ? descriptor : name

/data/material/proc/get_sharpness_mod()
	return sharpness_modifier

/data/material/proc/get_weight_mod()
	return weight_modifier

/data/material/cloth
	name = "cloth"
	strength = 0.1
	weight_modifier = 0.1
	sharpness_modifier = 0.1

/data/material/wood
	name = "wood"
	descriptor = "wooden"
	strength = 0.3
	weight_modifier = 0.3
	sharpness_modifier = 0.3

/data/material/lead
	name = "lead"
	strength = 0.5
	weight_modifier = 2
	sharpness_modifier = 0.4

/data/material/gold
	name = "gold"
	strength = 0.1
	weight_modifier = 3
	sharpness_modifier = 0.1
