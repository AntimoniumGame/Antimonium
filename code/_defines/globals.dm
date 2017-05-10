var/list/mob_list = list()
var/list/living_mob_list = list()
var/list/dead_mob_list = list()
var/list/cardinal = list(NORTH, SOUTH, EAST, WEST)
var/list/processing_items = list()
var/list/reverse_dirs = list("[NORTH]" = SOUTH, "[SOUTH]" = NORTH, "[EAST]" = WEST, "[WEST]" = EAST)
var/list/clients = list()

