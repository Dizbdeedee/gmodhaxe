package gmod.libs;
#if server

/**
    The navigation mesh library. To be used with CNavArea. The navigation mesh is used by NextBot to calculate path to its target.
**/
@:native("_G.navmesh")extern class NavmeshLib {
    
    /**
        Finds the closest standable ground at, above, or below the provided position.
		
		**Note:** The ground must have at least 32 units of empty space above it to be considered by this function, unless 16 layers are tested without finding valid ground.
		
		Name | Description
		--- | ---
		`pos` | Position to find the closest ground for.
		
		
		Name | Description
		--- | ---
		`a` | The height of the ground layer.
		`b` | The normal of the ground layer.
    **/
    
    public static function GetGroundHeight(pos:Vector):NavmeshLibGetGroundHeightReturn;
    
    
    /**
        Starts the generation of a new navmesh.
		
		**Note:** This process is highly resource intensive and it's not wise to use during normal gameplay
    **/
    
    public static function BeginGeneration():Void;
    
    
    /**
        Returns the classname of the player spawn entity.
		
		`**Returns:** The classname of the spawn point entity. By default returns "info_player_start"
    **/
    
    public static function GetPlayerSpawnName():String;
    
    
    /**
        Sets the CNavLadder as marked, so it can be used with editing console commands.
		
		Name | Description
		--- | ---
		`area` | The CNavLadder to set as the marked ladder.
    **/
    
    public static function SetMarkedLadder(area:CNavLadder):Void;
    
    
    /**
        Returns true if a navmesh has been loaded when loading the map.
		
		`**Returns:** Whether a navmesh has been loaded when loading the map.
    **/
    
    public static function IsLoaded():Bool;
    
    
    /**
        Returns a bunch of areas within distance, used to find hiding spots by NextBots for example.
		
		Name | Description
		--- | ---
		`pos` | The position to search around
		`radius` | Radius to search within
		`stepdown` | Maximum stepdown( fall distance ) allowed
		`stepup` | Maximum stepup( jump height ) allowed
		
		
		`**Returns:** A table of CNavAreas
    **/
    
    public static function Find(pos:Vector, radius:Float, stepdown:Float, stepup:Float):AnyTable;
    
    
    /**
        Clears all the walkable positions, used before calling navmesh.BeginGeneration.
    **/
    
    public static function ClearWalkableSeeds():Void;
    
    
    /**
        Returns an integer indexed table of all CNavAreas on the current map. If the map doesn't have a navmesh generated then this will return an empty table.
		
		`**Returns:** A table of all the CNavAreas on the current map.
    **/
    
    public static function GetAllNavAreas():AnyTable;
    
    
    /**
        Returns a CNavArea by the given ID.
		
		**Note:** Avoid calling this function every frame, as internally it does a lookup trough all the CNavAreas, call this once and store the result
		
		Name | Description
		--- | ---
		`id` | ID of the CNavArea to get. Starts with 1.
		
		
		`**Returns:** The CNavArea with given ID.
    **/
    
    public static function GetNavAreaByID(id:Float):CNavArea;
    
    
    /**
        Returns the position of the edit cursor when nav_edit is set to 1.
		
		`**Returns:** The position of the edit cursor.
    **/
    
    public static function GetEditCursorPosition():Vector;
    
    
    /**
        Deletes every CNavArea and CNavLadder on the map without saving the changes.
    **/
    
    public static function Reset():Void;
    
    
    /**
        Saves any changes made to navmesh to the .nav file.
    **/
    
    public static function Save():Void;
    
    
    /**
        Sets the classname of the default spawn point entity, used before generating a new navmesh with navmesh.BeginGeneration.
		
		Name | Description
		--- | ---
		`spawnPointClass` | The classname of what the player uses to spawn, automatically adds it to the walkable positions during map generation.
    **/
    
    public static function SetPlayerSpawnName(spawnPointClass:String):Void;
    
    
    /**
        Returns the currently marked CNavArea, for use with editing console commands.
		
		`**Returns:** The currently marked CNavArea.
    **/
    
    public static function GetMarkedArea():CNavArea;
    
    
    /**
        Sets the CNavArea as marked, so it can be used with editing console commands.
		
		Name | Description
		--- | ---
		`area` | The CNavArea to set as the marked area.
    **/
    
    public static function SetMarkedArea(area:CNavArea):Void;
    
    
    /**
        Returns a CNavLadder by the given ID.
		
		Name | Description
		--- | ---
		`id` | ID of the CNavLadder to get. Starts with 1.
		
		
		`**Returns:** The CNavLadder with given ID.
    **/
    
    public static function GetNavLadderByID(id:Float):CNavLadder;
    
    
    /**
        Creates a new CNavArea.
		
		Name | Description
		--- | ---
		`corner` | The first corner of the new CNavArea
		`opposite_corner` | The opposite (diagonally) corner of the new CNavArea
		
		
		`**Returns:** The new CNavArea or nil if we failed for some reason.
    **/
    
    public static function CreateNavArea(corner:Vector, opposite_corner:Vector):CNavArea;
    
    
    /**
        Returns the highest ID of all nav areas on the map. While this can be used to get all nav areas, this number may not actually be the actual number of nav areas on the map.
		
		`**Returns:** The highest ID of all nav areas on the map.
    **/
    
    public static function GetNavAreaCount():Float;
    
    
    /**
        Returns the currently marked CNavLadder, for use with editing console commands.
		
		`**Returns:** The currently marked CNavLadder.
    **/
    
    public static function GetMarkedLadder():CNavLadder;
    
    
    /**
        Returns the Nav Area contained in this position that also satisfies the elevation limit. 
		
		This function will properly see blocked CNavAreas. See navmesh.GetNearestNavArea.
		
		Name | Description
		--- | ---
		`pos` | The position to search for.
		`beneathLimit` | The elevation limit at which the Nav Area will be searched.
		
		
		`**Returns:** The nav area.
    **/
    
    public static function GetNavArea(pos:Vector, beneathLimit:Float):CNavArea;
    
    
    /**
        Loads a new navmesh from the .nav file for current map discarding any changes made to the navmesh previously.
    **/
    
    public static function Load():Void;
    
    
    /**
        Returns the closest CNavArea to given position at the same height, or beneath it. 
		
		This function will ignore blocked CNavAreas. See navmesh.GetNavArea for a function that does see blocked areas.
		
		Name | Description
		--- | ---
		`pos` | The position to look from
		`anyZ` | This argument is ignored and has no effect
		`maxDist` | This is the maximum distance from the given position that the function will look for a CNavArea
		`checkLOS` | If this is set to true then the function will internally do a util.TraceLine from the starting position to each potential CNavArea with a MASK_NPCSOLID_BRUSHONLY MASK_ Enums. If the trace fails then the CNavArea is ignored. If this is set to false then the function will find the closest CNavArea through anything, including the world.
		`checkGround` | If checkGround is true then this function will internally call navmesh. GetNavArea to check if there is a CNavArea directly below the position, and return it if so, before checking anywhere else.
		`team` | This will internally call CNavArea: IsBlocked to check if the target CNavArea is not to be navigated by the given team. Currently this appears to do nothing.
		
		
		`**Returns:** The closest CNavArea found with the given parameters.
    **/
    
    public static function GetNearestNavArea(pos:Vector, ?anyZ:Bool, ?maxDist:Float, ?checkLOS:MASK, ?checkGround:Bool, ?team:Float):CNavArea;
    
    
    /**
        Whether we're currently generating a new navmesh with navmesh.BeginGeneration.
		
		`**Returns:** Whether we're generating a nav mesh or not.
    **/
    
    public static function IsGenerating():Bool;
    
    
    /**
        Add this position and normal to the list of walkable positions, used before map generation with navmesh.BeginGeneration
		
		Name | Description
		--- | ---
		`pos` | The terrain position.
		`dir` | The normal of this terrain position.
    **/
    
    public static function AddWalkableSeed(pos:Vector, dir:Vector):Void;
    
    

}


@:multiReturn extern class NavmeshLibGetGroundHeightReturn {
var a:Float;
var b:Vector;

}

#end