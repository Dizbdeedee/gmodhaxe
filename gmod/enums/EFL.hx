package gmod.enums;
/**
    Enumerations used by Entity:AddEFlags, Entity:RemoveEFlags and Entity:IsEFlagSet.
**/
@:native("_G")
extern enum abstract EFL(Int) {
    /**
        This is a special entity that should not be deleted when we restart entities only
    **/
    var EFL_KEEP_ON_RECREATE_ENTITIES;
    /**
        
    **/
    var EFL_DIRTY_SURROUNDING_COLLISION_BOUNDS;
    /**
        
    **/
    var EFL_DIRTY_ABSVELOCITY;
    /**
        Used to determine if an entity is floating
    **/
    var EFL_TOUCHING_FLUID;
    /**
        Entities with this flag set show up in the partition even when not solid
    **/
    var EFL_USE_PARTITION_WHEN_NOT_SOLID;
    /**
        Doesn't accept forces from physics damage
    **/
    var EFL_NO_DAMAGE_FORCES;
    /**
        Lets us know when the noclip command is active
    **/
    var EFL_NOCLIP_ACTIVE;
    /**
        
    **/
    var EFL_DIRTY_ABSTRANSFORM;
    /**
        (Client only) need shadow manager to update the shadow
    **/
    var EFL_DIRTY_SHADOWUPDATE;
    /**
        
    **/
    var EFL_NO_GAME_PHYSICS_SIMULATION;
    /**
        NPCs should not walk on this entity
    **/
    var EFL_DONTWALKON;
    /**
        
    **/
    var EFL_CHECK_UNTOUCH;
    /**
        Another entity is watching events on this entity (used by teleport)
    **/
    var EFL_NOTIFY;
    /**
        This is set on bots that are frozen
    **/
    var EFL_BOT_FROZEN;
    /**
        This is set if the entity detects that it's in the skybox. This forces it to pass the "in PVS" for transmission
    **/
    var EFL_IN_SKYBOX;
    /**
        Non-networked entity
    **/
    var EFL_SERVER_ONLY;
    /**
        Avoid executing the entity's Think
    **/
    var EFL_NO_THINK_FUNCTION;
    /**
        Don't attach the edict
    **/
    var EFL_NO_AUTO_EDICT_ATTACH;
    /**
        
    **/
    var EFL_NO_ROTORWASH_PUSH;
    /**
        
    **/
    var EFL_DIRTY_SPATIAL_PARTITION;
    /**
        Physcannon can't pick these up or punt them
    **/
    var EFL_NO_PHYSCANNON_INTERACTION;
    /**
        Set while a model is setting up its bones
    **/
    var EFL_SETTING_UP_BONES;
    /**
        Some dirty bits with respect to abs computations
    **/
    var EFL_DIRTY_ABSANGVELOCITY;
    /**
        Entitiy shouldn't dissolve
    **/
    var EFL_NO_DISSOLVE;
    /**
        One of the child entities is a player
    **/
    var EFL_HAS_PLAYER_CHILD;
    /**
        Entity is dormant, no updates to client
    **/
    var EFL_DORMANT;
    /**
        Mega physcannon can't ragdoll these guys
    **/
    var EFL_NO_MEGAPHYSCANNON_RAGDOLL;
    /**
        This entity is marked for death -- This allows the game to actually delete ents at a safe time.
		
		**Warning:** You should never set this flag manually.
    **/
    var EFL_KILLME;
    /**
        Don't adjust this entity's velocity when transitioning into water
    **/
    var EFL_NO_WATER_VELOCITY_CHANGE;
    /**
        
    **/
    var EFL_IS_BEING_LIFTED_BY_BARNACLE;
    /**
        Entity shouldn't block NPC line-of-sight
    **/
    var EFL_DONTBLOCKLOS;
    /**
        The default behavior in ShouldTransmit is to not send an entity if it doesn't have a model. Certain entities want to be sent anyway because all the drawing logic is in the client DLL. They can set this flag and the engine will transmit them even if they don't have model
    **/
    var EFL_FORCE_CHECK_TRANSMIT;
    
}