/proc/InitializeConfig()
	// Add default config options here as assoc list assignments.
	_glob.config = list()
	for(var/line in File2List("data/config.txt"))
		var/list/linetext = splittext(line, "::")
		_glob.config[lowertext(TrimSpaces(linetext[1]))] = TrimSpaces(linetext[2])
	for(var/config_tag in _glob.config_numeric)
		if(!isnull(_glob.config[config_tag]) && !isnull(text2num(_glob.config[config_tag])))
			_glob.config[config_tag] = text2num(_glob.config[config_tag])
