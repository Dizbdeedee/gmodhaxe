package gmod.libs;


/**
    The physenv library allows you to control the physics environment created by the engine, and lets you modify constants such as gravity and maximum velocity.
**/
@:native("_G.physenv")extern class PhysenvLib {
    
    /**
        Adds surface properties to the game's physics environment.
		
		**Bug:** BUG The game has a limit of 128 surface properties - this includes properties loaded automatically from surfaceproperties.txt. Due to this, there's only a small amount of open slots that can be registered with GMod's provided surfaceproperties.txt. Issue Tracker: #2604
		
		Name | Description
		--- | ---
		`properties` | The properties to add. Each one should include "base" or the game will crash due to some values being missing.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the "" surface property from TF2.
		
		```lua 
		physenv.AddSurfaceData([["scout_baseball"
		{
		    "base"        "rubber"
		
		    "bulletimpact"    "Weapon_Baseball.HitWorld"
		    "scraperough"    "Grenade.ScrapeRough"
		    "scrapesmooth"    "Grenade.ScrapeSmooth"
		    "impacthard"    "Weapon_Baseball.HitWorld"
		    "impactsoft"    "Weapon_Baseball.HitWorld"
		    "rolling"    "Grenade.Roll"
		}]])
		```
    **/
    
    public static function AddSurfaceData(properties:String):Void;
    
    
    /**
        Gets the current performance settings in table form.
		
		`**Returns:** Performance settings. See PhysEnvPerformanceSettings structure
    **/
    
    public static function GetPerformanceSettings():PhysEnvPerformanceSettings;
    
    
    /**
        Sets the air density.
		
		Name | Description
		--- | ---
		`airDensity` | The new air density.
    **/
    
    public static function SetAirDensity(airDensity:Float):Void;
    
    
    /**
        Sets the directional gravity, does not work on players.
		
		Name | Description
		--- | ---
		`gravity` | The new gravity.
    **/
    
    public static function SetGravity(gravity:Vector):Void;
    
    
    /**
        Sets the performance settings.
		
		Name | Description
		--- | ---
		`performanceSettings` | The new performance settings. See PhysEnvPerformanceSettings structure
    **/
    
    public static function SetPerformanceSettings(performanceSettings:PhysEnvPerformanceSettings):Void;
    
    
    /**
        Gets the global gravity.
		
		`**Returns:** gravity
    **/
    
    public static function GetGravity():Vector;
    
    
    /**
        Returns the air density.
		
		`**Returns:** airDensity
    **/
    
    public static function GetAirDensity():Float;
    
    

}



