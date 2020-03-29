package gmod.enums;
/**
    Enumerations for use with render.SetStencilCompareFunction. 
	
	The comparison is between the reference value set by render.SetStencilReferenceValue, and the value of each pixel in the stencil buffer. 
	
	 Clientside only. 
	
	 These enumerations are mirrors of STENCILCOMPARISONFUNCTION_ Enums. 
	
	 Also see this corresponding MSDN entry: http://msdn.microsoft.com/en-us/library/windows/desktop/ff476101%28v=vs.85%29.aspx.
**/
@:native("_G")
extern enum abstract STENCIL(Int) {
    /**
        Always passes.
    **/
    var STENCIL_ALWAYS;
    /**
        Passes where the reference value is greater than or equal to the stencil value.
    **/
    var STENCIL_GREATEREQUAL;
    /**
        Passes where the reference value is less than the stencil value.
    **/
    var STENCIL_LESS;
    /**
        Passes where the reference value is less than or equal to the stencil value.
    **/
    var STENCIL_LESSEQUAL;
    /**
        Passes where the reference value is greater than the stencil value.
    **/
    var STENCIL_GREATER;
    /**
        Passes where the reference value is not equal to the stencil value.
    **/
    var STENCIL_NOTEQUAL;
    /**
        Passes where the reference value is equal to the stencil value.
    **/
    var STENCIL_EQUAL;
    /**
        Never passes.
    **/
    var STENCIL_NEVER;
    
}