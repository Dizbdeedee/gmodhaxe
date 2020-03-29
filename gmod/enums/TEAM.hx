package gmod.enums;
/**
    Default defined teams in Garry's Mod. This does not include any custom teams created in custom gamemodes. Enumerations to use with Player:Team
**/
@:native("_G")
extern enum abstract TEAM(Int) {
    /**
        Unassigned team ID, set right after player connected
    **/
    var TEAM_UNASSIGNED;
    /**
        Connecting team ID, set when player connects to the server
    **/
    var TEAM_CONNECTING;
    /**
        Spectator team ID
    **/
    var TEAM_SPECTATOR;
    
}