package gmod.libs;
#if client

/**
    The killicon library is used to add to and control the icons that appear in the top right of your screen when a player is killed.
**/
@:native("_G.killicon")extern class KilliconLib {
    
    /**
        Creates new kill icon using a texture.
		
		Name | Description
		--- | ---
		`class` | Weapon or entity class
		`texture` | Path to the texture
		`color` | Color of the kill icon
		
		
		___
		### Lua Examples
		#### Example 1
		Creates default killicon.
		
		```lua 
		killicon.Add( "default", "HUD/killicons/default", Color( 255, 80, 0, 255 ) )
		```
    **/
    
    public static function Add(_class:String, texture:String, color:AnyTable):Void;
    
    
    /**
        Adds kill icon for given weapon/entity class using special font.
		
		Name | Description
		--- | ---
		`class` | Weapon or entity class
		`font` | Font to be used
		`symbol` | The symbol to be used
		`color` | Color of the killicon
		
		
		___
		### Lua Examples
		#### Example 1
		Example of using the function. Adds pistol kill icon.
		
		```lua 
		killicon.AddFont( "weapon_pistol", "HL2MPTypeDeath", "-", Color( 255, 80, 0, 255 ) )
		```
    **/
    
    public static function AddFont(_class:String, font:String, symbol:String, color:AnyTable):Void;
    
    
    /**
        Returns the size of a kill icon.
		
		Name | Description
		--- | ---
		`name` | Classname of the kill icon
		
		
		Name | Description
		--- | ---
		`a` | Width of the kill icon
		`b` | Height of the kill icon
    **/
    
    public static function GetSize(name:String):KilliconLibGetSizeReturn;
    
    
    /**
        Creates kill icon from existing one.
		
		Name | Description
		--- | ---
		`new_class` | New class of the kill icon
		`existing_class` | Already existing kill icon class
		
		
		___
		### Lua Examples
		#### Example 1
		Copies prop_physics kill icon to prop_ragdoll.
		
		```lua 
		killicon.AddAlias( "prop_ragdoll", "prop_physics" )
		```
    **/
    
    public static function AddAlias(new_class:String, existing_class:String):Void;
    
    
    /**
        Draws a kill icon.
		
		Name | Description
		--- | ---
		`x` | X coordinate of the icon
		`y` | Y coordinate of the icon
		`name` | Classname of the kill icon
		`alpha` | Alpha/transparency value ( 0 - 255 ) of the icon
    **/
    
    public static function Draw(x:Float, y:Float, name:String, alpha:Float):Void;
    
    
    /**
        Checks if kill icon exists for given class.
		
		Name | Description
		--- | ---
		`class` | The class to test
		
		
		`**Returns:** Returns true if kill icon exists
    **/
    
    public static function Exists(_class:String):Bool;
    
    

}


@:multiReturn extern class KilliconLibGetSizeReturn {
var a:Float;
var b:Float;

}

#end