package gmod.enums;
/**
    Enumerations used by GetRenderTargetEx. Clientside only.
**/
@:native("_G")
extern enum abstract RT_SIZE(Int) {
    /**
        Same size as the frame buffer, rounded up if necessary for systems that can't do non-power of two textures.
    **/
    var RT_SIZE_FULL_FRAME_BUFFER_ROUNDED_UP;
    /**
        Same size as frame buffer, or next lower power of 2 if we can't do that.
    **/
    var RT_SIZE_FULL_FRAME_BUFFER;
    /**
        Don't play with the specified width and height other than making sure it fits in the framebuffer.
    **/
    var RT_SIZE_DEFAULT;
    /**
        Target of specified size, don't mess with dimensions
    **/
    var RT_SIZE_OFFSCREEN;
    /**
        Only allowed for render targets that don't want a depth buffer (because if they have a depth buffer, the render target must be less than or equal to the size of the framebuffer).
    **/
    var RT_SIZE_NO_CHANGE;
    /**
        Apply picmip to the render target's width and height.
    **/
    var RT_SIZE_PICMIP;
    /**
        Use the size passed in. Don't clamp it to the frame buffer size. Really.
    **/
    var RT_SIZE_LITERAL;
    /**
        Rounded down to power of 2, essentially
    **/
    var RT_SIZE_REPLAY_SCREENSHOT;
    /**
        frame_buffer_width / 4
    **/
    var RT_SIZE_HDR;
    /**
        
    **/
    var RT_SIZE_LITERAL_PICMIP;
    
}