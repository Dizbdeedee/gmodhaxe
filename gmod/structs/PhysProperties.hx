package gmod.structs;
/**
    Structure used by [construct](https://wiki.garrysmod.com/page/Category:construct). [SetPhysProp](https://wiki.garrysmod.com/page/construct/SetPhysProp).
**/
typedef PhysProperties = {
    /**
        Enables or disables gravity for the entity 
		
		Default: nil
    **/
    var ?GravityToggle : Bool;
    /**
        Sets the physics material for the entity 
		
		Default: nil
    **/
    var ?Material : String;
    
}
