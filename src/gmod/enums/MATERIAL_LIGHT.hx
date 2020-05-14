package gmod.enums;
/**
    Enumerations used by render.SetLocalModelLights. Clientside only.
**/
@:native("_G")
extern enum abstract MATERIAL_LIGHT(Int) {
    /**
        Spot light
    **/
    var MATERIAL_LIGHT_SPOT;
    /**
        Point light
    **/
    var MATERIAL_LIGHT_POINT;
    /**
        Directional light
    **/
    var MATERIAL_LIGHT_DIRECTIONAL;
    /**
        No light
    **/
    var MATERIAL_LIGHT_DISABLE;
    
}