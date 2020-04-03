package gmod.enums;
/**
    Enumerations used by Entity:SetSolidFlags and Entity:GetSolidFlags.
**/
@:native("_G")
extern enum abstract FSOLID(Int) {
    /**
        Ignore solid type + always call into the entity for ray tests
    **/
    var FSOLID_CUSTOMRAYTEST;
    /**
        The player can't stand on this
    **/
    var FSOLID_NOT_STANDABLE;
    /**
        The object is currently not solid
    **/
    var FSOLID_NOT_SOLID;
    /**
        Contains volumetric contents (like water)
    **/
    var FSOLID_VOLUME_CONTENTS;
    /**
        Collisions are defined in root parent's local coordinate space
    **/
    var FSOLID_ROOT_PARENT_ALIGNED;
    /**
        Uses a special trigger bounds separate from the normal OBB
    **/
    var FSOLID_USE_TRIGGER_BOUNDS;
    /**
        This trigger will touch debris objects
    **/
    var FSOLID_TRIGGER_TOUCH_DEBRIS;
    /**
        Forces the collision representation to be world-aligned even if it's SOLID_BSP or SOLID_VPHYSICS
    **/
    var FSOLID_FORCE_WORLD_ALIGNED;
    /**
        This is something may be collideable but fires touch functions even when it's not collideable (when the FSOLID_NOT_SOLID flag is set)
    **/
    var FSOLID_TRIGGER;
    /**
        The amount of bits needed to store the all the flags in a variable/sent over network.
    **/
    var FSOLID_MAX_BITS;
    /**
        Ignore solid type + always call into the entity for swept box tests
    **/
    var FSOLID_CUSTOMBOXTEST;
    
}