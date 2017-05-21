/obj/ui/toggle
	var/toggle_state = FALSE
	var/base_icon_state
	var/toggle_sound = 'sounds/effects/click1.wav'

/obj/ui/toggle/UpdateIcon(var/list/supplied = list())
	icon_state = "[base_icon_state]_[toggle_state ? "on" : "off"]"

/obj/ui/toggle/proc/ToggleState()
	if(toggle_sound && owner.client)
		PlayClientSound(owner.client, null, toggle_sound, 100, -1)
	toggle_state = !toggle_state
	UpdateIcon()

/obj/ui/toggle/LeftClickedOn(var/mob/clicker, var/slot = SLOT_LEFT_HAND)
	. = ..()
	if(.) ToggleState()

/obj/ui/toggle/RightClickedOn(var/mob/clicker, var/slot = SLOT_RIGHT_HAND)
	. = ..()
	if(.) ToggleState()
