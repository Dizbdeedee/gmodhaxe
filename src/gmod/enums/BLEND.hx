package gmod.enums;
/**
    Used by render.OverrideBlend to determine how texture RGBA information should be interpreted when rendered. 
	
	For more information refer to OpenGL's glBlendFunc page here: https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/glBlendFunc.xhtml 
	
	 Clientside only.
**/
@:native("_G")
extern enum abstract BLEND(Int) {
    /**
        
    **/
    var BLEND_ONE;
    /**
        
    **/
    var BLEND_SRC_ALPHA;
    /**
        
    **/
    var BLEND_SRC_ALPHA_SATURATE;
    /**
        
    **/
    var BLEND_SRC_COLOR;
    /**
        
    **/
    var BLEND_DST_COLOR;
    /**
        
    **/
    var BLEND_ONE_MINUS_DST_ALPHA;
    /**
        
    **/
    var BLEND_DST_ALPHA;
    /**
        
    **/
    var BLEND_ONE_MINUS_SRC_ALPHA;
    /**
        
    **/
    var BLEND_ZERO;
    /**
        
    **/
    var BLEND_ONE_MINUS_DST_COLOR;
    /**
        
    **/
    var BLEND_ONE_MINUS_SRC_COLOR;
    
}