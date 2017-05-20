var/list/unique_data_by_path = list()

/proc/GetUniqueDataByPath(var/upath)
	if(!unique_data_by_path[upath])
		unique_data_by_path[upath] = new upath()
	return unique_data_by_path[upath]
