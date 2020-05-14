package gmod.enums;
/**
    Used by ENTITY:Draw and ENTITY:DrawTranslucent.
**/
@:native("_G")
extern enum abstract STUDIO(Int) {
    /**
        Not a studio flag, but used to flag when we want studio stats
    **/
    var STUDIO_GENERATE_STATS;
    /**
        Not a studio flag, but used to flag model as using shadow depth material override
    **/
    var STUDIO_SHADOWDEPTHTEXTURE;
    /**
        Not a studio flag, but used to flag model as a non-sorting brush model
    **/
    var STUDIO_TRANSPARENCY;
    /**
        
    **/
    var STUDIO_STATIC_LIGHTING;
    /**
        Not a studio flag, but used to flag model as using shadow depth material override
    **/
    var STUDIO_SSAODEPTHTEXTURE;
    /**
        
    **/
    var STUDIO_WIREFRAME;
    /**
        
    **/
    var STUDIO_RENDER;
    /**
        
    **/
    var STUDIO_TWOPASS;
    /**
        
    **/
    var STUDIO_VIEWXFORMATTACHMENTS;
    /**
        
    **/
    var STUDIO_WIREFRAME_VCOLLIDE;
    /**
        
    **/
    var STUDIO_DRAWTRANSLUCENTSUBMODELS;
    /**
        
    **/
    var STUDIO_NOSHADOWS;
    /**
        
    **/
    var STUDIO_ITEM_BLINK;
    
}