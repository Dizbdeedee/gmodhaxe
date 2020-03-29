package gmod.libs;
#if client
/**
    This library is used internally by Garry's Mod to help keep track of achievement progress and unlock the appropriate achievements once a certain number is reached. 
	
	However, this library can also be used by anyone else to forcefully unlock certain achievements.
**/
@:native("_G.achievements")extern class AchievementsLib {
    
    /**
        Retrieves description of given achievement
		
		Name | Description
		--- | ---
		`achievementID` | The ID of achievement to retrieve description of. Note: IDs start from 0, not 1.
		
		
		`**Returns:** Description of an achievement
		
		___
		### Lua Examples
		#### Example 1
		Will print achievement descriptions for all of your achievements into console
		
		```lua 
		for i = 0, achievements.Count() - 1 do
		    print( achievements.GetDesc( i ) )
		end
		```
		**Output:**
		
		Prints achievement descriptions for all of your achievements into console.
    **/
    
    public static function GetDesc(achievementID:Float):String;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of things removed. Once this count reaches 5000, the 'Destroyer' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function Remover():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of how many times the spawnmenu has been opened. Once this count reaches 100,000, the 'Menu User' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function SpawnMenuOpen():Void;
    
    
    /**
        Retrieves name of given achievement
		
		Name | Description
		--- | ---
		`achievementID` | The ID of achievement to retrieve name of. Note: IDs start from 0, not 1.
		
		
		`**Returns:** Name of an achievement
		
		___
		### Lua Examples
		#### Example 1
		Will print all achievement names into console
		
		```lua 
		for i = 0, achievements.Count() - 1 do
		    print( achievements.GetName( i ) )
		end
		```
		**Output:**
		
		Prints all achievement names into console
    **/
    
    public static function GetName(achievementID:Float):String;
    
    
    /**
        Returns the amount of achievements in Garry's Mod.
		
		`**Returns:** The amount of achievements available.
    **/
    
    public static function Count():Float;
    
    
    /**
        Retrieves progress goal of given achievement
		
		Name | Description
		--- | ---
		`achievementID` | The ID of achievement to retrieve goal of. Note: IDs start from 0, not 1.
		
		
		`**Returns:** Progress goal of an achievement
		
		___
		### Lua Examples
		#### Example 1
		Will print achievement progress and goals for all of your achievements into console
		
		```lua 
		for i = 0, achievements.Count() - 1 do
		    print( achievements.GetCount( i ) .. " / " .. achievements.GetGoal( i ) )
		end
		```
		**Output:**
		
		Prints achievement progress and goals for all of your achievements into console.
    **/
    
    public static function GetGoal(achievementID:Float):Float;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of balloons burst. Once this count reaches 1000, the 'Popper' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function BalloonPopped():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of innocent animals killed. Once this count reaches 1000, the 'Innocent Bystander' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function IncBystander():Void;
    
    
    /**
        Retrieves progress of given achievement
		
		Name | Description
		--- | ---
		`achievementID` | The ID of achievement to retrieve progress of. Note: IDs start from 0, not 1.
		
		
		___
		### Lua Examples
		#### Example 1
		Will print achievement progress for all of your achievements into console
		
		```lua 
		for i = 0, achievements.Count() - 1 do
		    print( achievements.GetCount( i ) )
		end
		```
		**Output:**
		
		Prints achievement progress for all of your achievements into console. Note: Non-progress based achievements will have 0, even if they are completed
    **/
    
    public static function GetCount(achievementID:Float):Void;
    
    
    /**
        Used in GMod 12 in the achievements menu to show the user if they have unlocked certain achievements.
		
		Name | Description
		--- | ---
		`AchievementID` | Internal Achievement ID number
		
		
		`**Returns:** Returns true if the given achievementID is achieved.
		
		___
		### Lua Examples
		#### Example 1
		Prints true if you got the achievement.
		
		```lua 
		print("Did you get achievement number 7?, " .. achievements.IsAchieved(7))
		```
		**Output:**
		
		boolean true (assuming you have unlocked achievement 7)
    **/
    
    public static function IsAchieved(AchievementID:Float):Bool;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of balls eaten. Once this count reaches 200, the 'Ball Eater' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function EatBall():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of baddies killed. Once this count reaches 1000, the 'War Zone' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function IncBaddies():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of NPCs spawned. Once this count reaches 1000, the 'Procreator' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function SpawnedNPC():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of ragdolls spawned. Once this count reaches 2000, the 'Dollhouse' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function SpawnedRagdoll():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of friendly NPCs killed. Once this count reaches 1000, the 'Bad Friend' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function IncGoodies():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds one to the count of props spawned. Once this count reaches 5000, the 'Creator' achievement is unlocked.
    **/
    @:deprecated("INTERNAL")
    public static function SpawnedProp():Void;
    
    

}



#end