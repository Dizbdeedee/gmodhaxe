package gmod.enums;
/**
    Enumerations used as trace masks in Trace structure and HullTrace structure. These enumerations are simply combinations of CONTENTS_ Enums.
**/
@:native("_G")
extern enum abstract MASK(Int) {
    /**
        Anything that is not empty space
    **/
    var MASK_ALL;
    /**
        Anything that stops a bullet (excluding hitboxes)
    **/
    var MASK_SHOT_HULL;
    /**
        The world entity
    **/
    var MASK_NPCWORLDSTATIC;
    /**
        Solids except for grates
    **/
    var MASK_SHOT_PORTAL;
    /**
        World + Brushes
    **/
    var MASK_SOLID_BRUSHONLY;
    /**
        Anything that blocks line of sight for players, including NPCs
    **/
    var MASK_VISIBLE_AND_NPCS;
    /**
        Anything that blocks corpse movement
    **/
    var MASK_DEADSOLID;
    /**
        Anything that blocks NPC movement
    **/
    var MASK_NPCSOLID;
    /**
        Water that is moving (may not work)
    **/
    var MASK_CURRENT;
    /**
        Anything that blocks lighting
    **/
    var MASK_OPAQUE;
    /**
        Things that split area portals
    **/
    var MASK_SPLITAREAPORTAL;
    /**
        Anything that blocks line of sight for AI or NPCs
    **/
    var MASK_BLOCKLOS_AND_NPCS;
    /**
        Anything that blocks line of sight for AI
    **/
    var MASK_BLOCKLOS;
    /**
        Anything that has water-like physics
    **/
    var MASK_WATER;
    /**
        Anything that blocks player movement
    **/
    var MASK_PLAYERSOLID;
    /**
        Anything that stops a bullet (including hitboxes)
    **/
    var MASK_SHOT;
    /**
        Anything that blocks lighting, including NPCs
    **/
    var MASK_OPAQUE_AND_NPCS;
    /**
        Anything that blocks NPC movement, except other NPCs
    **/
    var MASK_NPCSOLID_BRUSHONLY;
    /**
        Anything that is (normally) solid
    **/
    var MASK_SOLID;
    /**
        World + Brushes + Player Clips
    **/
    var MASK_PLAYERSOLID_BRUSHONLY;
    /**
        Anything that blocks line of sight for players
    **/
    var MASK_VISIBLE;
    
}