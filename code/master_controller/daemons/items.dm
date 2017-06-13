/datum/daemon/items
	name = "items"
	delay = 10

/datum/daemon/items/DoWork()
	for(var/thing in processing_objects)
		var/obj/item = thing
		if(item && !Deleted(item))
			item.Process()
		CHECK_SUSPEND

/datum/daemon/items/Status()
	return "[processing_objects.len]"