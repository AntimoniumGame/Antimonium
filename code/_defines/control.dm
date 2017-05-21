//keybinds
#define KEY_UP      1
#define KEY_DOWN    2
#define KEY_RIGHT   3
#define KEY_LEFT    4
#define KEY_RUN     5
#define KEY_CHAT    6
#define KEY_MENU    7
#define KEY_DEV     8
#define KEY_VARS    9
#define KEY_DROP_L 10
#define KEY_DROP_R 11
#define KEY_INTENT 12

//mapping keybind dirs to directions
var/list/__dirs = list(NORTH, SOUTH, EAST, WEST)
#define bind2dir(b) __dirs[b]

var/list/__keylist = list("Move up", "Move down", "Move right", "Move left", "Run", "Chat", "Menu", "Dev panel", "View vars", "Drop left item", "Drop right item", "Change intent")
#define bind2key(b) __keylist[b]
#define key2bind(b) __keylist.Find(b)
