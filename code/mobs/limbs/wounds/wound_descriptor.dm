/data/wound/proc/get_descriptor()

	var/size_string
	var/depth_string
	var/wound_string

	if(severity > 50)
		size_string = bleed_amount ? "gaping" : "horrendous"
	else if(severity > 30)
		size_string = "enormous"
	else if(severity > 20)
		size_string = "large"
	else if(severity > 10)
		size_string = "small"
	else if(severity > 5)
		size_string = "noticeable"
	else
		size_string = "tiny"

	if(depth > 20)
		depth_string = "very deep"
	else if(depth >= 10)
		depth_string = "deep"
	else
		depth_string = "shallow"

	if(wound_type == WOUND_BRUISE)
		wound_string = "bruise"
	else if(wound_type == WOUND_CUT)
		wound_string = "cut"
	else if(wound_type == WOUND_BURN)
		wound_string = "burn"

	if(bleed_amount)
		return "\a [size_string], [depth_string], bleeding [wound_string]"
	else
		return "\a [size_string], [depth_string] [wound_string]"
