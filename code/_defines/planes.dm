//Planes
#define MASTER_PLANE            1

//Planes above the world, i.e. UI, screen effects
#define VISION_PLANE            MASTER_PLANE + 1    // vision impairing effects
#define TITLE_PLANE             VISION_PLANE + 1    // used for the title screen
#define UI_PLANE                TITLE_PLANE + 1     // ui objects
#define FADE_PLANE              UI_PLANE + 1        // used for blanking out the ui while leaving the top menu intact
#define MENU_PLANE              FADE_PLANE + 1      // plane for full screen menus

//Planes below the world, i.e. lighting
#define LIGHTING_PLANE          -1                  // lighting plane
#define BACKDROP_PLANE          LIGHTING_PLANE - 1  // used for the lighting backdrop


//Layers... like an onion
#define UNDERLAY_LAYER          0
#define TURF_LAYER              1
#define ITEM_LAYER              2
#define MOB_LAYER               3

#define SCREEN_LAYER            4
#define SCREEN_EFFECTS_LAYER    5

#define SCREEN_BARRIER_SIZE     25
