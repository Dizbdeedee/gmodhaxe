package gmod.enums;
/**
    Enumerations used by render.GetFogMode and render.FogMode. Clientside only.
**/
@:native("_G")
extern enum abstract MATERIAL_FOG(Int) {
    /**
        For use in conjunction with [render](https://wiki.garrysmod.com/page/Category:render).[SetFogZ](https://wiki.garrysmod.com/page/render/SetFogZ). Does not work if start distance is bigger than end distance. Ignores density setting. Seems to be broken? Used for underwater fog by the engine.
    **/
    var MATERIAL_FOG_LINEAR_BELOW_FOG_Z;
    /**
        Linear fog
    **/
    var MATERIAL_FOG_LINEAR;
    /**
        No fog
    **/
    var MATERIAL_FOG_NONE;
    
}