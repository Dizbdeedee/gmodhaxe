package gmod.enums;
/**
    Enumerations used by NPC:SetCurrentWeaponProficiency and NPC:GetCurrentWeaponProficiency.
**/
@:native("_G")
extern enum abstract WEAPON_PROFICIENCY(Int) {
    /**
        The NPC will rarely miss their shots.
    **/
    var WEAPON_PROFICIENCY_VERY_GOOD;
    /**
        The NPC will sometimes miss their shots.
    **/
    var WEAPON_PROFICIENCY_GOOD;
    /**
        The NPC will almost never miss their shots.
    **/
    var WEAPON_PROFICIENCY_PERFECT;
    /**
        The NPC will miss a large majority of their shots.
    **/
    var WEAPON_PROFICIENCY_POOR;
    /**
        The NPC will miss about half of their shots.
    **/
    var WEAPON_PROFICIENCY_AVERAGE;
    
}