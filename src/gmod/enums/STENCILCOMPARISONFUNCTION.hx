package gmod.enums;
/**
    Enumerations for use with render.SetStencilCompareFunction. 
	
	The comparison is between the reference value set by render.SetStencilReferenceValue, and the value of each pixel in the stencil buffer. 
	
	 Clientside only.
	**Note:** These enumerations are also mirrored as STENCIL_ Enums.
**/
@:native("_G")
extern enum abstract STENCILCOMPARISONFUNCTION(Int) {
    /**
        Passes where the reference value is greater than or equal to the stencil value.
    **/
    var STENCILCOMPARISONFUNCTION_GREATEREQUAL;
    /**
        Passes where the reference value is less than or equal to the stencil value.
    **/
    var STENCILCOMPARISONFUNCTION_LESSEQUAL;
    /**
        Never passes.
    **/
    var STENCILCOMPARISONFUNCTION_NEVER;
    /**
        Passes where the reference value is equal to the stencil value.
    **/
    var STENCILCOMPARISONFUNCTION_EQUAL;
    /**
        Passes where the reference value is greater than the stencil value.
    **/
    var STENCILCOMPARISONFUNCTION_GREATER;
    /**
        Passes where the reference value is not equal to the stencil value.
    **/
    var STENCILCOMPARISONFUNCTION_NOTEQUAL;
    /**
        Always passes.
    **/
    var STENCILCOMPARISONFUNCTION_ALWAYS;
    /**
        Passes where the reference value is less than the stencil value.
    **/
    var STENCILCOMPARISONFUNCTION_LESS;
    
}