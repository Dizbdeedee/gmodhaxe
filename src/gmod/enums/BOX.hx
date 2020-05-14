package gmod.enums;
/**
    Enumerations used by render.SetModelLighting.
**/
@:native("_G")
extern enum abstract BOX(Int) {
    /**
        Place the light to the right
    **/
    var BOX_RIGHT;
    /**
        Place the light to the left
    **/
    var BOX_LEFT;
    /**
        Place the light to the bottom
    **/
    var BOX_BOTTOM;
    /**
        Place the light from the front
    **/
    var BOX_FRONT;
    /**
        Place the light behind
    **/
    var BOX_BACK;
    /**
        Place the light to the top
    **/
    var BOX_TOP;
    
}