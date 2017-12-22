/obj/ui/controller
	var/list/components = list()

/obj/ui/controller/Destroy()
	for(var/thing in components)
		QDel(thing, "controller destroyed")
	components.Cut()
	. = ..()

/obj/ui/controller/proc/ComponentLeftClicked(var/obj/ui/component, var/mob/clicker, var/slot)
	GetInputFrom(component)

/obj/ui/controller/proc/ComponentRightClicked(var/obj/ui/component, var/mob/clicker, var/slot)
	GetInputFrom(component)

/obj/ui/controller/proc/ComponentMiddleClicked(var/obj/ui/component, var/mob/clicker)
	GetInputFrom(component)

/obj/ui/controller/proc/GetInputFrom(var/obj/ui/component/component)
	return
