package gmod.enums;
/**
    Enumerations used by GetRenderTargetEx. Clientside only.
**/
@:native("_G")
extern enum abstract MATERIAL_RT_DEPTH(Int) {
    /**
        Do not create a depth-stencil buffer.Use the default depth-stencil buffer if used as render target 0.
    **/
    var MATERIAL_RT_DEPTH_SHARED;
    /**
        Create a depth-stencil buffer.Use the created depth-stencil buffer if used as render target 0. Creates a color texture despite the name. Seems to behave the same as MATERIAL_RT_DEPTH_SEPARATE.
    **/
    var MATERIAL_RT_DEPTH_ONLY;
    /**
        Do not create a depth-stencil buffer.Disable depth and stencil buffer usage if used as render target 0.
    **/
    var MATERIAL_RT_DEPTH_NONE;
    /**
        Create a depth-stencil buffer.Use the created depth-stencil buffer if used as render target 0.
    **/
    var MATERIAL_RT_DEPTH_SEPARATE;
    
}