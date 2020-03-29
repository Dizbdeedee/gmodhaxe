package gmod.enums;
/**
    Enumerations used by CTakeDamageInfo:GetDamageType, CTakeDamageInfo:SetDamageType and CTakeDamageInfo:IsDamageType
**/
@:native("_G")
extern enum abstract DMG(Int) {
    /**
        Laser
    **/
    var DMG_ENERGYBEAM;
    /**
        Bullet damage
    **/
    var DMG_BULLET;
    /**
        Explosion damage. Will be ignored by most vehicle passengers.
    **/
    var DMG_BLAST;
    /**
        Damage applied to the player to restore health after drowning
    **/
    var DMG_DROWNRECOVER;
    /**
        Same as DMG_POISON
    **/
    var DMG_PARALYZE;
    /**
        Never creates gibs. (Used by the crossbow)
    **/
    var DMG_NEVERGIB;
    /**
        Sharp objects, such as Manhacks or other NPCs attacks
    **/
    var DMG_SLASH;
    /**
        Generic damage
    **/
    var DMG_GENERIC;
    /**
        Caused by physics interaction. Ignored by airboat drivers. Used by the Crowbar
    **/
    var DMG_CRUSH;
    /**
        Crowbar damage
    **/
    var DMG_CLUB;
    /**
        Prevent a physics force
    **/
    var DMG_PREVENT_PHYSICS_FORCE;
    /**
        Damage from npc_missiledefense, npc_combinegunship, or monster_mortar
    **/
    var DMG_MISSILEDEFENSE;
    /**
        Sonic damage,used by the Gargantua and Houndeye NPCs
    **/
    var DMG_SONIC;
    /**
        Hit by a vehicle. This will need to be set for passengers of some vehicle to receive damage.
    **/
    var DMG_VEHICLE;
    /**
        Forces the entity to dissolve on death. This is what the combine ball uses when it hits a target
    **/
    var DMG_DISSOLVE;
    /**
        Airboat gun damage
    **/
    var DMG_AIRBOAT;
    /**
        The pellets fired from a shotgun
    **/
    var DMG_BUCKSHOT;
    /**
        Drown damage
    **/
    var DMG_DROWN;
    /**
        Plasma
    **/
    var DMG_PLASMA;
    /**
        In an oven
    **/
    var DMG_SLOWBURN;
    /**
        Don't create a ragdoll on death
    **/
    var DMG_REMOVENORAGDOLL;
    /**
        Radiation. Will be ignored by most vehicle passengers.
    **/
    var DMG_RADIATION;
    /**
        Direct damage to the entity that does not go through any damage value modifications
    **/
    var DMG_DIRECT;
    /**
        Damage from SniperRound/SniperPenetratedRound ammo types
    **/
    var DMG_SNIPER;
    /**
        Damage done by the gravity gun
    **/
    var DMG_PHYSGUN;
    /**
        Electrical damage, shows smoke at the damage position
    **/
    var DMG_SHOCK;
    /**
        Damage from fire
    **/
    var DMG_BURN;
    /**
        Poison damage
    **/
    var DMG_POISON;
    /**
        Toxic chemicals or acid burns
    **/
    var DMG_ACID;
    /**
        Neurotoxin damage
    **/
    var DMG_NERVEGAS;
    /**
        Always create gibs
    **/
    var DMG_ALWAYSGIB;
    /**
        This won't hurt the player underwater
    **/
    var DMG_BLAST_SURFACE;
    /**
        Fall damage
    **/
    var DMG_FALL;
    
}