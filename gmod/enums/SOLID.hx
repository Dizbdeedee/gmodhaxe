package gmod.enums;
/**
    For use with Entity:PhysicsInit, Entity:SetSolid and Entity:GetSolid.
**/
@:native("_G")
extern enum abstract SOLID(Int) {
    /**
        Uses the entity's object-aligned bounding box for collisions
    **/
    var SOLID_OBB;
    /**
        Same as SOLID_OBB but restricts orientation to the Z-axis
		
		**Note:** Seems to be broken.
    **/
    var SOLID_OBB_YAW;
    /**
        Does not collide with anything
		
		**Note:** No Physics Object will be created when using this.
    **/
    var SOLID_NONE;
    /**
        Uses the entity's axis-aligned bounding box for collisions
    **/
    var SOLID_BBOX;
    /**
        The entity has a brush model defined by the map. Does not collide with other SOLID_BSP entities.
    **/
    var SOLID_BSP;
    /**
        Uses the [PhysObjects](https://wiki.garrysmod.com/page/Category:PhysObj) of the entity
    **/
    var SOLID_VPHYSICS;
    /**
        Always call into the entity for tests
    **/
    var SOLID_CUSTOM;
    
}