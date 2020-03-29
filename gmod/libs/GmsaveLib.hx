package gmod.libs;
#if server

/**
    The gmsave library provides functions relating to the singleplayer save system in Garry's Mod.
**/
@:native("_G.gmsave")extern class GmsaveLib {
    
    /**
        Saves the map
		
		Name | Description
		--- | ---
		`ply` | The player, whose position should be saved for loading the save
		
		
		`**Returns:** The encoded to JSON string containing save data
    **/
    
    public static function SaveMap(ply:Player):String;
    
    
    /**
        Returns a table containing player position and angles. Used by gmsave.SaveMap.
		
		Name | Description
		--- | ---
		`ply` | The player to "save"
		
		
		`**Returns:** A table containing player position ( Origin ) and angles ( Angle )
    **/
    
    public static function PlayerSave(ply:Player):AnyTable;
    
    
    /**
        Loads a saved map.
		
		Name | Description
		--- | ---
		`mapData` | The JSON encoded string containing all the map data.
		`ply` | The player to load positions for
    **/
    
    public static function LoadMap(mapData:String, ply:Player):Void;
    
    
    /**
        Sets player position and angles from supplied table
		
		Name | Description
		--- | ---
		`ply` | The player to "load" values for
		`data` | A table containing Origin and Angle keys for position and angles to set.
    **/
    
    public static function PlayerLoad(ply:Player, data:AnyTable):Void;
    
    
    /**
        Returns if we should save this entity in a duplication or a map save or not.
		
		Name | Description
		--- | ---
		`ent` | The entity
		`t` | A table containing classname key with entities classname.
		
		
		`**Returns:** Should save entity or not
    **/
    
    public static function ShouldSaveEntity(ent:Entity, t:AnyTable):Bool;
    
    

}



#end