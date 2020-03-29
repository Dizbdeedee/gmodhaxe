package gmod.libs;
#if client

/**
    The effects library allows you to manually add scripted effects.
**/
@:native("_G.effects")extern class EffectsLib {
    
    /**
        ***INTERNAL** You are looking for util. Effect.
		
		Returns the table of the effect specified.
		
		Name | Description
		--- | ---
		`name` | Effect name.
		
		
		`**Returns:** Effect table.
    **/
    @:deprecated("INTERNAL: You are looking for util. Effect.")
    public static function Create(name:String):AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		Registers a new effect.
		
		Name | Description
		--- | ---
		`effect_table` | Effect table.
		`name` | Effect name.
    **/
    @:deprecated("INTERNAL")
    public static function Register(effect_table:AnyTable, name:String):Void;
    
    

}



#end