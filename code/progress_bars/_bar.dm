/client
	var/list/progress_bars

/image/progress_bar
	appearance_flags = NO_CLIENT_COLOR | RESET_TRANSFORM

/mob/verb/bartest()
	var/datum/progress_bar/bar = new(client, src)
	bar.Start(rand(30,60))

/datum/progress_bar
	var/client/owner
	var/image/bar
	var/image/bar_progress
	var/image/bar_overlay
	var/const/bar_size = -15 // -(size of icon/2)
	var/static/list/progress_colours = list(DARK_RED, PALE_RED, DARK_GREEN, PALE_GREEN)

/datum/progress_bar/New(var/client/_owner, var/atom/target)
	owner = _owner
	if(!owner.progress_bars)
		owner.progress_bars = list(src)
	else
		owner.progress_bars += src

	bar =          new /image/progress_bar(loc = target, icon = 'icons/images/progress.dmi', icon_state = "underlay")
	bar_overlay =  new /image/progress_bar(loc = target, icon = 'icons/images/progress.dmi', icon_state = "overlay")
	bar_progress = new /image/progress_bar(loc = target, icon = 'icons/images/progress.dmi', icon_state = "progress")

	bar.pixel_y = 32 + (owner.progress_bars.len - 1)*5
	bar_overlay.pixel_y = bar.pixel_y
	bar_progress.pixel_y = bar.pixel_y

	owner.images += bar
	owner.images += bar_progress
	owner.images += bar_overlay

/datum/progress_bar/Destroy()

	if(owner)
		owner.images -= bar
		owner.images -= bar_progress
		owner.images -= bar_overlay
		owner.progress_bars -= src
		if(!owner.progress_bars.len) owner.progress_bars = null
		owner = null

	bar = null
	bar_progress = null
	bar_overlay = null
	. = ..()

/datum/progress_bar/proc/Start(var/lifetime)

	set waitfor = 0
	var/time_interval = lifetime / progress_colours.len
	var/scale_interval = 1 / progress_colours.len
	var/translation_interval = abs(bar_size / progress_colours.len)

	var/matrix/M = matrix()
	M.Scale(0,1)
	M.Translate(bar_size,0)
	bar_progress.transform = M

	var/i = 1
	for(var/col in progress_colours)
		bar_progress.color = col
		M = null
		if(i != progress_colours.len)
			M = matrix()
			M.Scale(scale_interval * i, 1)
			M.Translate(bar_size + translation_interval * i, 0)
		animate(bar_progress, transform = M, time = time_interval)
		i++
		sleep(time_interval)
	sleep(1)
	QDel(src)
