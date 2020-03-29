package gmod.enums;
/**
    Enumerations for NPC schedules, used by ENTITY:StartEngineSchedule and NPC:SetSchedule. Serverside only.
**/
@:native("_G")
extern enum abstract SCHED(Int) {
    /**
        Walk to random position and stop if enemy is heard or found.
    **/
    var SCHED_PATROL_WALK;
    /**
        Move to the range the weapon is preferably used at.
    **/
    var SCHED_MOVE_TO_WEAPON_RANGE;
    /**
        Idle stance
    **/
    var SCHED_IDLE_STAND;
    /**
        The schedule enum limit
    **/
    var LAST_SHARED_SCHEDULE;
    /**
        
    **/
    var SCHED_SCENE_GENERIC;
    /**
        Walk to position.
    **/
    var SCHED_IDLE_WALK;
    /**
        
    **/
    var SCHED_RUN_FROM_ENEMY_FALLBACK;
    /**
        
    **/
    var SCHED_PRE_FAIL_ESTABLISH_LINE_OF_FIRE;
    /**
        Move away from enemy while facing it and checking for new enemies.
    **/
    var SCHED_MOVE_AWAY_FROM_ENEMY;
    /**
        
    **/
    var SCHED_SCRIPTED_CUSTOM_MOVE;
    /**
        Heavy damage was taken for the first time in a while.
    **/
    var SCHED_BIG_FLINCH;
    /**
        Remain idle until provoked or an enemy is found.
    **/
    var SCHED_AMBUSH;
    /**
        Failed to move away; stop moving.
    **/
    var SCHED_MOVE_AWAY_FAIL;
    /**
        Run to random position and stop if enemy is heard or found.
    **/
    var SCHED_PATROL_RUN;
    /**
        
    **/
    var SCHED_RANGE_ATTACK2;
    /**
        Rotate 180 degrees and back to check for enemies.
    **/
    var SCHED_ALERT_SCAN;
    /**
        
    **/
    var SCHED_SPECIAL_ATTACK2;
    /**
        Pick up a new weapon if within a radius of 5 units.
    **/
    var SCHED_NEW_WEAPON;
    /**
        Walk to random position within a radius of 200 units.
    **/
    var SCHED_IDLE_WANDER;
    /**
        
    **/
    var SCHED_INTERACTION_MOVE_TO_PARTNER;
    /**
        Performs ACT_ARM.
    **/
    var SCHED_ARM_WEAPON;
    /**
        Stop moving and reload until danger is heard.
    **/
    var SCHED_RELOAD;
    /**
        
    **/
    var SCHED_SWITCH_TO_PENDING_WEAPON;
    /**
        
    **/
    var SCHED_STANDOFF;
    /**
        Pick up item if within a radius of 5 units.
    **/
    var SCHED_GET_HEALTHKIT;
    /**
        
    **/
    var SCHED_MELEE_ATTACK1;
    /**
        Human victory dance.
    **/
    var SCHED_VICTORY_DANCE;
    /**
        Shoot cover that the enemy is behind.
    **/
    var SCHED_SHOOT_ENEMY_COVER;
    /**
        Failed to take cover.
    **/
    var SCHED_FAIL_TAKE_COVER;
    /**
        Will walk around patrolling an area until an enemy is found.
    **/
    var SCHED_COMBAT_PATROL;
    /**
        Fall to ground when in the air.
    **/
    var SCHED_FALL_TO_GROUND;
    /**
        Force run to position (debug).
    **/
    var SCHED_FORCED_GO_RUN;
    /**
        Failed doing current schedule.
    **/
    var SCHED_FAIL;
    /**
        
    **/
    var SCHED_BACK_AWAY_FROM_SAVE_POSITION;
    /**
        Face current enemy.
    **/
    var SCHED_COMBAT_FACE;
    /**
        Take cover from current enemy.
    **/
    var SCHED_TAKE_COVER_FROM_ENEMY;
    /**
        Begins AI script based on NPC's  save value.
    **/
    var SCHED_AISCRIPT;
    /**
        Back away from enemy. If not possible to back away then go behind enemy.
    **/
    var SCHED_BACK_AWAY_FROM_ENEMY;
    /**
        Spot an enemy and go from an idle state to combat state.
    **/
    var SCHED_WAKE_ANGRY;
    /**
        
    **/
    var SCHED_SCRIPTED_WAIT;
    /**
        Plays NPC death sound (doesn't kill NPC).
    **/
    var SCHED_DIE_RAGDOLL;
    /**
        
    **/
    var SCHED_SCRIPTED_WALK;
    /**
        Remain idle until an enemy is heard or found.
    **/
    var SCHED_ALERT_STAND;
    /**
        Face NPC target.
    **/
    var SCHED_TARGET_FACE;
    /**
        Chase set NPC target.
    **/
    var SCHED_TARGET_CHASE;
    /**
        Begin chasing an enemy.
    **/
    var SCHED_CHASE_ENEMY;
    /**
        Sets the NPC to a sleep-like state.
    **/
    var SCHED_SLEEP;
    /**
        Fail safe: Create the weapon that the NPC went to pick up if it was removed during pick up schedule.
    **/
    var SCHED_NEW_WEAPON_CHEAT;
    /**
        Preform Ducking animation. (Only works with npc_alyx)
    **/
    var SCHED_DUCK_DODGE;
    /**
        
    **/
    var SCHED_WAIT_FOR_SPEAK_FINISH;
    /**
        When not moving, will perform ACT_COWER.
    **/
    var SCHED_COWER;
    /**
        
    **/
    var SCHED_INTERACTION_WAIT_FOR_PARTNER;
    /**
        
    **/
    var SCHED_COMBAT_WALK;
    /**
        
    **/
    var SCHED_COMBAT_STAND;
    /**
        Idle stance and face ideal yaw angles.
    **/
    var SCHED_ALERT_FACE;
    /**
        Prevents movement until COND_NPC_UNFREEZE(68) is set.
    **/
    var SCHED_NPC_FREEZE;
    /**
        Stop moving and continue enemy scan.
    **/
    var SCHED_MOVE_AWAY_END;
    /**
        
    **/
    var SCHED_FAIL_NOSTOP;
    /**
        Run to random position within a radius of 500 units.
    **/
    var SCHED_RUN_RANDOM;
    /**
        Will express fear face. (Only works on NPCs with expressions)
    **/
    var SCHED_FEAR_FACE;
    /**
        
    **/
    var SCHED_COMBAT_SWEEP;
    /**
        Failed to chase enemy.
    **/
    var SCHED_CHASE_ENEMY_FAILED;
    /**
        No schedule is being performed.
    **/
    var SCHED_NONE;
    /**
        
    **/
    var SCHED_TAKE_COVER_FROM_BEST_SOUND;
    /**
        Take cover and reload weapon.
    **/
    var SCHED_HIDE_AND_RELOAD;
    /**
        
    **/
    var SCHED_ALERT_FACE_BESTSOUND;
    /**
        
    **/
    var SCHED_RANGE_ATTACK1;
    /**
        
    **/
    var SCHED_WAIT_FOR_SCRIPT;
    /**
        Failed to establish a line of fire.
    **/
    var SCHED_FAIL_ESTABLISH_LINE_OF_FIRE;
    /**
        
    **/
    var SCHED_TAKE_COVER_FROM_ORIGIN;
    /**
        
    **/
    var SCHED_SPECIAL_ATTACK1;
    /**
        
    **/
    var SCHED_ALERT_REACT_TO_COMBAT_SOUND;
    /**
        Regular NPC death.
    **/
    var SCHED_DIE;
    /**
        Holsters active weapon. (Only works with NPC's that can holster weapons)
    **/
    var SCHED_DISARM_WEAPON;
    /**
        Walk until an enemy is heard or found.
    **/
    var SCHED_ALERT_WALK;
    /**
        
    **/
    var SCHED_RUN_FROM_ENEMY_MOB;
    /**
        
    **/
    var SCHED_SCRIPTED_RUN;
    /**
        
    **/
    var SCHED_FLEE_FROM_BEST_SOUND;
    /**
        Retreat from the established enemy.
    **/
    var SCHED_RUN_FROM_ENEMY;
    /**
        Force walk to position (debug).
    **/
    var SCHED_FORCED_GO;
    /**
        Fallback from an established line of fire.
    **/
    var SCHED_ESTABLISH_LINE_OF_FIRE_FALLBACK;
    /**
        Plays ACT_FLINCH_PHYSICS.
    **/
    var SCHED_FLINCH_PHYSICS;
    /**
        
    **/
    var SCHED_SCRIPTED_FACE;
    /**
        Search for a place to shoot current enemy.
    **/
    var SCHED_ESTABLISH_LINE_OF_FIRE;
    /**
        
    **/
    var SCHED_DROPSHIP_DUSTOFF;
    /**
        
    **/
    var SCHED_SMALL_FLINCH;
    /**
        
    **/
    var SCHED_MELEE_ATTACK2;
    /**
        
    **/
    var SCHED_INVESTIGATE_SOUND;
    /**
        Move away from player.
    **/
    var SCHED_MOVE_AWAY;
    
}