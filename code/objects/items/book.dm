/obj/item/written
	name = "note"
	icon = 'icons/objects/items/note.dmi'
	default_material_path = /datum/material/paper
	var/book_type = "note"
	var/open_message = "examine"
	var/written_contents = "Lorem ipsum."

/obj/item/written/ExaminedBy(var/mob/user)
	if(..(user))
		if(written_contents)
			user.Notify("You [open_message] \the [src]. It reads:")
			user.Notify(written_contents)
		else
			user.Notify("\The [src] is blank.")

/obj/item/written/scroll
	name = "scroll"
	icon = 'icons/objects/items/scroll.dmi'
	book_type = "scroll"
	open_message = "unroll"

/obj/item/written/book
	name = "book"
	icon = 'icons/objects/items/book.dmi'
	book_type = "book"
	open_message = "open"
	default_material_path = /datum/material/leather

/obj/item/written/book/UpdateStrings()
	if(material)
		name = "[material.GetName()]bound [book_type]"
	else
		name = book_type
