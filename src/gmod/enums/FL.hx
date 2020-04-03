package gmod.enums;
/**
    Enumerations used by Entity:AddFlags, Entity:RemoveFlags and Entity:IsFlagSet.
**/
@:native("_G")
extern enum abstract FL(Int) {
    /**
        Makes the entity invisible to AI
    **/
    var FL_NOTARGET;
    /**
        Is the player in the process of ducking or standing up
    **/
    var FL_ANIMDUCKING;
    /**
        Indicates the entity is standing in rain
    **/
    var FL_INRAIN;
    /**
        NPCs have this flag (NPC: Ignore player push)
    **/
    var FL_NPC;
    /**
        This player is controlling a func_train
    **/
    var FL_ONTRAIN;
    /**
        Completely freezes the player
    **/
    var FL_FROZEN;
    /**
        This entity can be seen by NPCs
    **/
    var FL_OBJECT;
    /**
        This player is controlling something UI related in the world, this prevents his movement, but doesn't freeze mouse movement, jumping, etc.
    **/
    var FL_ATCONTROLS;
    /**
        This entity is on fire
    **/
    var FL_ONFIRE;
    /**
        It's a static prop
    **/
    var FL_STATICPROP;
    /**
        This entity is about to become a ragdoll
    **/
    var FL_TRANSRAGDOLL;
    /**
        Is player ducking or not
    **/
    var FL_DUCKING;
    /**
        This entity can swim
    **/
    var FL_SWIM;
    /**
        worldgraph has this ent listed as something that blocks a connection
    **/
    var FL_GRAPHED;
    /**
        This entity can be aimed at
    **/
    var FL_AIMTARGET;
    /**
        Is the entity on ground or not
    **/
    var FL_ONGROUND;
    /**
        The player is jumping out of water
    **/
    var FL_WATERJUMP;
    /**
        Not all corners are valid
    **/
    var FL_PARTIALGROUND;
    /**
        This entity is about to get removed
    **/
    var FL_KILLME;
    /**
        Changes the SV_Movestep() behavior to not do any processing
    **/
    var FL_STEPMOVEMENT;
    /**
        Is the player in water or not
    **/
    var FL_INWATER;
    /**
        This entity is a func_conveyor
    **/
    var FL_CONVEYOR;
    /**
        This entity is a grenade, unused
    **/
    var FL_GRENADE;
    /**
        Bots have this flag
    **/
    var FL_FAKECLIENT;
    /**
        Is this entity a player or not
    **/
    var FL_CLIENT;
    /**
        The entity is currently dissolving
    **/
    var FL_DISSOLVING;
    /**
        This entity is a brush and part of the world
    **/
    var FL_WORLDBRUSH;
    /**
        Whether the player has god mode enabled
    **/
    var FL_GODMODE;
    /**
        This moving door can't be blocked by the player
    **/
    var FL_UNBLOCKABLE_BY_PLAYER;
    /**
        This entity can fly
    **/
    var FL_FLY;
    /**
        Doesn't generate touch functions, calls [ENTITY](https://wiki.garrysmod.com/page/Category:ENTITY_Hooks):[EndTouch](https://wiki.garrysmod.com/page/ENTITY/EndTouch) when this flag gets set during a touch callback
    **/
    var FL_DONTTOUCH;
    /**
        Base velocity has been applied this frame (used to convert base velocity into momentum)
    **/
    var FL_BASEVELOCITY;
    
}