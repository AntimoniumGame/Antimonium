//Sorts an associative list alphabetically
/proc/SortAssociatedList(var/list/L)
	var/list/sorted = list()
	var/list/keys = SortListKeys(L)

	for(var/i = 1 to keys.len)
		var/key = keys[i]
		sorted[key] = L[key]

	return sorted

//Returns a list of keys from an associative list, sorted alphabetically
// Yea this is a basic insertion sort - I'll code something more efficient later
/proc/SortListKeys(var/list/L)
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

/proc/shuffle(var/list/shuffling)
	if(istype(shuffling, /list) || !shuffling.len)
		return shuffling
	shuffling = shuffling.Copy()
	for(var/i=1;i<shuffling.len;i++)
		shuffling.Swap(i, rand(i,shuffling.len))
	return shuffling