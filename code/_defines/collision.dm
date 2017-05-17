#define COLLIDE_NONE        0
#define COLLIDE_WORLD       1
#define COLLIDE_MOBS        2
#define COLLIDE_OBJECTS     4
#define COLLIDE_STRUCTURES  8
#define COLLIDE_PROJECTILES 16
//supports up to 16 flags (2^15 maximum value). You can expand this by creating multiple flag/mask variables and extending the collision logic. You probably shouldn't need to though.

#define COLLIDE_ALL 31 //remember to update whenever you expand the collision flag set. Should be the OR of all values together, or 2^X-1 where X is the number of flags that have been defined.
