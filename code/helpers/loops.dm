//returns the association index for the first instance of value
/proc/FindListAssociation(list/L, value)
	for(var/i in L)
		if(L[i] == value)
			return i
	return 0
