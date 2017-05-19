/obj/ui/toggle
	var/toggle_state = FALSE
	var/base_icon_state
	var/toggle_sound = 'sounds/effects/click1.wav'

/obj/ui/toggle/update_icon()
	icon_state = "[base_icon_state]_[toggle_state ? "on" : "off"]"

/obj/ui/toggle/proc/toggle_state()
	if(toggle_sound && owner.client)
		play_client_sound(owner.client, null, toggle_sound, 100, -1)
	toggle_state = !toggle_state
	update_icon()

/obj/ui/toggle/left_clicked_on(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.) toggle_state()

/obj/ui/toggle/right_clicked_on(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.) toggle_state()
