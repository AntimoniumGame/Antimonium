/obj/item/written
	name = "note"
	icon = 'icons/objects/items/note.dmi'
	default_material_path = /datum/material/paper
	var/book_type = "note"
	var/open_message = "examine"
	var/written_contents = "Lorem ipsum."

/obj/item/written/ExaminedBy(var/mob/user)
	if(..(user))

		if(user.HasEffect(EFFECT_BLINDED))
			user.Notify("<span class='warning'>You are blind and cannot read \the [src].</span>.")
		else if(written_contents)
			user.Notify("<span class='notice'>You [open_message] \the [src]. It reads:</span>")
			user.Notify("<span class='notice'>[written_contents]</span>")
		else
			user.Notify("<span class='notice'>\The [src] is blank.</span>")

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
	default_material_path = /datum/material/cloth/leather

/obj/item/written/book/UpdateStrings()
	if(material)
		name = "[material.GetName()]bound [book_type]"
	else
		name = book_type
