/client/proc/DevPanel()
	set waitfor = 0
	//TODO: write permissions code
	if(winget(src, "devwindow", "is-visible") == "false")
		winset(src, "devwindow", "is-visible=true")
	else
		winset(src, "devwindow", "is-visible=false")
