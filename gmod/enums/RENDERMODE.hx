package gmod.enums;
/**
    Enumerations used by Entity:SetRenderMode and Entity:GetRenderMode.
**/
@:native("_G")
extern enum abstract RENDERMODE(Int) {
    /**
        Supports transparency.
    **/
    var RENDERMODE_TRANSCOLOR;
    /**
        Functions like Additive, but also blends between animation frames. Requires the material to have a functioning animating texture. Allows transparency.
    **/
    var RENDERMODE_TRANSADDFRAMEBLEND;
    /**
        Intended for glowing sprites. Allows transparency, and forces the sprite or model to be rendered unlit. The size of a sprite rendered with Glow is consistent with the screen size (unlike the alternative World Space Glow), making it appear larger at a distance, in comparison to the world. 
		
		The GlowProxySize keyvalue affects this Render Mode on sprites.
    **/
    var RENDERMODE_GLOW;
    /**
        Enables Alphatesting. Legacy port from Goldsource. Obsolete in Source due to Alphatesting being handled in materials. Does not allow transparency. Use this to make alpha of Color work for your entity. For players, it must be set for their active weapon aswell.
    **/
    var RENDERMODE_TRANSALPHA;
    /**
        Causes the material to be not be drawn at all, similarly to Don't Render.
    **/
    var RENDERMODE_ENVIROMENTAL;
    /**
        The entity is still being drawn and networked albeit invisible, therefore not making this Render Mode ideal for performance reasons. To completely avoid drawing and networking an entity, see EF_NODRAW.
    **/
    var RENDERMODE_NONE;
    /**
        Add the material's color values to the existing image, instead of performing a multiplication. Sprites will appear through world geometry and the sprite/model will always brighten the world. Allows transparency.
    **/
    var RENDERMODE_TRANSADD;
    /**
        Functions similarly to Additive, except that the alpha channel controls the opacity of the sprite. An example of use is for dark sprites, with an example material being sprites/strider_blackball.vmt.
    **/
    var RENDERMODE_TRANSALPHADD;
    /**
        
    **/
    var RENDERMODE_TRANSTEXTURE;
    /**
        Default render mode. Transparently has no effect.
    **/
    var RENDERMODE_NORMAL;
    /**
        Functions similarly to Glow, with the exception that the size of the sprite is relative to the world rather than the screen. The GlowProxySize keyvalue affects this Render Mode on sprites.
    **/
    var RENDERMODE_WORLDGLOW;
    
}