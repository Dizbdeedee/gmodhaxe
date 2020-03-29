package gmod.enums;
/**
    Enumerations used by NPC:SetNPCState. Serverside only.
**/
@:native("_G")
extern enum abstract NPC_STATE(Int) {
    /**
        Invalid state
    **/
    var NPC_STATE_INVALID;
    /**
        NPC is in combat
    **/
    var NPC_STATE_COMBAT;
    /**
        NPC default state
    **/
    var NPC_STATE_NONE;
    /**
        NPC is idle
    **/
    var NPC_STATE_IDLE;
    /**
        NPC is prone to death
    **/
    var NPC_STATE_PRONE;
    /**
        NPC is executing scripted sequence
    **/
    var NPC_STATE_SCRIPT;
    /**
        NPC is dead
    **/
    var NPC_STATE_DEAD;
    /**
        NPC is alert and searching for enemies
    **/
    var NPC_STATE_ALERT;
    /**
        NPC is playing dead (used for expressions)
    **/
    var NPC_STATE_PLAYDEAD;
    
}