package gmod.structs;
/**
    This page describes all  fields for a [playerclass](https://wiki.garrysmod.com/page/Player_Classes).
**/
typedef PLAYER = {
    /**
        How much armour we start with 
		
		Default: 0
    **/
    var ?StartArmor : Float;
    /**
        Do we drop our weapon when we die 
		
		Default: false
    **/
    var ?DropWeaponOnDie : Bool;
    /**
        How fast to go from not ducking, to ducking 
		
		Default: 0.3
    **/
    var ?DuckSpeed : Float;
    /**
        How much health we start with 
		
		Default: 100
    **/
    var ?StartHealth : Float;
    /**
        Multiply walk speed by this when crouching 
		
		Default: 0.3
    **/
    var ?CrouchedWalkSpeed : Float;
    /**
        How fast to move when running/sprinting 
		
		Default: 600
    **/
    var ?RunSpeed : Float;
    /**
        Do we collide with teammates or run straight through them 
		
		Default: true
    **/
    var ?TeammateNoCollide : Bool;
    /**
        How powerful a jump should be 
		
		Default: 200
    **/
    var ?JumpPower : Float;
    /**
        Uses viewmodel hands 
		
		Default: true
    **/
    var ?UseVMHands : Bool;
    /**
        Automatically swerves around other players 
		
		Default: true
    **/
    var ?AvoidPlayers : Bool;
    /**
        The 'nice' name of the player class for display in User Interface and such.
    **/
    var DisplayName : String;
    /**
        Max health we can have 
		
		Default: 100
    **/
    var ?MaxHealth : Float;
    /**
        How fast to go from ducking, to not ducking 
		
		Default: 0.3
    **/
    var ?UnDuckSpeed : Float;
    /**
        Can the player use the flashlight 
		
		Default: true
    **/
    var ?CanUseFlashlight : Bool;
    /**
        How fast to move when not running 
		
		Default: 400
    **/
    var ?WalkSpeed : Float;
    
}
