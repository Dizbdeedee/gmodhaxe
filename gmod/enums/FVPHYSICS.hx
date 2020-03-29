package gmod.enums;
/**
    Enumerations used by PhysObj:AddGameFlag, PhysObj:HasGameFlag and PhysObj:ClearGameFlag.
**/
@:native("_G")
extern enum abstract FVPHYSICS(Int) {
    /**
        Will deal high physics damage even with a small mass.
    **/
    var FVPHYSICS_HEAVY_OBJECT;
    /**
        We won't collide with other [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) associated to the same entity, only used for vehicles and ragdolls held by the Super Gravity Gun.
    **/
    var FVPHYSICS_NO_SELF_COLLISIONS;
    /**
        Colliding with entities won't cause physics damage.
    **/
    var FVPHYSICS_NO_IMPACT_DMG;
    /**
        Set when the player is holding this [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) with the Gravity Gun or +use pickup.
    **/
    var FVPHYSICS_PLAYER_HELD;
    /**
        Set by the physics engine when two [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) are penetrating each other. This is only automatically updated for non-static physics objects.
    **/
    var FVPHYSICS_PENETRATING;
    /**
        Like FVPHYSICS_NO_NPC_IMPACT_DMG, but only checks for NPCs. Usually set on Combine Balls fired by Combine Soldiers.
    **/
    var FVPHYSICS_NO_NPC_IMPACT_DMG;
    /**
        This [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) is part of a ragdoll.
    **/
    var FVPHYSICS_PART_OF_RAGDOLL;
    /**
        Colliding with entities will cause 1000 damage with DMG_DISSOLVE as the damage type, but only if EFL_NO_DISSOLVE is not set.
    **/
    var FVPHYSICS_DMG_DISSOLVE;
    /**
        This object was thrown by the Gravity Gun , stuns Antlion guards, Hunters, and squashes Antlion grubs.
    **/
    var FVPHYSICS_WAS_THROWN;
    /**
        This [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) is part of an entity with multiple [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) , such as a ragdoll or a vehicle , and will be considered during collision damage events.
    **/
    var FVPHYSICS_MULTIOBJECT_ENTITY;
    /**
        Doesn't allow the player to pick this [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) with the Gravity Gun or +use pickup.
    **/
    var FVPHYSICS_NO_PLAYER_PICKUP;
    /**
        Does slice damage, not just blunt damage.
    **/
    var FVPHYSICS_DMG_SLICE;
    /**
        Won't receive physics forces from collisions and won't collide with other [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj) with the same flag set.
    **/
    var FVPHYSICS_CONSTRAINT_STATIC;
    
}