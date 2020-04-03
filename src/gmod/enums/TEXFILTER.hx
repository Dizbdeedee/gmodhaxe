package gmod.enums;
/**
    Enumerations used by render.PushFilterMin and render.PushFilterMag. 
	
	See this and this page for more information on texture filtering.
**/
@:native("_G.TEXFILTER")
extern enum abstract TEXFILTER(Int) {
    /**
       
    **/
    var LINEAR;
    /**
        
    **/
    var NONE;
    /**
        
    **/
    var ANISOTROPIC;
    /**
        
    **/
    var POINT;
    
}