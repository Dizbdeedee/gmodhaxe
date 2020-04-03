package gmod.enums;
/**
    Enumerations used by Player:SetObserverMode, Player:GetObserverMode and Player:Spectate.
**/
@:native("_G")
extern enum abstract OBS_MODE(Int) {
    /**
        
    **/
    var OBS_MODE_DEATHCAM;
    /**
        First person cam
    **/
    var OBS_MODE_IN_EYE;
    /**
        Same as OBS_MODE_CHASE, but you can't rotate the view
    **/
    var OBS_MODE_FIXED;
    /**
        TF2-like freezecam
    **/
    var OBS_MODE_FREEZECAM;
    /**
        Not spectating
    **/
    var OBS_MODE_NONE;
    /**
        Free roam/noclip-alike. Does not work from [GM](https://wiki.garrysmod.com/page/Category:GM_Hooks):[PlayerDeath](https://wiki.garrysmod.com/page/GM/PlayerDeath)
    **/
    var OBS_MODE_ROAMING;
    /**
        Chase cam, 3rd person cam, free rotation around the spectated target
    **/
    var OBS_MODE_CHASE;
    
}