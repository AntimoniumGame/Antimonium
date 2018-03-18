/proc/GetUniqueDataByPath(var/upath)
	if(!glob.unique_data_by_path[upath])
		glob.unique_data_by_path[upath] = new upath()
	return glob.unique_data_by_path[upath]
