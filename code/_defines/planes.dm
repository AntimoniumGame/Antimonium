//Planes above the world, i.e. UI, screen effects
// starting from the top down (100) for future potential multi-z plane layering (trust me on this one)
#define MENU_PLANE              100                // plane for full screen menus
#define FADE_PLANE              MENU_PLANE - 1     // used for blanking out the ui while leaving the top menu intact
#define UI_PLANE                FADE_PLANE - 1     // ui objects
#define TITLE_PLANE             UI_PLANE - 1       // used for the title screen
#define VISION_PLANE            TITLE_PLANE - 1    // vision impairing effects
#define ABSTRACT_PLANE          VISION_PLANE - 1   // abstract - for dumping other stuff
#define EFFECTS_PLANE           ABSTRACT_PLANE - 1 // for effects that are self lit

#define OVERHEAD_PLANE          MASTER_PLANE + 1   // For roofs and tree canopies.
#define MASTER_PLANE            1

//Planes below the world, i.e. lighting
#define LIGHTING_PLANE          -1                  // lighting plane
#define BACKDROP_PLANE          LIGHTING_PLANE - 1  // used for the lighting backdrop


//Layers... like an onion

//atom layers
#define UNDERLAY_LAYER          0
#define AREA_LAYER 				UNDERLAY_LAYER + 1
#define TURF_LAYER              AREA_LAYER + 1
#define OBJ_LAYER				TURF_LAYER + 1
#define ITEM_LAYER              OBJ_LAYER + 1
#define MOB_LAYER               ITEM_LAYER + 1
#define EFFECTS_LAYER           MOB_LAYER + 1		// effects that should be rendered in the world and lit by lighting
#define FLY_LAYER 				EFFECTS_LAYER + 1	// this is a byond default layer

//light layers
#define LIGHT_LAYER_AREA        1
#define LIGHT_LAYER_TURF        LIGHT_LAYER_AREA + 1
#define LIGHT_LAYER_BASE        LIGHT_LAYER_TURF + 1
#define LIGHT_LAYER_SHADOW      LIGHT_LAYER_BASE + 1
#define LIGHT_LAYER_OVERLAY     LIGHT_LAYER_SHADOW + 1
#define LIGHT_LAYER_AO          LIGHT_LAYER_OVERLAY + 1
#define LIGHT_LAYER_OVERRIDE    LIGHT_LAYER_AO + 1
