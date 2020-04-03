package gmod.structs;
/**
    Table structure that describes a Source Engine ammo type. See game.AddAmmoType and game.GetAmmoData.
**/
typedef AmmoData = {
    /**
        Name of the ammo. 
		
		Related functions are game.GetAmmoName and game.GetAmmoID.
    **/
    var name : String;
    /**
        The damage dealt to players. 
		
		Related function is game.GetAmmoPlayerDamage. 
		
		Default: 10
		
		**Note:** Can also be a string pointing to a convar. The value will automatically update with the convar's.
    **/
    var ?plydmg : Float;
    /**
        Damage type using DMG_ Enums. 
		
		Related function is game.GetAmmoDamageType. 
		
		Default: DMG_BULLET
    **/
    var ?dmgtype : DMG;
    /**
        Maximum amount of ammo of this type the player should be able to carry in reserve. 
		
		Related function is game.GetAmmoMax.
		
		**Note:** Can also be a string pointing to a convar. The value will automatically update with the convar's.
		
		**Note:** gmod_maxammo will override this value if set to above 0.
    **/
    var ?maxcarry : Float;
    /**
        Flags for the ammo type using AMMO_ Enums. 
		
		Default: 0
    **/
    var ?flags : AMMO;
    /**
        Tracer type using TRACER_ Enums. 
		
		Default: TRACER_NONE
    **/
    var ?tracer : TRACER;
    /**
        The force of the ammo. 
		
		Related function is game.GetAmmoForce. 
		
		Default: 1000
    **/
    var ?force : Float;
    /**
        The maximum water splash size. 
		
		Default: 0
    **/
    var ?maxsplash : Float;
    /**
        The damage dealt to NPCs. 
		
		Related function is game.GetAmmoNPCDamage. 
		
		Default: 10
		
		**Note:** Can also be a string pointing to a convar. The value will automatically update with the convar's.
    **/
    var ?npcdmg : Float;
    /**
        The minimum water splash size. 
		
		Default: 0
    **/
    var ?minsplash : Float;
    
}
