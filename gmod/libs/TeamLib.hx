package gmod.libs;


/**
    The team library gives you access to the team system built into the Source engine, and allows you to create custom teams and get information about them.
**/
@:native("_G.team")extern class TeamLib {
    
    /**
        Returns the score of the team.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		
		
		`**Returns:** score
		
		___
		### Lua Examples
		#### Example 1
		Get's the teams score, can be a number 1 or 2 depending on how many teams you've set up.
		
		```lua 
		print(team.GetScore(ply:Team()),team.GetScore(1))
		```
		**Output:**
		
		1
    **/
    
    public static function GetScore(teamIndex:Float):Float;
    
    
    /**
        Returns the name of the team.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		
		
		`**Returns:** The team name. If the team is not defined, returns an empty string.
		
		___
		### Lua Examples
		#### Example 1
		Get's the teams string name.
		
		```lua 
		print(team.GetName(Entity(1):Team()))
		```
    **/
    
    public static function GetName(teamIndex:Float):String;
    
    
    /**
        Increases the score of the given team
		
		Name | Description
		--- | ---
		`index` | Index of the team
		`increment` | Amount to increase the team's score by
    **/
    
    public static function AddScore(index:Float, increment:Float):Void;
    
    
    /**
        Sets valid classes for use by a team. Classes can be created using player_manager.RegisterClass
		
		Name | Description
		--- | ---
		`index` | Index of the team
		`classes` | A class ID or table of class IDs
		
		
		___
		### Lua Examples
		#### Example 1
		Allows TEAM_RED to access the "Soldier" class
		
		```lua 
		team.SetClass( TEAM_RED, {"Soldier"} )
		```
    **/
    
    public static function SetClass(index:Float, classes:Dynamic):Void;
    
    
    /**
        Sets valid spawnpoint classes for use by a team.
		
		**Note:** GM.TeamBased must be set to true for this to work
		
		Name | Description
		--- | ---
		`index` | Index of the team
		`classes` | A spawnpoint classname or table of spawnpoint classnames
		
		
		___
		### Lua Examples
		#### Example 1
		Allows TEAM_BLUE to spawn at terrorist spawn points
		
		```lua 
		team.SetSpawnPoint( TEAM_BLUE, {"info_terror"} )
		```
    **/
    
    public static function SetSpawnPoint(index:Float, classes:Dynamic):Void;
    
    
    /**
        Returns the sum of deaths of all players of the team.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		
		
		`**Returns:** deathCount
		
		___
		### Lua Examples
		#### Example 1
		Get's the total deaths in a team.
		
		```lua 
		print(team.TotalDeaths(ply:Team()),team.TotalDeaths(1))
		```
		**Output:**
		
		2
    **/
    
    public static function TotalDeaths(teamIndex:Float):Float;
    
    
    /**
        Creates a new team.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		`teamName` | The team name.
		`teamColor` | The team color. Uses the Color structure.
		`isJoinable` | Whether the team is joinable or not.
		
		
		___
		### Lua Examples
		#### Example 1
		Create team 2 with name "Mingebags" and color red
		
		```lua 
		team.SetUp(2, "Mingebags", Color(255, 0, 0))
		```
    **/
    
    public static function SetUp(teamIndex:Float, teamName:String, teamColor:Color, ?isJoinable:Bool):Void;
    
    
    /**
        Returns the team index of the team with the least players. Falls back to TEAM_UNASSIGNED
		
		`**Returns:** Team index
    **/
    
    public static function BestAutoJoinTeam():Float;
    
    
    /**
        Returns a table of valid spawnpoint entities the team can use. These are set with team.SetSpawnPoint.
		
		Name | Description
		--- | ---
		`index` | Index of the team
		
		
		`**Returns:** Valid spawnpoint entities
		
		___
		### Lua Examples
		#### Example 1
		Prints a random spawnpoint entity for TEAM_RED
		
		```lua 
		print(table.Random(team.GetSpawnPoints(TEAM_RED)))
		```
		**Output:**
		
		Spawnpoint Entity
    **/
    
    public static function GetSpawnPoints(index:Float):AnyTable;
    
    
    /**
        Returns a table with all player of the specified team.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		
		
		`**Returns:** A table of Players that belong to the requested team.
		
		___
		### Lua Examples
		#### Example 1
		Prints all the players in a player's team.
		
		```lua 
		PrintTable(team.GetPlayers(ply:Team()))
		```
		**Output:**
		
		List of players.
    **/
    
    public static function GetPlayers(teamIndex:Float):AnyTable;
    
    
    /**
        Returns a table consisting of information on every defined team
		
		`**Returns:** Team info
		
		___
		### Lua Examples
		#### Example 1
		Prints all Jobs/Teams on the server. The list in printed from lowest to highest. Information about join able to the player, the score of the team and the colors.
		
		```lua 
		PrintTable( team.GetAllTeams() )
		```
    **/
    
    public static function GetAllTeams():AnyTable;
    
    
    /**
        Get's the total frags in a team.
		
		Name | Description
		--- | ---
		`Entity or number` | Entity or number.
		
		
		`**Returns:** index
		
		___
		### Lua Examples
		#### Example 1
		Get's the total frags in a team.
		
		```lua 
		print(team.TotalFrags(ply:Team()),team.TotalFrags(1))
		```
		**Output:**
		
		1
    **/
    
    public static function TotalFrags(number:Entity):Float;
    
    
    /**
        Sets the score of the given team
		
		Name | Description
		--- | ---
		`index` | Index of the team
		`score` | The team's new score
    **/
    
    public static function SetScore(index:Float, score:Float):Void;
    
    
    /**
        Returns if a team is joinable or not. This is set in team.SetUp.
		
		Name | Description
		--- | ---
		`index` | The index of the team.
		
		
		`**Returns:** True if the team is joinable. False otherwise.
    **/
    
    public static function Joinable(index:Float):Bool;
    
    
    /**
        Returns the amount of players in a team.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		
		
		`**Returns:** playerCount
		
		___
		### Lua Examples
		#### Example 1
		Prints the amount of players in a player's team
		
		```lua 
		print(team.NumPlayers(ply:Team()))
		```
		**Output:**
		
		The number of players in ply's team.
    **/
    
    public static function NumPlayers(teamIndex:Float):Float;
    
    
    /**
        Returns a table of valid spawnpoint classes the team can use. These are set with team.SetSpawnPoint.
		
		Name | Description
		--- | ---
		`index` | Index of the team
		
		
		`**Returns:** Valid spawnpoint classes
    **/
    
    public static function GetSpawnPoint(index:Float):AnyTable;
    
    
    /**
        Returns the team's color.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		
		
		`**Returns:** The team's color as a Color structure.
    **/
    
    public static function GetColor(teamIndex:Float):Color;
    
    
    /**
        Returns true if the given team index is valid
		
		Name | Description
		--- | ---
		`index` | Index of the team
		
		
		`**Returns:** Is valid
    **/
    
    public static function Valid(index:Float):Bool;
    
    
    /**
        Returns the selectable classes for the given team. This can be added to with team/SetClass
		
		Name | Description
		--- | ---
		`index` | Index of the team
		
		
		`**Returns:** Selectable classes
    **/
    
    public static function GetClass(index:Float):AnyTable;
    
    
    /**
        Sets the team's color.
		
		Name | Description
		--- | ---
		`teamIndex` | The team index.
		`color` | The team's new color as a Color structure.
    **/
    
    public static function SetColor(teamIndex:Float, color:Color):Void;
    
    

}



