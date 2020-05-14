package gmod.enums;
/**
    Enumerations for NPC conditions, used by NPC:SetCondition. Serverside only.
	**Warning:** These enumerations do not exist in game, but are listed here anyway for reference
	
	**Note:** There are more conditions than listed here after COND_NO_CUSTOM_INTERRUPTS(70) but the name depends on what's returned by NPC:ConditionName
**/
@:native("_G")
extern enum abstract COND(Int) {
    /**
        
    **/
    var COND_NO_CUSTOM_INTERRUPTS;
    /**
        
    **/
    var COND_NEW_ENEMY;
    /**
        
    **/
    var COND_CAN_MELEE_ATTACK2;
    /**
        
    **/
    var COND_HEAR_PHYSICS_DANGER;
    /**
        
    **/
    var COND_WAY_CLEAR;
    /**
        
    **/
    var COND_WEAPON_PLAYER_IN_SPREAD;
    /**
        
    **/
    var COND_BEHIND_ENEMY;
    /**
        
    **/
    var COND_TOO_CLOSE_TO_ATTACK;
    /**
        
    **/
    var COND_IN_PVS;
    /**
        
    **/
    var COND_HEAVY_DAMAGE;
    /**
        
    **/
    var COND_IDLE_INTERRUPT;
    /**
        
    **/
    var COND_PLAYER_REMOVED_FROM_SQUAD;
    /**
        
    **/
    var COND_GIVE_WAY;
    /**
        
    **/
    var COND_REPEATED_DAMAGE;
    /**
        
    **/
    var COND_PROVOKED;
    /**
        
    **/
    var COND_PLAYER_PUSHING;
    /**
        
    **/
    var COND_TASK_FAILED;
    /**
        
    **/
    var COND_ENEMY_FACING_ME;
    /**
        
    **/
    var COND_LIGHT_DAMAGE;
    /**
        Freezes NPC movement
    **/
    var COND_NPC_FREEZE;
    /**
        
    **/
    var COND_TARGET_OCCLUDED;
    /**
        
    **/
    var COND_HEAR_THUMPER;
    /**
        
    **/
    var COND_WEAPON_SIGHT_OCCLUDED;
    /**
        
    **/
    var COND_HEAR_MOVE_AWAY;
    /**
        
    **/
    var COND_CAN_RANGE_ATTACK1;
    /**
        
    **/
    var COND_NO_SECONDARY_AMMO;
    /**
        
    **/
    var COND_SCHEDULE_DONE;
    /**
        
    **/
    var COND_HEAR_PLAYER;
    /**
        
    **/
    var COND_LOST_PLAYER;
    /**
        
    **/
    var COND_PLAYER_ADDED_TO_SQUAD;
    /**
        
    **/
    var COND_WEAPON_BLOCKED_BY_FRIEND;
    /**
        
    **/
    var COND_SEE_DISLIKE;
    /**
        
    **/
    var COND_SEE_PLAYER;
    /**
        Unfreezes NPC movement
    **/
    var COND_NPC_UNFREEZE;
    /**
        
    **/
    var COND_SEE_ENEMY;
    /**
        
    **/
    var COND_WEAPON_PLAYER_NEAR_TARGET;
    /**
        
    **/
    var COND_CAN_RANGE_ATTACK2;
    /**
        
    **/
    var COND_HEAR_SPOOKY;
    /**
        
    **/
    var COND_RECEIVED_ORDERS;
    /**
        
    **/
    var COND_HEAR_DANGER;
    /**
        
    **/
    var COND_MOBBED_BY_ENEMIES;
    /**
        
    **/
    var COND_HEAR_WORLD;
    /**
        
    **/
    var COND_ENEMY_DEAD;
    /**
        
    **/
    var COND_HAVE_ENEMY_LOS;
    /**
        
    **/
    var COND_HEAR_BUGBAIT;
    /**
        
    **/
    var COND_SMELL;
    /**
        
    **/
    var COND_CAN_MELEE_ATTACK1;
    /**
        
    **/
    var COND_ENEMY_OCCLUDED;
    /**
        
    **/
    var COND_TALKER_RESPOND_TO_QUESTION;
    /**
        
    **/
    var COND_SEE_HATE;
    /**
        
    **/
    var COND_NO_WEAPON;
    /**
        
    **/
    var COND_HAVE_TARGET_LOS;
    /**
        
    **/
    var COND_HEALTH_ITEM_AVAILABLE;
    /**
        
    **/
    var COND_HEAR_BULLET_IMPACT;
    /**
        
    **/
    var COND_NOT_FACING_ATTACK;
    /**
        
    **/
    var COND_HEAR_COMBAT;
    /**
        
    **/
    var COND_TOO_FAR_TO_ATTACK;
    /**
        
    **/
    var COND_WEAPON_HAS_LOS;
    /**
        
    **/
    var COND_BETTER_WEAPON_AVAILABLE;
    /**
        
    **/
    var COND_ENEMY_UNREACHABLE;
    /**
        
    **/
    var COND_LOST_ENEMY;
    /**
        
    **/
    var COND_SEE_NEMESIS;
    /**
        
    **/
    var COND_NO_PRIMARY_AMMO;
    /**
        
    **/
    var COND_PHYSICS_DAMAGE;
    /**
        
    **/
    var COND_ENEMY_WENT_NULL;
    /**
        
    **/
    var COND_SEE_FEAR;
    /**
        No additional conditions are being played
    **/
    var COND_NONE;
    /**
        
    **/
    var COND_LOW_PRIMARY_AMMO;
    /**
        
    **/
    var COND_ENEMY_TOO_FAR;
    /**
        
    **/
    var COND_FLOATING_OFF_GROUND;
    /**
        
    **/
    var COND_NO_HEAR_DANGER;
    
}