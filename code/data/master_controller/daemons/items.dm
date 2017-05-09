/data/daemon/items
	name = "items"
	delay = 10

/data/daemon/items/do_work()
	for(var/thing in processing_items)
		var/obj/item/item = thing
		if(item && !deleted(item))
			item.process()
		check_suspend()

/data/daemon/items/status()
	return "[processing_items.len]"