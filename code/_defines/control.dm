//keybinds
#define KEY_UP		1
#define KEY_DOWN	2
#define KEY_RIGHT	3
#define KEY_LEFT	4
#define KEY_RUN		5
#define KEY_CHAT	6
#define KEY_MENU	7

//mapping keybind dirs to directions
var/list/__dirs = list(NORTH, SOUTH, EAST, WEST)

#define bind2dir(b)	__dirs[b]
