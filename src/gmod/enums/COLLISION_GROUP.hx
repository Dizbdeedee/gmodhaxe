package gmod.enums;
/**
    Enumerations used by Entity:SetCollisionGroup and Entity:GetCollisionGroup.
**/
@:native("_G")
extern enum abstract COLLISION_GROUP(Int) {
    /**
        For HL2, same as Collision_Group_Player, for TF2, this filters out other players and CBaseObjects
    **/
    var COLLISION_GROUP_PLAYER_MOVEMENT;
    /**
        Let's the Player through, nothing else.
    **/
    var COLLISION_GROUP_PASSABLE_DOOR;
    /**
        Only collides with vehicles
    **/
    var COLLISION_GROUP_VEHICLE_CLIP;
    /**
        
    **/
    var COLLISION_GROUP_VEHICLE;
    /**
        Nonsolid on client and server, pushaway in player code
    **/
    var COLLISION_GROUP_PUSHAWAY;
    /**
        Doesn't collide with players and vehicles
    **/
    var COLLISION_GROUP_WEAPON;
    /**
        Normal
    **/
    var COLLISION_GROUP_NONE;
    /**
        Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
    **/
    var COLLISION_GROUP_DEBRIS_TRIGGER;
    /**
        NPCs can see straight through an Entity with this applied.
    **/
    var COLLISION_GROUP_BREAKABLE_GLASS;
    /**
        
    **/
    var COLLISION_GROUP_NPC_ACTOR;
    /**
        Amount of COLLISION_GROUP_ enumerations
    **/
    var LAST_SHARED_COLLISION_GROUP;
    /**
        Things that are dissolving are in this group
    **/
    var COLLISION_GROUP_DISSOLVING;
    /**
        Collides with nothing but world and static stuff
    **/
    var COLLISION_GROUP_DEBRIS;
    /**
        Doesn't collide with players/props
    **/
    var COLLISION_GROUP_WORLD;
    /**
        
    **/
    var COLLISION_GROUP_PROJECTILE;
    /**
        
    **/
    var COLLISION_GROUP_PLAYER;
    /**
        Collides with everything except interactive debris or debris
    **/
    var COLLISION_GROUP_INTERACTIVE;
    /**
        
    **/
    var COLLISION_GROUP_NPC;
    /**
        Doesn't collide with anything, no traces
    **/
    var COLLISION_GROUP_IN_VEHICLE;
    /**
        Collides with everything except other interactive debris or debris
    **/
    var COLLISION_GROUP_INTERACTIVE_DEBRIS;
    /**
        Blocks entities not permitted to get near moving doors
    **/
    var COLLISION_GROUP_DOOR_BLOCKER;
    /**
        
    **/
    var COLLISION_GROUP_NPC_SCRIPTED;
    
}