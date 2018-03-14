var/list/config = list()
var/list/config_numeric = list()

/proc/InitializeConfig()
	// Add default config options here as assoc list assignments.
	config = list()
	for(var/line in File2List("data/config.txt"))
		var/list/linetext = splittext(line, "::")
		config[lowertext(TrimSpaces(linetext[1]))] = TrimSpaces(linetext[2])
	for(var/config_tag in config_numeric)
		if(!isnull(config[config_tag]) && !isnull(text2num(config[config_tag])))
			config[config_tag] = text2num(config[config_tag])
