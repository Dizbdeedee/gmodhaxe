package gmod.enums;
/**
    Enumerations used in TraceResult structure and by Entity:GetMaterialType.
**/
@:native("_G")
extern enum abstract MAT(Int) {
    /**
        Metallic vents
    **/
    var MAT_VENT;
    /**
        Grass
    **/
    var MAT_GRASS;
    /**
        Skybox or nodraw texture
    **/
    var MAT_DEFAULT;
    /**
        Grates, chainlink fences
    **/
    var MAT_GRATE;
    /**
        Water, slime
    **/
    var MAT_SLOSH;
    /**
        Snow
    **/
    var MAT_SNOW;
    /**
        Unused
    **/
    var MAT_CLIP;
    /**
        Metal
    **/
    var MAT_METAL;
    /**
        Wood
    **/
    var MAT_WOOD;
    /**
        Flesh
    **/
    var MAT_FLESH;
    /**
        Glass
    **/
    var MAT_GLASS;
    /**
        Alien flesh - headcrabs and vortigaunts
    **/
    var MAT_ALIENFLESH;
    /**
        Plants, only used by the "foliage" surface property
    **/
    var MAT_FOLIAGE;
    /**
        Electronics, only used by "computer" surface property
    **/
    var MAT_COMPUTER;
    /**
        Antlions
    **/
    var MAT_ANTLION;
    /**
        Plastic
    **/
    var MAT_PLASTIC;
    /**
        Concrete
    **/
    var MAT_CONCRETE;
    /**
        Similar to MAT_FLESH, only used by "bloodyflesh" surface property, has different impact sound
    **/
    var MAT_BLOODYFLESH;
    /**
        The egg sacs in the antlion tunnels in HL2: EP2
    **/
    var MAT_EGGSHELL;
    /**
        "wierd-looking jello effect for advisor shield."
    **/
    var MAT_WARPSHIELD;
    /**
        Dirt
    **/
    var MAT_DIRT;
    /**
        Sand
    **/
    var MAT_SAND;
    /**
        Floor tiles
    **/
    var MAT_TILE;
    
}