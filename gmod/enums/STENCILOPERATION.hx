package gmod.enums;
/**
    Enumerations for use with render.SetStencilPassOperation, render.SetStencilFailOperation and render.SetStencilZFailOperation. Clientside only.
	**Note:** These enumerations are also mirrored as STENCIL_ Enums.
**/
@:native("_G")
extern enum abstract STENCILOPERATION(Int) {
    /**
        Sets the value in the stencil buffer to the reference value, set using [render](https://wiki.garrysmod.com/page/Category:render).[SetStencilReferenceValue](https://wiki.garrysmod.com/page/render/SetStencilReferenceValue).
    **/
    var STENCILOPERATION_REPLACE;
    /**
        Decrements the value in the stencil buffer by 1, wrapping around on overflow.
    **/
    var STENCILOPERATION_DECR;
    /**
        Decrements the value in the stencil buffer by 1, clamping the result.
    **/
    var STENCILOPERATION_DECRSAT;
    /**
        Preserves the existing stencil buffer value.
    **/
    var STENCILOPERATION_KEEP;
    /**
        Sets the value in the stencil buffer to 0.
    **/
    var STENCILOPERATION_ZERO;
    /**
        Inverts the value in the stencil buffer.
    **/
    var STENCILOPERATION_INVERT;
    /**
        Increments the value in the stencil buffer by 1, wrapping around on overflow.
    **/
    var STENCILOPERATION_INCR;
    /**
        Increments the value in the stencil buffer by 1, clamping the result.
    **/
    var STENCILOPERATION_INCRSAT;
    
}