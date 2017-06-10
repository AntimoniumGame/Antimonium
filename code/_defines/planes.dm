//Planes above the world, i.e. UI, screen effects
// starting from the top down (100) for future potential multi-z plane layering (trust me on this one)
#define MENU_PLANE              100              // plane for full screen menus
#define FADE_PLANE              MENU_PLANE - 1   // used for blanking out the ui while leaving the top menu intact
#define UI_PLANE                FADE_PLANE - 1   // ui objects
#define TITLE_PLANE             UI_PLANE - 1     // used for the title screen
#define VISION_PLANE            TITLE_PLANE - 1  // vision impairing effects
#define ABSTRACT_PLANE          VISION_PLANE - 1 // abstract

#define MASTER_PLANE            1

//Planes below the world, i.e. lighting
#define LIGHTING_PLANE          -1                  // lighting plane
#define BACKDROP_PLANE          LIGHTING_PLANE - 1  // used for the lighting backdrop


//Layers... like an onion
#define SCREEN_EFFECTS_LAYER    5
#define SCREEN_LAYER            4

#define MOB_LAYER               3
#define ITEM_LAYER              2
#define TURF_LAYER              1
#define UNDERLAY_LAYER          0


#define SCREEN_BARRIER_SIZE     25

//light layers
#define LIGHT_LAYER_AREA        1
#define LIGHT_LAYER_TURF        LIGHT_LAYER_AREA + 1
#define LIGHT_LAYER_BASE        LIGHT_LAYER_TURF + 1
#define LIGHT_LAYER_SHADOW      LIGHT_LAYER_BASE + 1
#define LIGHT_LAYER_OVERLAY     LIGHT_LAYER_SHADOW + 1
#define LIGHT_LAYER_AO          LIGHT_LAYER_OVERLAY + 1
#define LIGHT_LAYER_OVERRIDE    LIGHT_LAYER_AO + 1
