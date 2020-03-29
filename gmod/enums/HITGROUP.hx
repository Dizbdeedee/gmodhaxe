package gmod.enums;
/**
    Enumerations used by GM:ScalePlayerDamage and GM:ScaleNPCDamage and returned by Player:LastHitGroup.
**/
@:native("_G")
extern enum abstract HITGROUP(Int) {
    /**
        Right arm
    **/
    var HITGROUP_RIGHTARM;
    /**
        Gear. Supposed to be belt area.This hitgroup is not present on default player models.
    **/
    var HITGROUP_GEAR;
    /**
        1:1 damage. Melee weapons typically hit this hitgroup. This hitgroup is not present on default player models. It is unknown how this is generated in GM:ScalePlayerDamage, but it occurs when shot by NPCs ( npc_combine_s ) for example.
    **/
    var HITGROUP_GENERIC;
    /**
        Left leg
    **/
    var HITGROUP_LEFTLEG;
    /**
        Head
    **/
    var HITGROUP_HEAD;
    /**
        Right leg
    **/
    var HITGROUP_RIGHTLEG;
    /**
        Left arm
    **/
    var HITGROUP_LEFTARM;
    /**
        Chest
    **/
    var HITGROUP_CHEST;
    /**
        Stomach
    **/
    var HITGROUP_STOMACH;
    
}