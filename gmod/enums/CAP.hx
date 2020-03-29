package gmod.enums;
/**
    Enumerations used by NPC:CapabilitiesAdd, WEAPON:GetCapabilities and NPC:CapabilitiesGet. Serverside only.
**/
@:native("_G")
extern enum abstract CAP(Int) {
    /**
        Tries to shoot weapon while moving
    **/
    var CAP_MOVE_SHOOT;
    /**
        Use arms to aim gun, not just body
    **/
    var CAP_AIM_GUN;
    /**
        
    **/
    var CAP_MOVE_SWIM;
    /**
        Jump/Leap
    **/
    var CAP_MOVE_JUMP;
    /**
        Can turn head always bone controller 0
    **/
    var CAP_TURN_HEAD;
    /**
        Can fly move all around
    **/
    var CAP_MOVE_FLY;
    /**
        Don't take damage from npc's that are D_LI
    **/
    var CAP_FRIENDLY_DMG_IMMUNE;
    /**
        
    **/
    var CAP_WEAPON_RANGE_ATTACK2;
    /**
        
    **/
    var CAP_NO_HIT_SQUADMATES;
    /**
        
    **/
    var CAP_INNATE_RANGE_ATTACK1;
    /**
        climb ladders
    **/
    var CAP_MOVE_CLIMB;
    /**
        Walk/Run
    **/
    var CAP_MOVE_GROUND;
    /**
        
    **/
    var CAP_MOVE_CRAWL;
    /**
        Cover and Reload ducking
    **/
    var CAP_DUCK;
    /**
        Can open manual doors
    **/
    var CAP_OPEN_DOORS;
    /**
        Open doors/push buttons/pull levers
    **/
    var CAP_USE;
    /**
        
    **/
    var CAP_USE_SHOT_REGULATOR;
    /**
        When hit by an explosion, we'll simply block it instead of spilling it to entities behind us, the sv_robust_explosions cvar can also enable this globally when set to 0
    **/
    var CAP_SIMPLE_RADIUS_DAMAGE;
    /**
        Has animated eyes/face
    **/
    var CAP_ANIMATEDFACE;
    /**
        
    **/
    var CAP_WEAPON_RANGE_ATTACK1;
    /**
        
    **/
    var CAP_INNATE_MELEE_ATTACK1;
    /**
        Can form squads
    **/
    var CAP_SQUAD;
    /**
        
    **/
    var CAP_WEAPON_MELEE_ATTACK1;
    /**
        
    **/
    var CAP_USE_WEAPONS;
    /**
        Can trigger auto doors
    **/
    var CAP_AUTO_DOORS;
    /**
        
    **/
    var CAP_INNATE_RANGE_ATTACK2;
    /**
        
    **/
    var CAP_WEAPON_MELEE_ATTACK2;
    /**
        
    **/
    var CAP_INNATE_MELEE_ATTACK2;
    /**
        
    **/
    var CAP_SKIP_NAV_GROUND_CHECK;
    /**
        Don't hit players
    **/
    var CAP_NO_HIT_PLAYER;
    
}