/datum/daemon/items
	name = "items"
	delay = 10

/datum/daemon/items/do_work()
	for(var/thing in processing_objects)
		var/obj/item = thing
		if(item && !deleted(item))
			item.process()
		check_suspend()

/datum/daemon/items/status()
	return "[processing_objects.len]"