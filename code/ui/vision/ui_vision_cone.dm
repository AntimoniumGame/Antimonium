/////////////VISION CONE///////////////
//Vision cone code by Matt and Honkertron. This vision cone code allows for mobs and/or items to blocked out from a players field of vision.
//This code makes use of the "cone of effect" proc created by Lummox, contributed by Jtgibson. More info on that here:
//http://www.byond.com/forum/?post=195138
///////////////////////////////////////

//"Made specially for Otuska"
// - Honker

// Ported by Zuhayr for Antimonium May 2017.

//Defines.
#define OPPOSITE_DIR(D) turn(D, 180)

/obj/ui/vision_cone
	icon = 'icons/images/hide.dmi'
	icon_state = "combat"
	name = ""
	screen_loc = "1,1"
	mouse_opacity = 0
	layer = 0

/obj/ui/vision_cone/Center(var/view_x, var/view_y)
	screen_loc = "[round(view_x/2)-6],[round(view_y/2)-6]"
	var/matrix/M = matrix()
	view_x = max(1,round(view_x/7))
	view_y = max(1,round(view_y/7))

	if(view_x > view_y)
		M.Scale(view_x,view_x)
	else
		M.Scale(view_y,view_y)
	transform = M

/mob
	var/obj/ui/vision_cone/vision_cone

/client
	var/list/hidden_atoms = list()
	var/list/hidden_mobs = list()

/atom/proc/InCone(atom/center = usr, dir = NORTH)
	if(get_dist(center, src) == 0 || src == center) return 0
	var/d = get_dir(center, src)

	if(!d || d == dir) return 1
	if(dir & (dir-1))
		return (d & ~dir) ? 0 : 1
	if(!(d & dir)) return 0
	var/dx = abs(x - center.x)
	var/dy = abs(y - center.y)
	if(dx == dy) return 1
	if(dy > dx)
		return (dir & (NORTH|SOUTH)) ? 1 : 0
	return (dir & (EAST|WEST)) ? 1 : 0

/mob/dead/InCone(mob/center = usr, dir = NORTH)
	return

/mob/human/InCone(mob/center = usr, dir = NORTH)
	. = ..()
	for(var/obj/item/grab/G in center)
		if(src == G.grabbed)
			return 0
		else
			return .

/proc/Cone(var/atom/center = usr, var/dir = NORTH, var/list/olist = oview(center))
	for(var/atom/O in olist)
		if(!O.InCone(center, dir))
			olist -= O
	return olist

/mob/proc/UpdateVisionCone()

	if(!client || !vision_cone) // too early
		return

	var/delay = 10
	for(var/image/I in client.hidden_atoms)
		I.override = 0
		spawn(delay)
			QDel(I)
		delay += 10

	if(prone)
		HideCone()
	else
		ShowCone()

	client.hidden_atoms = list()
	client.hidden_mobs = list()

	vision_cone.dir = dir
	if(vision_cone.alpha != 0)
		for(var/mob/M in Cone(src, OPPOSITE_DIR(dir), view(10, src)))
			if(M.dead && M.invisibility > invisibility)
				continue
			var/image/I = image("split", M)
			I.override = 1
			client.images += I
			client.hidden_atoms += I
			client.hidden_mobs += M

//Making these generic procs so you can call them anywhere.
/mob/proc/ShowCone()
	if(vision_cone) vision_cone.alpha = 255

/mob/proc/HideCone()
	if(vision_cone) vision_cone.alpha = 0