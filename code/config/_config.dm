/proc/InitializeConfig()
	// Add default config options here as assoc list assignments.
	glob.config = list()
	for(var/line in File2List("data/config.txt"))
		var/list/linetext = splittext(line, "::")
		glob.config[lowertext(TrimSpaces(linetext[1]))] = TrimSpaces(linetext[2])
	for(var/config_tag in glob.config_numeric)
		if(!isnull(glob.config[config_tag]) && !isnull(text2num(glob.config[config_tag])))
			glob.config[config_tag] = text2num(glob.config[config_tag])
