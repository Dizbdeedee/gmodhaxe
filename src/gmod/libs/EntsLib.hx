package gmod.libs;


/**
    The ents library provides functions for creating and finding entities in the game.
**/
@:native("_G.ents")extern class EntsLib {
    
    /**
        Returns a table of all existing entities.
		
		`**Returns:** Table of all existing Entitys.
    **/
    
    static function GetAll():Table<Int,Entity>;
    
    
    /**
        Gets all entities within the specified sphere.
		
		**Note:** Clientside entities will not be returned by this function.
		
		Name | Description
		--- | ---
		`origin` | Center of the sphere.
		`radius` | Radius of the sphere.
		
		
		`**Returns:** A table of all found Entitys. Has a limit of 1024 entities.
    **/
    
    static function FindInSphere(origin:Vector, radius:Float):Table<Int,Entity>;
    
    #if server
    /**
        Fires a use event.
		
		Name | Description
		--- | ---
		`target` | Name of the target entity.
		`activator` | Activator of the event.
		`caller` | Caller of the event.
		`usetype` | Use type. See the USE_ Enums.
		`value` | This value is passed to ENTITY: Use, but isn't used by any default entities in the engine.
    **/
    
    static function FireTargets(target:String, activator:Entity, caller:Entity, usetype:USE, value:Float):Void;
    #end
    #if server
    /**
        Returns the amount of networked entities, which is limited to 8192. ents.Create will fail somewhere between 8064 and 8176 - this can vary based on the amount of existing temp ents.
		
		`**Returns:** Number of networked entities
    **/
    
    static function GetEdictCount():Int;
    #end
    #if client
    /**
        Creates a clientside only prop. See also ClientsideModel.
		
		**Warning:** Model must be precached with util.PrecacheModel on the server before usage.
		
		**Bug:** BUG Clientside entities are not garbage-collected, thus you must store a reference to the object and call CSEnt:Remove manually. Issue Tracker: #1387
		
		**Bug:** BUG Projected textures do not work on clientside props under specific conditions (see this explanation). Issue Tracker: #3268
		
		Name | Description
		--- | ---
		`model` | The model for the entity to be created. WARNING Model must be precached with util.PrecacheModel on the server before usage.
		
		
		`**Returns:** Created entity.
		
		___
		### Lua Examples
		#### Example 1
		Creates a clientside prop at the player location.
		
		```lua 
		function GhostBarrel( ply )
		    local c_Model = ents.CreateClientProp()
		    c_Model:SetPos( ply:GetPos() )
		    c_Model:SetModel( "models/props_borealis/bluebarrel001.mdl" )
		    c_Model:SetParent( ply )
		    c_Model:Spawn()
		end
		```
    **/
    
    static function CreateClientProp(?model:String):CSEnt;
    #end
    
    /**
        Gets all entities with the given hammer targetname. This works internally by iterating over ents.GetAll.
		
		**Note:** A player's Name is his nickname, see Player:GetName
		
		Name | Description
		--- | ---
		`name` | The targetname to look for
		
		
		`**Returns:** A table of all found entities
    **/
    
    static function FindByName(name:String):Table<Int,Entity>;
    
    
    /**
        Returns all entities within the specified box.
		
		**Warning:** There is a limit of 512 entities for the output!
		
		**Note:** Clientside entities will not be returned by this function.
		
		Name | Description
		--- | ---
		`boxMins` | The box minimum coordinates.
		`boxMaxs` | The box maximum coordinates.
		
		
		`**Returns:** A table of all found entities.
		
		___
		### Lua Examples
		#### Example 1
		Returns a table of players in a box using ents.FindInBox
		
		```lua 
		function ents.FindPlayersInBox( vCorner1, vCorner2 )
		    local tEntities = ents.FindInBox( vCorner1, vCorner2 )
		    local tPlayers = {}
		    local iPlayers = 0
		    
		    for i = 1, #tEntities do
		        if ( tEntities[ i ]:IsPlayer() ) then
		            iPlayers = iPlayers + 1
		            tPlayers[ iPlayers ] = tEntities[ i ]
		        end
		    end
		    
		    return tPlayers, iPlayers
		end
		```
    **/
    
    static function FindInBox(boxMins:Vector, boxMaxs:Vector):Table<Int,Entity>;
    
    #if server
    /**
        Finds all entities that lie within a PVS.
		
		**Note:** The function won't take in to account AddOriginToPVS and the like.
		
		Name | Description
		--- | ---
		`viewPoint` | Entity or Vector to find entities within the PVS of. If a player is given, this function will use the player's view entity.
		
		
		`**Returns:** The found Entitys.
    **/
    
	@:overload(function (viewPoint:Vector):Table<Int,Entity> {})
    static function FindInPVS(viewPoint:Entity):Table<Int,Entity>;
    #end
    
    /**
        Finds and returns all entities within the specified cone. Only entities whose Entity:WorldSpaceCenter is within the cone are considered to be in it. 
		
		The "cone" is actually a conical "slice" of an axis-aligned box (see: ents.FindInBox). The image to the right shows approximately how this function would look in 2D. Due to this, the entity may be farther than the specified range!
		
		**Warning:** If there are more than 512 entities in the axis-aligned box around the origin, then the result may be incomplete!
		
		**Note:** Clientside entities will not be returned by this function.
		
		Name | Description
		--- | ---
		`origin` | The tip of the cone.
		`normal` | Direction of the cone.
		`range` | The range of the cone/box around the origin.
		`angle_cos` | The cosine of the angle between the center of the cone to its edges, which is half the overall angle of the cone. 1 makes a 0° cone, 0.707 makes approximately 90°, 0 makes 180°, and so on.
		
		
		`**Returns:** A table of all found Entitys.
		
		___
		### Lua Examples
		#### Example 1
		An example usage of this function. This example shows which entities are being returned by the function with red lines and the range with white transparent box.
		
		```lua 
		local mat = Material( "models/shiny" )
		mat:SetFloat( "$alpha", 0.5 )
		
		hook.Add( "PostDrawOpaqueRenderables", "conetest", function()
		    local size = 200
		    local dir = LocalPlayer():GetAimVector()
		    local angle = math.cos( math.rad( 15 ) ) -- 15 degrees
		    local startPos = LocalPlayer():EyePos()
		
		    local entities = ents.FindInCone( startPos, dir, size, angle )
		
		    -- draw the outer box
		    local mins = Vector( -size, -size, -size )
		    local maxs = Vector( size, size, size )
		
		    render.SetMaterial( mat )
		    render.DrawWireframeBox( startPos, Angle( 0, 0, 0 ), mins, maxs, color_white, true )
		    render.DrawBox( startPos, Angle( 0, 0, 0 ), -mins, -maxs, color_white )
		
		    -- draw the lines
		    for id, ent in pairs( entities ) do
		        render.DrawLine( ent:WorldSpaceCenter() - dir * ( ent:WorldSpaceCenter()-startPos ):Length(), ent:WorldSpaceCenter(), Color( 255, 0, 0 ) )
		    end
		end )
		```
    **/
    
    static function FindInCone(origin:Vector, normal:Vector, range:Float, angle_cos:Float):Table<Int,Entity>;
    
    
    /**
        Returns an entity by its index. Same as Entity.
		
		Name | Description
		--- | ---
		`entIdx` | The index of the entity.
		
		
		`**Returns:** The entity if it exists.
    **/
    
    static function GetByIndex(entIdx:Int):Entity;
    
    
    /**
        Gives you the amount of currently existing entities. Similar to #ents.GetAll but with much better performance.
		
		Name | Description
		--- | ---
		`IncludeKillMe` | Include entities with the FL_KILLME flag. This will skip an internal loop, and the function will be more efficient as a byproduct.
		
		
		`**Returns:** Number of entities
    **/
    
    static function GetCount(?IncludeKillMe:Bool):Int;
    
    
    /**
        Gets all entities with the given model, supports wildcards. This works internally by iterating over ents.GetAll.
		
		**Bug:** BUG This currently only supports trailing asterisks (*) for wildcards. Issue Tracker: #2872
		
		Name | Description
		--- | ---
		`model` | The model of the entities to find.
		
		
		`**Returns:** A table of all found entities.
    **/
    
    static function FindByModel(model:String):Table<Int,Entity>;
    
    #if server
    /**
        Creates an entity. This function will fail and return NULL if the networked-edict limit is hit (around 8176), or the provided entity class doesn't exist.
		
		**Warning:** Do not use before GM:InitPostEntity has been called, otherwise the server will crash! If you need to perform entity creation when the game starts, create a hook for GM:InitPostEntity and do it there
		
		Name | Description
		--- | ---
		`class` | The classname of the entity to create
		
		
		`**Returns:** The created entity, or NULL if failed
		
		___
		### Lua Examples
		#### Example 1
		Creates a gmod_button entity near 0,0,0
		
		```lua 
		local button = ents.Create( "gmod_button" )
		if ( !IsValid( button ) ) then return end // Check whether we successfully made an entity, if not - bail
		button:SetModel( "models/dav0r/buttons/button.mdl" )
		button:SetPos( Vector( 0, 0, 100 ) )
		button:Spawn()
		```
    **/
    static function Create<T:Entity>(_class:EntityClass<T>):T;
    #end
    
    /**
        Gets all entities with the given class, supports wildcards. This works internally by iterating over ents.GetAll. Even if internally ents.GetAll is used, It is faster to use ents.FindByClass than ents.GetAll with a single class comparison.
		
		**Note:** Asterisks (*) are the only wildcard supported.
		
		Name | Description
		--- | ---
		`class` | The class of the entities to find.
		
		
		`**Returns:** A table containing all found entities
		
		___
		### Lua Examples
		#### Example 1
		Prints the location of every prop on the map.
		
		```lua 
		for k, v in pairs( ents.FindByClass( "prop_*" ) ) do
		    print( v:GetPos() )
		end
		```
		**Output:**
		
		The location of each prop on the map. In gm_construct, the output might be as follows: -2936.288818 -1376.545532 -73.852913 -2943.928467 -1375.800171 -84.964996 -2932.637695 -1288.051636 -76.791924 -2064.000000 -183.000000 -179.216003 -2384.000000 -183.000000 -179.216003 -2704.000000 -183.000000 -179.216003 -1744.000000 -183.000000 -179.216003 -1424.000000 -183.000000 -179.216003 -3019.895020 -1095.824829 -78.900757
	**/
	
	static function FindByClass<T:Entity>(_class:EntityClass<T>):Table<Int,T>;
    
    
    /**
        Returns a table of all entities along the ray. The ray does not stop on collisions, meaning it will go through walls/entities.
		
		Name | Description
		--- | ---
		`start` | The start position of the ray
		`end` | The end position of the ray
		`mins` | The mins corner of the ray
		`maxs` | The maxs corner of the ray
		
		
		`**Returns:** Table of the found entities.
    **/
    
    static function FindAlongRay(start:Vector, end:Vector, ?mins:Vector, ?maxs:Vector):Table<Int,Entity>;
    
    #if server
    /**
        Returns entity that has given Entity:MapCreationID.
		
		Name | Description
		--- | ---
		`id` | Entity's creation id
		
		
		`**Returns:** Found entity
    **/
    
    static function GetMapCreatedEntity(id:Float):Entity;
    #end
    
    /**
        Finds all entities that are of given class and are children of given entity. This works internally by iterating over ents.GetAll.
		
		Name | Description
		--- | ---
		`class` | The class of entities to search for
		`parent` | Parent of entities that are being searched for
		
		
		`**Returns:** A table of found entities or nil if none are found
	**/
	
  
    static function FindByClassAndParent<T:Entity>(_class:EntityClass<T>, parent:Entity):Table<Int,T>;
    
    #if client
    /**
        Creates a clientside only scripted entity. The scripted entity must be of "anim" type.
		
		Name | Description
		--- | ---
		`class` | The class name of the entity to create.
		
		
		`**Returns:** Created entity.
    **/
  
    static function CreateClientside<T:Entity>(_class:EntityClass<T>):T;
    #end
    

}



