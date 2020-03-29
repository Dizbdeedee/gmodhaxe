package gmod.enums;
/**
    Surface flags, used by the TraceResult structure.
**/
@:native("_G")
extern enum abstract SURF(Int) {
    /**
        This surface is a trigger
    **/
    var SURF_TRIGGER;
    /**
        This surface is a skybox, equivalent to HitSky in [TraceResultstructure](https://wiki.garrysmod.com/page/Structures/TraceResult)
    **/
    var SURF_SKY;
    /**
        Value will hold the light strength
    **/
    var SURF_LIGHT;
    /**
        This surface is translucent
    **/
    var SURF_TRANS;
    /**
        The surface is a 2D skybox
    **/
    var SURF_SKY2D;
    /**
        This surface is part of an entity's hitbox
    **/
    var SURF_HITBOX;
    /**
        Don't subdivide patches on this surface
    **/
    var SURF_NOCHOP;
    /**
        No decals are applied to this surface
    **/
    var SURF_NODECALS;
    /**
        Calculate three lightmaps for the surface for bumpmapping
    **/
    var SURF_BUMPLIGHT;
    /**
        This surface has no lights calculated
    **/
    var SURF_NOLIGHT;
    /**
        This surface can be ignored by impact effects
    **/
    var SURF_SKIP;
    /**
        This surface is an invisible entity, equivalent to HitNoDraw in [TraceResultstructure](https://wiki.garrysmod.com/page/Structures/TraceResult)
    **/
    var SURF_NODRAW;
    /**
        No shadows are cast on this surface
    **/
    var SURF_NOSHADOWS;
    /**
        This surface cannot have portals placed on, used by Portal's gun
    **/
    var SURF_NOPORTAL;
    /**
        Make a primary bsp splitter
    **/
    var SURF_HINT;
    /**
        This surface is animated water
    **/
    var SURF_WARP;
    
}