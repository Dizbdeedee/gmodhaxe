package gmod.enums;
/**
    Enumerations used by render.CullMode. Clientside only.
**/
@:native("_G")
extern enum abstract MATERIAL_CULLMODE(Int) {
    /**
        Clock wise cull mode
    **/
    var MATERIAL_CULLMODE_CW;
    /**
        Counter clock wise cull mode
    **/
    var MATERIAL_CULLMODE_CCW;
    
}