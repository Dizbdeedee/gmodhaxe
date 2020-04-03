package gmod.enums;
/**
    Enumerations used by Entity:SetMoveType and Entity:GetMoveType.
**/
@:native("_G")
extern enum abstract MOVETYPE(Int) {
    /**
        Custom movetype, can be applied to the player to prevent the default movement code from running, while still calling the related hooks
    **/
    var MOVETYPE_CUSTOM;
    /**
        For players, when moving on a ladder
    **/
    var MOVETYPE_LADDER;
    /**
        No clip to world, but pushes and crushes things
    **/
    var MOVETYPE_PUSH;
    /**
        Spectator movetype. DO  use this to make player spectate
    **/
    var MOVETYPE_OBSERVER;
    /**
        Fly, with gravity
    **/
    var MOVETYPE_FLYGRAVITY;
    /**
        Noclip
    **/
    var MOVETYPE_NOCLIP;
    /**
        Don't move
    **/
    var MOVETYPE_NONE;
    /**
        Physics movetype
    **/
    var MOVETYPE_VPHYSICS;
    /**
        Fly, no gravity
    **/
    var MOVETYPE_FLY;
    /**
        Player only, moving on the ground
    **/
    var MOVETYPE_WALK;
    /**
        For players, in TF2 commander view, etc
    **/
    var MOVETYPE_ISOMETRIC;
    /**
        Monster/NPC movement
    **/
    var MOVETYPE_STEP;
    
}