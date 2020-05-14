package gmod.enums;
/**
    Bit flags used by GetRenderTargetEx. Clientside only. Information taken from here
	**Warning:** These enumerations do not exist in the game and are listed here purely for reference purposes only.
**/
@:native("_G")
extern enum abstract TEXTUREFLAGS(Int) {
    /**
        Not affected by texture resolution settings.
    **/
    var TEXTUREFLAGS_NOLOD;
    /**
        Texture is an environment map.
    **/
    var TEXTUREFLAGS_ENVMAP;
    /**
        Used in skyboxes. Makes sure edges are seamless.
    **/
    var TEXTUREFLAGS_HINT_DXT5;
    /**
        Clamp T coordinates.
    **/
    var TEXTUREFLAGS_CLAMPT;
    /**
        Texture is an procedural texture (code can modify it).
    **/
    var TEXTUREFLAGS_PROCEDURAL;
    /**
        
    **/
    var TEXTUREFLAGS_NODEBUGOVERRIDE;
    /**
        No Minimum Mipmap
    **/
    var TEXTUREFLAGS_ALL_MIPS;
    /**
        Render largest mipmap only. (Does not delete existing mipmaps, just disables them.)
    **/
    var TEXTUREFLAGS_NOMIP;
    /**
        Low quality, "pixel art" texture filtering.
    **/
    var TEXTUREFLAGS_POINTSAMPLE;
    /**
        
    **/
    var TEXTUREFLAGS_UNUSED_00200000;
    /**
        
    **/
    var TEXTUREFLAGS_UNUSED_00400000;
    /**
        Texture is a normal map.
    **/
    var TEXTUREFLAGS_NORMAL;
    /**
        One bit alpha channel used.
    **/
    var TEXTUREFLAGS_ONEBITALPHA;
    /**
        Clamp to border colour on all texture coordinates
    **/
    var TEXTUREFLAGS_BORDER;
    /**
        
    **/
    var TEXTUREFLAGS_UNUSED_01000000;
    /**
        Medium quality texture filtering.
    **/
    var TEXTUREFLAGS_TRILINEAR;
    /**
        Eight bit alpha channel used.
    **/
    var TEXTUREFLAGS_EIGHTBITALPHA;
    /**
        Do not buffer for Video Processing, generally render distance.
    **/
    var TEXTUREFLAGS_NODEPTHBUFFER;
    /**
        
    **/
    var TEXTUREFLAGS_UNUSED_40000000;
    /**
        Clamp S coordinates.
    **/
    var TEXTUREFLAGS_CLAMPS;
    /**
        
    **/
    var TEXTUREFLAGS_SINGLECOPY;
    /**
        
    **/
    var TEXTUREFLAGS_UNUSED_10000000;
    /**
        Texture is a SSBump. (SSB)
    **/
    var TEXTUREFLAGS_SSBUMP;
    /**
        
    **/
    var TEXTUREFLAGS_UNUSED_80000000;
    /**
        High quality texture filtering.
    **/
    var TEXTUREFLAGS_ANISOTROPIC;
    /**
        Purpose unknown.
    **/
    var TEXTUREFLAGS_PWL_CORRECTED;
    /**
        Usable as a vertex texture
    **/
    var TEXTUREFLAGS_VERTEXTEXTURE;
    /**
        
    **/
    var TEXTUREFLAGS_UNUSED_00080000;
    /**
        Texture is a render target.
    **/
    var TEXTUREFLAGS_RENDERTARGET;
    /**
        Texture is a depth render target.
    **/
    var TEXTUREFLAGS_DEPTHRENDERTARGET;
    /**
        Clamp U coordinates (for volumetric textures).
    **/
    var TEXTUREFLAGS_CLAMPU;
    /**
        Immediately destroy this texture when its reference count hits zero 
		
		(aka TEXTUREFLAGS_UNUSED_00100000)
    **/
    var TEXTUREFLAGS_IMMEDIATE_CLEANUP;
    
}