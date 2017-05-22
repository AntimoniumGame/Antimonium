var/list/__default_flags = list(
    "1" =       1,
    "2" =       2,
    "4" =       4,
    "8" =       8,
    "16" =      16,
    "32" =      32,
    "64" =      64,
    "128" =     128,
    "256" =     256,
    "512" =     512,
    "1024" =    1024,
    "2048" =    2048,
    "4096" =    4096,
    "8192" =    8192,
    "16384" =   16384,
    "32768" =   32768
    )

var/list/__sight_flags = list(
    "[SEE_INFRA]" =         "SEE_INFRA",
    "[SEE_SELF]" =          "SEE_SELF",
    "[SEE_MOBS]" =          "SEE_MOBS",
    "[SEE_OBJS]" =          "SEE_OBJS",
    "[SEE_TURFS]" =         "SEE_TURFS",
    "[SEE_PIXELS]" =        "SEE_PIXELS",
    "[SEE_THRU]" =          "SEE_THRU",
    "[SEE_BLACKNESS]" =     "SEE_BLACKNESS",
    "[BLIND]" =             "BLIND"
    )

var/list/__sight_flag_names = list(
    "SEE_INFRA" =           SEE_INFRA,
    "SEE_SELF" =            SEE_SELF,
    "SEE_MOBS" =            SEE_MOBS,
    "SEE_OBJS" =            SEE_MOBS,
    "SEE_TURFS" =           SEE_TURFS,
    "SEE_PIXELS" =          SEE_PIXELS,
    "SEE_THRU" =            SEE_THRU,
    "SEE_BLACKNESS" =       SEE_BLACKNESS,
    "BLIND" =               BLIND
    )

var/list/__blend_mode_flags = list(
    "[BLEND_DEFAULT]" =     "BLEND_DEFAULT",
    "[BLEND_OVERLAY]" =     "BLEND_OVERLAY",
    "[BLEND_ADD]" =         "BLEND_ADD",
    "[BLEND_SUBTRACT]" =    "BLEND_SUBTRACT",
    "[BLEND_MULTIPLY]" =    "BLEND_MULTIPLY"
    )

var/list/__blend_mode_flag_names = list(
    "BLEND_DEFAULT" =       BLEND_DEFAULT,
    "BLEND_OVERLAY" =       BLEND_OVERLAY,
    "BLEND_ADD" =           BLEND_ADD,
    "BLEND_SUBTRACT" =      BLEND_SUBTRACT,
    "BLEND_MULTIPLY" =      BLEND_MULTIPLY
    )

var/list/__appearance_flags = list(
    "[LONG_GLIDE]" =        "LONG_GLIDE",
    "[RESET_COLOR]" =       "RESET_COLOR",
    "[RESET_ALPHA]" =       "RESET_ALPHA",
    "[RESET_TRANSFORM]" =   "RESET_TRANSFORM",
    "[NO_CLIENT_COLOR]" =   "NO_CLIENT_COLOR",
    "[KEEP_TOGETHER]" =     "KEEP_TOGETHER",
    "[KEEP_APART]" =        "KEEP_APART",
    "[PLANE_MASTER]" =      "PLANE_MASTER",
    "[TILE_BOUND]" =        "TILE_BOUND",
    "[PIXEL_SCALE]" =       "PIXEL_SCALE"
    )

var/list/__appearance_flag_names = list(
    "LONG_GLIDE" =          LONG_GLIDE,
    "RESET_COLOR" =         RESET_COLOR,
    "RESET_ALPHA" =         RESET_ALPHA,
    "RESET_TRANSFORM" =     RESET_TRANSFORM,
    "NO_CLIENT_COLOR" =     NO_CLIENT_COLOR,
    "KEEP_TOGETHER" =       KEEP_TOGETHER,
    "KEEP_APART" =          KEEP_APART,
    "PLANE_MASTER" =        PLANE_MASTER,
    "TILE_BOUND" =          TILE_BOUND,
    "PIXEL_SCALE" =         PIXEL_SCALE
    )
