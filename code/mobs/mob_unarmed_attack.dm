/obj/item/unarmed_attack
	name = "fist"
	attack_verbs = list("strikes")
	default_material_path = /datum/material/bone

	var/attack_sound = 'sounds/effects/punch1.ogg'
	var/attack_force = 3

/obj/item/unarmed_attack/UpdateStrings()
	name = initial(name)

/obj/item/unarmed_attack/maul
	name = "teeth"
	gender = PLURAL
	attack_force = 6
	attack_verbs = "mauls"
	attack_sound = 'sounds/effects/bork1.ogg'
	default_material_path = /datum/material/bone
	edged = TRUE

/obj/item/unarmed_attack/maul/GetContactArea()
	return 1 // Teeth!

/obj/item/unarmed_attack/kick
	attack_force = 4
	attack_verbs = "kicks"
	attack_sound = 'sounds/effects/bork1.ogg'
	default_material_path = /datum/material/bone
	edged = TRUE

