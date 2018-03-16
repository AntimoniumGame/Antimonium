// Floors.
/turf/floor
	icon_state = "1"

/turf/floor/dirt
	name = "dirt"
	icon = 'icons/turfs/dirt_floor.dmi'

/turf/floor/water
	name = "water"
	icon = 'icons/turfs/water_floor.dmi'

/turf/floor/water/New(var/newloc)
	..(newloc, _floor_material = /datum/material/water, _wall_material = null)

/turf/floor/sand
	name = "sand"
	icon = 'icons/turfs/sand_floor.dmi'

/turf/floor/sand/New(var/newloc)
	..(newloc, _floor_material = /datum/material/stone/glass/sand, _wall_material = null)

/turf/floor/wood
	name = "wooden floor"
	icon = 'icons/turfs/wood_floor.dmi'

/turf/floor/wood/New(var/newloc)
	..(newloc, _floor_material = /datum/material/wood, _wall_material = null)

/turf/floor/brick
	name = "flagstones"
	icon = 'icons/turfs/brick_floor.dmi'

/turf/floor/brick/New(var/newloc)
	..(newloc, _floor_material = /datum/material/stone/brick, _wall_material = null)

/turf/wall/brick
	name = "brick wall"
	icon = 'icons/turfs/brick_wall.dmi'

/turf/wall/brick/New(var/newloc)
	..(newloc, _floor_material = /datum/material/stone/brick, _wall_material = /datum/material/stone/brick)

/turf/floor/cobble
	name = "cobblestones"
	icon = 'icons/turfs/cobble_floor.dmi'

/turf/floor/cobble/New(var/newloc)
	..(newloc, _floor_material = /datum/material/stone/cobble, _wall_material = null)

/turf/floor/carpet
	name = "carpet"
	icon = 'icons/turfs/plain_carpet_floor.dmi'

/turf/floor/carpet/New(var/newloc)
	..(newloc, _floor_material = /datum/material/cloth, _wall_material = null)

/turf/floor/fancy_carpet
	name = "carpet"
	icon = 'icons/turfs/fancy_carpet_floor.dmi'

/turf/floor/fancy_carpet/New(var/newloc)
	..(newloc, _floor_material = /datum/material/cloth/silk, _wall_material = null)

/turf/floor/stone
	name = "stone floor"
	icon = 'icons/turfs/stone_floor.dmi'

/turf/floor/stone/New(var/newloc)
	..(newloc, _floor_material = /datum/material/stone, _wall_material = null)

/turf/floor/grass
	name = "grass"
	icon = 'icons/turfs/grass_floor.dmi'

/turf/floor/grass/New(var/newloc)
	..(newloc, _floor_material = /datum/material/dirt/grass, _wall_material = null)

/turf/floor/tiled
	name = "tiled floor"
	icon = 'icons/turfs/tile_floor.dmi'

/turf/floor/tiled/New(var/newloc)
	..(newloc, _floor_material = /datum/material/stone/tiles, _wall_material = null)

/turf/floor/roots
	name = "root floor"
	icon = 'icons/turfs/root_floor.dmi'

/turf/floor/roots/New(var/newloc)
	..(newloc, _floor_material = /datum/material/dirt/roots, _wall_material = null)

// Walls.
/turf/wall
	icon_state = "map"

/turf/wall/cobble
	name = "dressed stone wall"
	icon = 'icons/turfs/cobble_wall.dmi'

/turf/wall/cobble/New(var/newloc)
	..(newloc, _floor_material = null, _wall_material = /datum/material/stone/cobble)

/turf/wall/stone
	name = "stone wall"
	icon = 'icons/turfs/stone_wall.dmi'

/turf/wall/stone/New(var/newloc)
	..(newloc, _floor_material = null, _wall_material = /datum/material/stone)

/turf/wall/tiled
	name = "tiled wall"
	icon = 'icons/turfs/tile_wall.dmi'

/turf/wall/tiled/New(var/newloc)
	..(newloc, _floor_material = null, _wall_material = /datum/material/stone/tiles)

/turf/wall/dirt
	name = "dirt wall"
	icon = 'icons/turfs/dirt_wall.dmi'

/turf/wall/dirt/New(var/newloc)
	..(newloc, _floor_material = null, _wall_material = /datum/material/dirt)

/turf/wall/wood
	name = "wooden wall"
	icon = 'icons/turfs/wood_wall.dmi'

/turf/wall/wood/New(var/newloc)
	..(newloc, _floor_material = null, _wall_material = /datum/material/wood)
