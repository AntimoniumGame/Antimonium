//Sorts an associative list alphabetically
/proc/sort_associated_list(var/list/L)
	var/list/sorted = list()
	var/list/keys = sort_list_keys(L)

	for(var/i = 1 to keys.len)
		var/key = keys[i]
		sorted[key] = L[key]

	return sorted

//Returns a list of keys from an associative list, sorted alphabetically
// Yea this is a basic insertion sort - I'll code something more efficient later
/proc/sort_list_keys(var/list/L)
	var/list/keys = list()
	keys.len = L.len

	for(var/i = 1, i <= L.len, i++)
		var/v = L[i]
		keys[i] = v

	for(var/i = 1 to keys.len)
		for(var/j = i+1 to keys.len)
			if(keys[j] < keys[i])
				keys.Swap(j, i)

	return keys
