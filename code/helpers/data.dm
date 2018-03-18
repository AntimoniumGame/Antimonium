/proc/GetUniqueDataByPath(var/upath)
	if(!_glob.unique_data_by_path[upath])
		_glob.unique_data_by_path[upath] = new upath()
	return _glob.unique_data_by_path[upath]
