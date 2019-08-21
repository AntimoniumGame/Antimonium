/obj/structure/tree
	name = "tree"
	icon = 'icons/objects/structures/tree.dmi'
	icon_state = "stump"
	density = FALSE
	opacity = TRUE
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	layer = TURF_LAYER
	var/image/canopy_hider
	var/obj/structure/canopy/canopy

/obj/structure/tree/New(var/newloc)
	. = ..(newloc)
	canopy = new(newloc, src)

/obj/structure/tree/Destroy()
	QDel(canopy, "tree destroyed")
	. = ..()

/obj/structure/tree/Move()
	. = ..()
	if(.)
		loc = canopy.loc

/obj/structure/canopy
	density = TRUE
	opacity = FALSE
	name = "tree canopy"
	layer = EFFECTS_LAYER
	icon = 'icons/objects/structures/tree.dmi'
	icon_state = "canopy"
	pixel_x = -32
	pixel_y = -32
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	var/obj/stump

/obj/structure/canopy/Move()
	. = ..()
	if(.)
		loc = stump.loc

/obj/structure/canopy/Destroy()
	QDel(stump, "tree destroyed")
	. = ..()

/obj/structure/tree/Initialize()
	canopy = image(icon = icon, icon_state = "canopy")
	canopy.layer = EFFECTS_LAYER
	overlays += canopy
	canopy_hider = image(loc = src, icon = icon, icon_state = "stump")
	canopy_hider.override = TRUE
	canopy_hider.layer = layer
	icon_state = "stump"

	if(prob(75))
		var/matrix/M = matrix()
		M.Turn(pick(90, 180, 270))
		transform = M
	. = ..()

/obj/structure/tree/ManipulatedBy(var/mob/user, var/obj/item/prop, var/slot)
	. = ..()
	if(!. && !user.OnActionCooldown())
		overlays.Cut()

/obj/structure/tree/Crossed(atom/movable/O)
	. = ..()
	var/mob/M = O
	if(istype(M) && M.client)
		M.client.images |= canopy_hider

/obj/structure/tree/Uncrossed(atom/movable/O)
	. = ..()
	var/mob/M = O
	if(istype(M) && M.client)
		M.client.images -= canopy_hider
