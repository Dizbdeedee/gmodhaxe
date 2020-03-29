package gmod.enums;
/**
    Enumerations describing certain spawnflags. Everything except for SF_PHYS* is serverside only. 
	
	Spawnflags are set using Entity:SetKeyValue with "spawnflags" as the key.
	**Note:** This is not a full list of available spawnflags, there are a lot more, each unique to each entity, you can find out more on the Valve Developer Community website for the entities in question.
**/
@:native("_G")
extern enum abstract SF(Int) {
    /**
        If set, calls [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj):[EnableMotion](https://wiki.garrysmod.com/page/PhysObj/EnableMotion)( false ) on the func_physbox when the physics are created
    **/
    var SF_PHYSBOX_MOTIONDISABLED;
    /**
        No IDLE sounds until angry
    **/
    var SF_NPC_GAG;
    /**
        Citizen cannot join players squad, and will not able to be commanded by the Half-Life 2 command system for Citizens
    **/
    var SF_CITIZEN_NOT_COMMANDABLE;
    /**
        NPC Drops health kit when it dies
    **/
    var SF_NPC_DROP_HEALTHKIT;
    /**
        If set, calls [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj):[EnableMotion](https://wiki.garrysmod.com/page/PhysObj/EnableMotion)( false ) on the func_physbox when the physics are created. See [Physicsoptimization](https://wiki.garrysmod.comhttps://developer.valvesoftware.com/wiki/Physics_optimization)
    **/
    var SF_PHYSPROP_MOTIONDISABLED;
    /**
        Makes the rollermine friendly
    **/
    var SF_ROLLERMINE_FRIENDLY;
    /**
        Gives the citizen a random female head
    **/
    var SF_CITIZEN_RANDOM_HEAD_FEMALE;
    /**
        "Follow the player as soon as I spawn"
    **/
    var SF_CITIZEN_FOLLOW;
    /**
        Citizen that resupplies ammo
    **/
    var SF_CITIZEN_AMMORESUPPLIER;
    /**
        "Work outside the speech semaphore system"
    **/
    var SF_CITIZEN_IGNORE_SEMAPHORE;
    /**
        Prevent that physbox from being picked up
    **/
    var SF_PHYSPROP_PREVENT_PICKUP;
    /**
        "Use render bounds instead of human hull for guys sitting in chairs, etc". Must be set before Spawn() is called to take effect
    **/
    var SF_CITIZEN_USE_RENDER_BOUNDS;
    /**
        Ignore player push - Don't give way to player
    **/
    var SF_NPC_NO_PLAYER_PUSHAWAY;
    /**
        Do Alternate collision for this NPC (player avoidance)
    **/
    var SF_NPC_ALTCOLLISION;
    /**
        Gives the citizen a random male head
    **/
    var SF_CITIZEN_RANDOM_HEAD_MALE;
    /**
        Fade Corpse
    **/
    var SF_NPC_FADE_CORPSE;
    /**
        [ThinkoutsidePVS](https://wiki.garrysmod.comhttps://developer.valvesoftware.com/wiki/NPC_Sensing)
    **/
    var SF_NPC_ALWAYSTHINK;
    /**
        Long Visibility/Shoot
    **/
    var SF_NPC_LONG_RANGE;
    /**
        Wait for script
    **/
    var SF_NPC_WAIT_FOR_SCRIPT;
    /**
        Makes the citizen a medic
    **/
    var SF_CITIZEN_MEDIC;
    /**
        Gives the citizen a random head
    **/
    var SF_CITIZEN_RANDOM_HEAD;
    /**
        Gravity gun is NOT allowed to pick this up.
    **/
    var SF_PHYSBOX_NEVER_PICK_UP;
    /**
        Makes the floor turret friendly
    **/
    var SF_FLOOR_TURRET_CITIZEN;
    /**
        If not set, means *teleport* to ground
    **/
    var SF_NPC_FALL_TO_GROUND;
    /**
        This entity is a template for the [npc_template_maker](https://wiki.garrysmod.comhttps://developer.valvesoftware.com/wiki/Npc_template_maker). It will not spawn automatically and cannot be used with [point_template](https://wiki.garrysmod.comhttps://developer.valvesoftware.com/wiki/Point_template).
    **/
    var SF_NPC_TEMPLATE;
    /**
        Don't acquire enemies or avoid obstacles
    **/
    var SF_NPC_START_EFFICIENT;
    /**
        Wait till seen
    **/
    var SF_NPC_WAIT_TILL_SEEN;
    /**
        NPC Doesn't drop weapon on death
    **/
    var SF_NPC_NO_WEAPON_DROP;
    
}