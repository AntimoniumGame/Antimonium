/obj/effect/random
	name = "random effect"
	icon_state = "1"
	var/random_states = 1
	var/random_state_prefix

/obj/effect/random/Initialize()
	if(random_states)
		var/random_state = rand(1,random_states)
		if(random_state_prefix)
			icon_state = "[random_state_prefix]-[random_state]"
		else
			icon_state = "[random_state]"
		if(!transform)
			var/matrix/M = matrix()
			M.Turn(pick(0,90,180,270))
			transform = M
