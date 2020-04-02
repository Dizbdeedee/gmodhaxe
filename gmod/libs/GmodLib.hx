package gmod.libs;


/**
    Similar purpose to the game library and engine library, allows access to various features of the game's engine.
**/
@:native("_G.gmod")extern class GmodLib {
    
    /**
        Returns GAMEMODE.
		
		`**Returns:** GAMEMODE
    **/
    
    static function GetGamemode():AnyTable;
    
    

}



