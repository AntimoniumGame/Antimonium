/obj/ui/controller
	var/list/components = list()

/obj/ui/controller/destroy()
	for(var/thing in components)
		qdel(thing)
	components.Cut()
	. = ..()

/obj/ui/controller/proc/component_left_clicked(var/obj/ui/component, var/mob/clicker, var/slot)
	get_input_from(component)

/obj/ui/controller/proc/component_right_clicked(var/obj/ui/component, var/mob/clicker, var/slot)
	get_input_from(component)

/obj/ui/controller/proc/component_middle_clicked(var/obj/ui/component, var/mob/clicker)
	get_input_from(component)

/obj/ui/controller/proc/get_input_from(var/obj/ui/component/component)
	return
