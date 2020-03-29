package gmod.libs;


/**
    This is the list of utility functions.
**/
@:native("_G.util")extern class UtilLib {
    
    /**
        Runs a trace using the entity's collisionmodel between two points. This does not take the entity's angles into account and will trace its unrotated collisionmodel.
		
		**Note:** Clientside entities will not be hit by traces.
		
		Name | Description
		--- | ---
		`tracedata` | Trace data. See Trace structure
		`ent` | The entity to use
		
		
		`**Returns:** Trace result. See TraceResult structure
		
		___
		### Lua Examples
		#### Example 1
		From sandbox/gamemode/prop_tools.lua, this checks if there are any entities inside our entity
		
		```lua 
		local trace = { start = ent:GetPos(), endpos = ent:GetPos(), filter = ent }
		local tr = util.TraceEntity( trace, ent ) 
		if ( tr.Hit ) then
		 -- Do stuff
		end
		```
    **/
    
    public static function TraceEntity(tracedata:Trace, ent:Entity):TraceResult;
    
    
    /**
        Formats a float by stripping off extra 0's and .'s
		
		Name | Description
		--- | ---
		`float` | The float to format
		
		
		`**Returns:** Formatted float
    **/
    
    public static function NiceFloat(float:Float):String;
    
    
    /**
        Checks if the specified prop is valid.
		
		Name | Description
		--- | ---
		`modelName` | Name/Path of the model to check.
		
		
		`**Returns:** Returns true if the specified prop is valid; otherwise false.
    **/
    
    public static function IsValidProp(modelName:String):Bool;
    
    
    /**
        Checks if given numbered physics object of given entity is valid or not. Most useful for ragdolls.
		
		Name | Description
		--- | ---
		`ent` | The entity
		`physobj` | Number of the physics object to test
		
		
		`**Returns:** true is valid, false otherwise
    **/
    
    public static function IsValidPhysicsObject(ent:Entity, physobj:Float):Bool;
    
    
    /**
        Creates a tracer effect with the given parameters.
		
		Name | Description
		--- | ---
		`name` | The name of the tracer effect.
		`startPos` | The start position of the tracer.
		`endPos` | The end position of the tracer.
		`doWhiz` | Play the hit miss(whiz) sound.
    **/
    
    public static function ParticleTracer(name:String, startPos:Vector, endPos:Vector, doWhiz:Bool):Void;
    
    
    /**
        Returns the time since this function has been last called
		
		`**Returns:** Time since this function has been last called in ms
    **/
    
    public static function TimerCycle():Float;
    
    
    /**
        Performs a trace and paints a decal to the surface hit.
		
		Name | Description
		--- | ---
		`name` | The name of the decal to paint.
		`start` | The start of the trace.
		`end` | The end of the trace.
		`filter` | If set, the decal will not be able to be placed on given entity. Can also be a table of entities.
    **/
    
    public static function Decal(name:String, start:Vector, end:Vector, ?filter:Entity):Void;
    
    #if client
    /**
        Gets information about the sun position and obstruction or nil if there is no sun.
		
		`**Returns:** The sun info. See SunInfo structure
    **/
    
    public static function GetSunInfo():SunInfo;
    #end
    
    /**
        Returns the networked string associated with the given ID from the string table.
		
		Name | Description
		--- | ---
		`stringTableID` | ID to get the associated string from.
		
		
		`**Returns:** The networked string, or nil if it wasn't found.
    **/
    
    public static function NetworkIDToString(stringTableID:Float):String;
    
    #if server
    /**
        Applies spherical damage based on damage info to all entities in the specified radius.
		
		Name | Description
		--- | ---
		`dmg` | The information about the damage
		`damageOrigin` | Center of the spherical damage
		`damageRadius` | The radius in which entities will be damaged.
    **/
    
    public static function BlastDamageInfo(dmg:CTakeDamageInfo, damageOrigin:Vector, damageRadius:Float):Void;
    #end
    #if server
    /**
        Returns a table of all SteamIDs that have a usergroup.
		
		**Note:** This returns the original usergroups table, changes done to this table are not retroactive and will only affect newly connected users
		
		`**Returns:** The table of users. The table consists of SteamID-Table pairs, where the table has 2 fields: string name - Players name string group - The players user group
    **/
    
    public static function GetUserGroups():AnyTable;
    #end
    #if client
    /**
        Creates a new PixVis handle. See util.PixelVisible.
		
		`**Returns:** PixVis
    **/
    
    public static function GetPixelVisibleHandle():Pixelvis;
    #end
    
    /**
        Converts the given table into a key value string.
		
		Name | Description
		--- | ---
		`table` | The table to convert.
		
		
		`**Returns:** KeyValueString
    **/
    
    public static function TableToKeyValues(table:AnyTable):String;
    
    
    /**
        Gets the distance between a line and a point in 3d space.
		
		Name | Description
		--- | ---
		`lineStart` | Start of the line.
		`lineEnd` | End of the line.
		`pointPos` | The position of the point.
		
		
		Name | Description
		--- | ---
		`a` | Distance from line.
		`b` | Nearest point on line.
		`c` | Distance along line from start.
    **/
    
    public static function DistanceToLine(lineStart:Vector, lineEnd:Vector, pointPos:Vector):UtilLibDistanceToLineReturn;
    
    #if client
    /**
        Performs a trace and paints a decal to the surface hit.
		
		**Note:** This function has trouble spanning across multiple brushes on the map.
		
		Name | Description
		--- | ---
		`material` | The name of the decal to paint. Can be retrieved with util. DecalMaterial.
		`ent` | The entity to apply the decal to
		`position` | The position of the decal.
		`normal` | The direction of the decal.
		`color` | The color of the decal. Uses the Color structure. This only works when used on a brush model and only if the decal material has set $vertexcolor to 1.
		`w` | The width scale of the decal.
		`h` | The height scale of the decal.
    **/
    
    public static function DecalEx(material:IMaterial, ent:Entity, position:Vector, normal:Vector, color:Color, w:Float, h:Float):Void;
    #end
    
    /**
        Converts a KeyValue string to a Lua table.
		
		**Note:** Table keys will not repeat, see util.KeyValuesToTablePreserveOrder.
		
		Name | Description
		--- | ---
		`keyValues` | The KeyValue string to convert.
		`usesEscapeSequences` | If set to true, will replace \t, \n, \" and \\ in the input text with their escaped variants
		`preserveKeyCase` | Whether we should preserve key case or not.
		
		
		`**Returns:** The converted table
		
		___
		### Lua Examples
		#### Example 1
		Example usage and output of this function. Note how there's only one "solid" key in the table despite the fact that input string contains multiple.
		
		```lua 
		local ModelInfo = util.GetModelInfo("models/combine_gate_vehicle.mdl" )
		PrintTable( util.KeyValuesToTable( ModelInfo.KeyValues ) )
		```
    **/
    
    public static function KeyValuesToTable(keyValues:String, ?usesEscapeSequences:Bool, ?preserveKeyCase:Bool):AnyTable;
    
    
    /**
        Makes the screen shake
		
		**Note:** Does nothing on client.
		
		**Note:** Does nothing on client.
		
		Name | Description
		--- | ---
		`pos` | The origin of the effect. NOTE Does nothing on client.
		`amplitude` | The strength of the effect
		`frequency` | The frequency of the effect in hz
		`duration` | The duration of the effect in seconds
		`radius` | The range from the origin within which views will be affected, in Hammer Units NOTE Does nothing on client.
		
		
		___
		### Lua Examples
		#### Example 1
		This will shake the screen, from the position 0 0 0 and 5000 units away, with 5 amp, frequency 5, for 10 seconds.
		
		```lua 
		util.ScreenShake( Vector(0,0,0), 5, 5, 10, 5000 )
		```
    **/
    
    public static function ScreenShake(pos:Vector, amplitude:Float, frequency:Float, duration:Float, radius:Float):Void;
    
    
    /**
        Returns a vector in world coordinates based on an entity and local coordinates
		
		Name | Description
		--- | ---
		`ent` | The entity lpos is local to
		`lpos` | Coordinates local to the ent
		`bonenum` | The bonenumber of the ent lpos is local to
		
		
		`**Returns:** wpos
    **/
    
    public static function LocalToWorld(ent:Entity, lpos:Vector, bonenum:Float):Vector;
    
    
    /**
        Converts a JSON string to a Lua table.
		
		**Warning:** This function converts keys to numbers whenever possible.
		
		**Bug:** BUG This will attempt cast the string keys "inf", "nan", "true", and "false" to their respective Lua values. This completely ignores nulls in arrays. Issue Tracker: #3561
		
		Name | Description
		--- | ---
		`json` | The JSON string to convert.
		
		
		`**Returns:** The table containing converted information. Returns nothing on failure.
    **/
    
    public static function JSONToTable(json:String):AnyTable;
    
    
    /**
        Returns a table containing the info about the model. It seems to be not working serverside, but still exists serverside.
		
		**Note:** This function will silently fail if used on models with following strings in them: _shared _anims _gestures _anim _postures _gst _pst _shd _ss _anm _include
		
		Name | Description
		--- | ---
		`mdl` | Model path
		
		
		`**Returns:** The model info as a table with the following keys: number SkinCount - Identical to Entity:SkinCount. string KeyValues - Valve key-value formatted info about the model's physics (Constraint Info, etc). This is limited to 4096 characters. string ModelKeyValues - Valve key-value formatted info about the model ($keyvalues command in the .qc of the model), if present
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function. We use util.KeyValuesToTablePreserveOrder in order to preserve multiple keys with the same name.
		
		```lua 
		local ModelInfo = util.GetModelInfo("models/combine_gate_vehicle.mdl" )
		print( ModelInfo.SkinCount ) // The skin count
		PrintTable( util.KeyValuesToTablePreserveOrder( ModelInfo.KeyValues ) ) // Physics data
		```
    **/
    
    public static function GetModelInfo(mdl:String):AnyTable;
    
    
    /**
        Decompresses the given string using LZMA algorithm. Used to decompress strings previously compressed with util.Compress.
		
		Name | Description
		--- | ---
		`compressedString` | The compressed string to decompress.
		`maxSize` | The maximal size in bytes it will decompress.
		
		
		`**Returns:** The original, decompressed string or an empty string on failure or invalid input.
    **/
    
    public static function Decompress(compressedString:String, ?maxSize:Float):String;
    
    
    /**
        Returns a new Stack object
		
		`**Returns:** A brand new stack object
    **/
    
    public static function Stack():Stack;
    
    #if client
    /**
        Returns a table of visual meshes of given model.
		
		**Note:** This does not work on brush models (*<number> models)
		
		Name | Description
		--- | ---
		`model` | The full path to a model to get the visual meshes of.
		`lod` | 
		`bodygroupMask` | 
		
		
		`**Returns:** A table of tables with the following format: string material - The material of the specific mesh table triangles - A table of MeshVertex structures ready to be fed into IMesh:BuildFromTriangles table verticies - A table of MeshVertex structures representing all the vertexes of the mesh. This table is used internally to generate the "triangles" table. Each MeshVertex structure returned also has an extra table of tables field called "weights" with the following data: number boneID - The bone this vertex is attached to number weight - How "strong" this vertex is attached to the bone. A vertex can be attached to multiple bones at once.
		
		___
		### Lua Examples
		#### Example 1
		Simple example usage on a Scripted Entity.
		
		```lua 
		-- The default material to render with in case we for some reason don't have one
		local myMaterial = Material( "models/wireframe" ) -- models/debug/debugwhite
		
		function ENT:CreateMesh()
		    -- Destroy any previous meshes
		    if ( self.Mesh ) then self.Mesh:Destroy() end
		
		    -- Get a list of all meshes of a model
		    local visualMeshes = util.GetModelMeshes( "models/combine_helicopter/helicopter_bomb01.mdl" )
		
		    -- Check if the model even exists
		    if ( !visualMeshes ) then return end
		
		    -- Select the first mesh
		    local visualMesh = visualMeshes[ 1 ]
		
		    -- Set the material to draw the mesh with from the model data
		    myMaterial = Material( visualMesh.material )
		
		    -- You can apply any changes to visualMesh.trianges table here, distorting the mesh
		    -- or any other changes you can come up with
		
		    -- Create and build the mesh
		    self.Mesh = Mesh()
		    self.Mesh:BuildFromTriangles( visualMesh.triangles )
		end
		
		-- A special hook to override the normal mesh for rendering
		function ENT:GetRenderMesh()
		    -- If the mesh doesn't exist, create it!
		    if ( !self.Mesh ) then return self:CreateMesh() end
		
		    return { Mesh = self.Mesh, Material = myMaterial }
		end
		
		function ENT:Draw()
		    -- Draw the entity's model normally, this calls GetRenderMesh at some point
		    self:DrawModel()
		end
		```
    **/
    
    public static function GetModelMeshes(model:String, ?lod:Float, ?bodygroupMask:Float):MeshVertex;
    #end
    
    /**
        Converts a string to the specified type. 
		
		This can be useful when dealing with ConVars.
		
		Name | Description
		--- | ---
		`str` | The string to convert
		`typename` | The type to attempt to convert the string to. This can be vector, angle, float, int, bool, or string (case insensitive).
		
		
		`**Returns:** The result of the conversion, or nil if a bad type is specified.
		
		___
		### Lua Examples
		#### Example 1
		Creates a vector from a string representation.
		
		```lua 
		local vec = util.StringToType("5 6 75", "Vector")
		```
		**Output:**
		
		A vector with components (5, 6, 75)
    **/
    
    public static function StringToType(str:String, typename:String):Dynamic;
    
    
    /**
        Precaches a sound for later use. Sound is cached after being loaded once.
		
		**Note:** Soundcache is limited to 16384 unique sounds.
		
		Name | Description
		--- | ---
		`soundName` | The sound to precache.
    **/
    
    public static function PrecacheSound(soundName:String):Void;
    
    
    /**
        Converts a table to a JSON string.
		
		**Warning:** All integers will be converted to decimals (5 -> 5.0).
		
		**Warning:** All keys are strings in the JSON format, so all keys will be converted to strings!
		
		**Bug:** BUG This will produce invalid JSON if the provided table contains nan or inf values. Issue Tracker: #3561
		
		Name | Description
		--- | ---
		`table` | Table to convert.
		`prettyPrint` | Format and indent the JSON.
		
		
		`**Returns:** A JSON formatted string containing the serialized data
		
		___
		### Lua Examples
		#### Example 1
		Writes the positions and angles of every player to a txt document called playerstuff.txt
		
		```lua 
		local Players = {}
		for k, v in pairs(ents.GetAll()) do
		    if v:IsPlayer() then -- Is a player
		        Players[k] = { pos = v:GetPos(), ang = v:GetAngles() }
		    end
		end
		    
		local tab = util.TableToJSON( Players ) -- Convert the player table to JSON
		file.CreateDir( "jsontest" ) -- Create the directory
		file.Write( "jsontest/playerstuff.txt", tab) -- Write to .txt
		```
    **/
    
    public static function TableToJSON(table:AnyTable, ?prettyPrint:Bool):String;
    
    
    /**
        Creates a timer object.
		
		Name | Description
		--- | ---
		`startdelay` | How long you want the timer to be.
		
		
		`**Returns:** A timer object. It has next methods: Reset() - Resets the timer to nothing Start( time ) - Starts the timer, call with end time Started() - Returns true if the timer has been started Elapsed() - Returns true if the time has elapsed
    **/
    
    public static function Timer(?startdelay:Float):AnyTable;
    
    
    /**
        ***Deprecated:** You should use tobool instead.
		
		Converts string or a number to a bool, if possible. Alias of tobool.
		
		Name | Description
		--- | ---
		`input` | A string or a number to convert.
		
		
		`**Returns:** False if the input is equal to the string or boolean "false", if the input is equal to the string or number "0", or if the input is nil. Returns true otherwise.
    **/
    @:deprecated("You should use tobool instead.")
    public static function tobool(input:Dynamic):Bool;
    
    
    /**
        Generates the CRC checksum of the specified string.
		
		Name | Description
		--- | ---
		`stringToHash` | The string to calculate the checksum of.
		
		
		`**Returns:** The unsigned 32 bit checksum.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the CRC-32 checksum of "a".
		
		```lua 
		print( util.CRC( "a" ))
		```
		**Output:**
		
		3904355907
    **/
    
    public static function CRC(stringToHash:String):String;
    
    
    /**
        Gets PData of an offline player using their SteamID
		
		**Warning:** This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
		
		Name | Description
		--- | ---
		`steamID` | SteamID of the player
		`name` | Variable name to get the value of
		`default` | The default value, in case there's nothing stored
		
		
		`**Returns:** The stored value
    **/
    
    public static function GetPData(steamID:String, name:String, _default:String):String;
    
    
    /**
        Removes PData of offline player using his SteamID
		
		**Warning:** This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
		
		Name | Description
		--- | ---
		`steamID` | SteamID of the player
		`name` | Variable name to remove
    **/
    
    public static function RemovePData(steamID:String, name:String):Void;
    
    
    /**
        Returns the networked ID associated with the given string from the string table.
		
		Name | Description
		--- | ---
		`networkString` | String to get the associated networked ID from.
		
		
		`**Returns:** The networked ID of the string, or 0 if it hasn't been networked with util. AddNetworkString.
    **/
    
    public static function NetworkStringToID(networkString:String):Float;
    
    #if server
    /**
        Adds a trail to the specified entity.
		
		Name | Description
		--- | ---
		`ent` | Entity to attach trail to
		`attachmentID` | Attachment ID of the entitiys model to attach trail to. If you are not sure, set this to 0
		`color` | Color of the trail, use Color
		`additive` | Should the trail be additive or not
		`startWidth` | Start width of the trail
		`endWidth` | End width of the trail
		`lifetime` | How long it takes to transition from startWidth to endWidth
		`textureRes` | The resolution of trails texture. A good value can be calculated using this formula: 1 / ( startWidth + endWidth ) * 0.5
		`texture` | Path to the texture to use as a trail.
		
		
		`**Returns:** Entity of created trail ( env_spritetrail)
		
		___
		### Lua Examples
		#### Example 1
		A console command that gives the player a red trail.
		
		```lua 
		concommand.Add( "givetrail", function( ply )
		    local trail = util.SpriteTrail( ply, 0, Color( 255, 0, 0 ), false, 15, 1, 4, 1 / ( 15 + 1 ) * 0.5, "trails/plasma" )
		    print( trail )
		end )
		```
    **/
    
    public static function SpriteTrail(ent:Entity, attachmentID:Float, color:AnyTable, additive:Bool, startWidth:Float, endWidth:Float, lifetime:Float, textureRes:Float, texture:String):Entity;
    #end
    
    /**
        Returns the contents of the position specified.
		
		Name | Description
		--- | ---
		`position` | Position to get the contents sample from.
		
		
		`**Returns:** Contents bitflag, see CONTENTS_ Enums
		
		___
		### Lua Examples
		#### Example 1
		Check if the trace position is underwater.
		
		```lua 
		local tr = Entity( 1 ):GetEyeTrace()
		print( bit.band( util.PointContents( tr.HitPos ), CONTENTS_WATER ) == CONTENTS_WATER )
		```
    **/
    
    public static function PointContents(position:Vector):CONTENTS;
    
    
    /**
        Given a STEAM_0 style Steam ID will return a 64bit Steam ID
		
		Name | Description
		--- | ---
		`id` | The STEAM_0 style id
		
		
		`**Returns:** 64bit Steam ID
    **/
    
    public static function SteamIDTo64(id:String):String;
    
    
    /**
        Returns the name of a surface property at given ID. 
		
		See also util.GetSurfaceData and util.GetSurfaceIndex for opposite function.
		
		Name | Description
		--- | ---
		`id` | Surface property ID. You can get it from TraceResult structure.
		
		
		`**Returns:** The name or an empty string if there is no valid surface property at given index.
    **/
    
    public static function GetSurfacePropName(id:TraceResult):String;
    
    
    /**
        Function used to calculate aim vector from 2D screen position. It is used in SuperDOF calculate Distance. 
		
		Essentially a generic version of gui.ScreenToVector.
		
		Name | Description
		--- | ---
		`ViewAngles` | View angles
		`ViewFOV` | View Field of View
		`x` | Mouse X position
		`y` | Mouse Y position
		`scrWidth` | Screen width
		`scrHeight` | Screen height
		
		
		`**Returns:** Calculated aim vector
    **/
    
    public static function AimVector(ViewAngles:Angle, ViewFOV:Float, x:Float, y:Float, scrWidth:Float, scrHeight:Float):Vector;
    
    
    /**
        ***Deprecated:** This function is broken and returns the same values all the time
		
		Traces from one entity to another.
		
		Name | Description
		--- | ---
		`ent1` | The first entity to trace from
		`ent2` | The second entity to trace to
		
		
		`**Returns:** Trace result. See TraceResult structure
    **/
    @:deprecated("This function is broken and returns the same values all the time")
    public static function TraceEntityHull(ent1:Entity, ent2:Entity):TraceResult;
    
    
    /**
        Creates a tracer effect with the given parameters.
		
		Name | Description
		--- | ---
		`name` | The name of the tracer effect.
		`startPos` | The start position of the tracer.
		`endPos` | The end position of the tracer.
		`doWhiz` | Play the hit miss(whiz) sound.
		`entityIndex` | Entity index of the emitting entity.
		`attachmentIndex` | Attachment index to be used as origin.
    **/
    
    public static function ParticleTracerEx(name:String, startPos:Vector, endPos:Vector, doWhiz:Bool, entityIndex:Float, attachmentIndex:Float):Void;
    
    
    /**
        Performs an AABB hull (axis-aligned bounding box, aka not rotated) trace with the given trace data.
		
		**Note:** Clientside entities will not be hit by traces.
		
		**Note:** This function may not always give desired results clientside due to certain physics mechanisms not existing on the client. Use it serverside for accurate results.
		
		Name | Description
		--- | ---
		`TraceData` | The trace data to use. See HullTrace structure
		
		
		`**Returns:** Trace result. See TraceResult structure
		
		___
		### Lua Examples
		#### Example 1
		From a SWEP:PrimaryAttack()
		
		```lua 
		local tr = util.TraceHull( {
		    start = self.Owner:GetShootPos(),
		    endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 ),
		    filter = self.Owner,
		    mins = Vector( -10, -10, -10 ),
		    maxs = Vector( 10, 10, 10 ),
		    mask = MASK_SHOT_HULL
		} )
		```
		
		#### Example 2
		Visual representation of a Hull Trace.
		
		```lua 
		function ENT:Draw()
		
		    self:DrawModel()
		    
		    local ent = self
		    
		    local mins = ent:OBBMins()
		    local maxs = ent:OBBMaxs()
		    local startpos = ent:GetPos()
		    local dir = ent:GetUp()
		    local len = 128
		
		    local tr = util.TraceHull( {
		        start = startpos,
		        endpos = startpos + dir * len,
		        maxs = maxs,
		        mins = mins,
		        filter = ent
		    } )
		    
		    render.DrawLine( tr.HitPos, startpos + dir * len, color_white, true )
		    render.DrawLine( startpos, tr.HitPos, Color( 0, 0, 255 ), true )
		    
		    local clr = color_white
		    if ( tr.Hit ) then
		        clr = Color( 255, 0, 0 )
		    end
		
		    render.DrawWireframeBox( startpos, Angle( 0, 0, 0 ), mins, maxs, Color( 255, 255, 255 ), true )
		    render.DrawWireframeBox( tr.HitPos, Angle( 0, 0, 0 ), mins, maxs, clr, true )
		
		end
		```
		
		#### Example 3
		Trace a player sized hull to detect if a player can spawn here without getting stuck inside anything.
		
		```lua 
		local pos = Entity(1):GetPos() -- Choose your position.
		
		local tr = {
		    start = pos,
		    endpos = pos,
		    mins = Vector( -16, -16, 0 ),
		    maxs = Vector( 16, 16, 71 )
		}
		
		local hullTrace = util.TraceHull( tr )
		if ( hullTrace.Hit ) then
		    -- Find a new spawnpoint
		end
		```
    **/
    
    public static function TraceHull(TraceData:HullTrace):TraceResult;
    
    
    /**
        Performs a ray-plane intersection and returns the hit position or nil.
		
		Name | Description
		--- | ---
		`rayOrigin` | Origin/start position of the ray.
		`rayDirection` | The direction of the ray.
		`planePosition` | Any position of the plane.
		`planeNormal` | The normal vector of the plane.
		
		
		`**Returns:** The position of intersection, nil if not hit.
    **/
    
    public static function IntersectRayWithPlane(rayOrigin:Vector, rayDirection:Vector, planePosition:Vector, planeNormal:Vector):Vector;
    
    
    /**
        Converts a type to a (nice, but still parsable) string
		
		Name | Description
		--- | ---
		`input` | What to convert
		
		
		`**Returns:** Converted string
    **/
    
    public static function TypeToString(input:Dynamic):String;
    
    
    /**
        Returns the current date formatted like '2012-10-31 18-00-00'
		
		`**Returns:** date
    **/
    
    public static function DateStamp():String;
    
    #if server
    /**
        Checks if a certain position in within the world bounds.
		
		Name | Description
		--- | ---
		`position` | Position to check.
		
		
		`**Returns:** Whether the vector is in world.
		
		___
		### Lua Examples
		#### Example 1
		Here's a trick you can do to achieve the behavior of this function on the client.(This may be less efficient than the serverside function itself)
		
		```lua 
		local tr = { collisiongroup = COLLISION_GROUP_WORLD }
		function util.IsInWorld( pos )
		    tr.start = pos
		    tr.endpos = pos
		    return util.TraceLine( tr ).HitWorld
		end
		```
    **/
    
    public static function IsInWorld(position:Vector):Bool;
    #end
    
    /**
        Given a 64bit SteamID will return a STEAM_0: style Steam ID
		
		Name | Description
		--- | ---
		`id` | The 64 bit Steam ID
		
		
		`**Returns:** STEAM_0 style Steam ID
    **/
    
    public static function SteamIDFrom64(id:String):String;
    
    
    /**
        Performs a "ray" box intersection and returns position, normal and the fraction.
		
		Name | Description
		--- | ---
		`rayStart` | Origin/start position of the ray.
		`rayDelta` | The ray vector itself. This can be thought of as: the ray end point relative to the start point. Note that in this implementation, the ray is not infinite - it's only a segment.
		`boxOrigin` | The center of the box.
		`boxAngles` | The angles of the box.
		`boxMins` | The min position of the box.
		`boxMaxs` | The max position of the box.
		
		
		Name | Description
		--- | ---
		`a` | Hit position, nil if not hit.
		`b` | Normal/direction vector, nil if not hit.
		`c` | Fraction of trace used, nil if not hit.
    **/
    
    public static function IntersectRayWithOBB(rayStart:Vector, rayDelta:Vector, boxOrigin:Vector, boxAngles:Angle, boxMins:Vector, boxMaxs:Vector):UtilLibIntersectRayWithOBBReturn;
    
    #if server
    /**
        Applies explosion damage to all entities in the specified radius.
		
		Name | Description
		--- | ---
		`inflictor` | The entity that caused the damage.
		`attacker` | The entity that attacked.
		`damageOrigin` | The center of the explosion
		`damageRadius` | The radius in which entities will be damaged.
		`damage` | The amount of damage to be applied.
    **/
    
    public static function BlastDamage(inflictor:Entity, attacker:Entity, damageOrigin:Vector, damageRadius:Float, damage:Float):Void;
    #end
    
    /**
        Precaches a model for later use. Model is cached after being loaded once.
		
		**Warning:** Modelprecache is limited to 4096 unique models. When it reaches the limit the game will crash.
		
		Name | Description
		--- | ---
		`modelName` | The model to precache.
    **/
    
    public static function PrecacheModel(modelName:String):Void;
    
    
    /**
        Checks if the model is loaded in the game.
		
		Name | Description
		--- | ---
		`modelName` | Name/Path of the model to check.
		
		
		`**Returns:** Returns true if the model is loaded in the game; otherwise false.
    **/
    
    public static function IsModelLoaded(modelName:String):Bool;
    
    #if client
    /**
        Check whether the skybox is visibile from the point specified.
		
		**Note:** This will always return true in fullbright maps
		
		Name | Description
		--- | ---
		`position` | The position to check the skybox visibility from.
		
		
		`**Returns:** Whether the skybox is visible from the position.
    **/
    
    public static function IsSkyboxVisibleFromPoint(position:Vector):Bool;
    #end
    
    /**
        Generates a random float value that should be the same on client and server.
		
		**Note:** This function is best used in a Predicted Hook
		
		Name | Description
		--- | ---
		`uniqueName` | The seed for the random value
		`min` | The minimum value of the random range
		`max` | The maximum value of the random range
		`additionalSeed` | The additional seed
		
		
		`**Returns:** The random float value
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function. Generates some random values.
		
		```lua 
		print( util.SharedRandom( "23", 0, 100 ) )
		print( util.SharedRandom( "23", 0, 100 ) )
		print( util.SharedRandom( "23", 0, 100, 0 ) )
		print( util.SharedRandom( "23", 0, 100, 1337 ) )
		print( util.SharedRandom( "lol", 0, 100, 1337 ) )
		```
		**Output:**
		
		15.979786317786
		15.979786317786
		15.979786317786
		24.08124470342
		78.480193614252
    **/
    
    public static function SharedRandom(uniqueName:String, min:Float, max:Float, ?additionalSeed:Float):Float;
    
    
    /**
        Returns the matching surface property index for the given surface property name. 
		
		See also util.GetSurfaceData and util.GetSurfacePropName for opposite function.
		
		Name | Description
		--- | ---
		`surfaceName` | The name of the surface.
		
		
		`**Returns:** The surface property index, or -1 if name doesn't correspond to a valid surface property.
    **/
    
    public static function GetSurfaceIndex(surfaceName:String):Float;
    
    
    /**
        Returns data of a surface property at given ID.
		
		Name | Description
		--- | ---
		`id` | Surface property ID. You can get it from TraceResult structure.
		
		
		`**Returns:** The data or no value if there is no valid surface property at given index. See SurfacePropertyData structure
    **/
    
    public static function GetSurfaceData(id:TraceResult):SurfacePropertyData;
    
    #if client
    /**
        Returns the visibility of a sphere in the world.
		
		**Warning:** Don't use the same handle twice per tick or it will give unpredictable results.
		
		Name | Description
		--- | ---
		`position` | The center of the visibility test.
		`radius` | The radius of the sphere to check for visibility.
		`handle t PixVis` | The PixVis handle created with util.GetPixelVisibleHandle. WARNING Don't use the same handle twice per tick or it will give unpredictable results.
		
		
		`**Returns:** Visibility, ranges from 0-1. 0 when none of the area is visible, 1 when all of it is visible.
		
		___
		### Lua Examples
		#### Example 1
		Draws a box when the center of the map is visible on your screen.
		
		```lua 
		local PixVis
		function SetupPixVis()
		    PixVis = util.GetPixelVisibleHandle()
		end
		hook.Add("Initialize", "SetupPixVis", SetupPixVis)
		 
		function TestPixelVisibility()
		    local visible = util.PixelVisible(Vector(0, 0, 0), 16, PixVis)
		 
		    if visible && visible != 0 then
		        draw.RoundedBox( 10, 0, 0, 100, 100, Color(0, 0, 0, 200 * visible) )
		    end
		end
		hook.Add("HUDPaint", "TestPixelVisibility", TestPixelVisibility)
		```
    **/
    
    public static function PixelVisible(position:Vector, radius:Float, PixVis:Pixelvis):Float;
    #end
    
    /**
        Checks if the specified model is valid. 
		
		A model is considered invalid in following cases:
		
		Name | Description
		--- | ---
		`modelName` | Name/Path of the model to check.
		
		
		`**Returns:** Whether the model is valid or not. Returns false clientside if the model is not precached by the server.
    **/
    
    public static function IsValidModel(modelName:String):Bool;
    
    
    /**
        Utility function to quickly generate a trace table that starts at the players view position, and ends 16384 units along a specified direction.
		
		Name | Description
		--- | ---
		`ply` | The player the trace should be based on
		`dir` | The direction of the trace
		
		
		`**Returns:** The trace data. See Trace structure
		
		___
		### Lua Examples
		#### Example 1
		Prints the entity's model the local player is looking at to console
		
		```lua 
		local tr = util.TraceLine( util.GetPlayerTrace( LocalPlayer() ) )
		if IsValid(tr.Entity) then print("I saw a "..tr.Entity:GetModel()) end
		
		local trground = util.TraceLine( util.GetPlayerTrace( LocalPlayer(), Vector(0,0,-1) ) )
		if IsValid(trground.Entity) then print("I'm standing on a "..trground.Entity:GetModel()) end
		```
    **/
    
    public static function GetPlayerTrace(ply:Player, ?dir:Vector):Trace;
    
    
    /**
        Encodes the specified string to base64.
		
		Name | Description
		--- | ---
		`str` | String to encode.
		
		
		`**Returns:** Base 64 encoded string.
    **/
    
    public static function Base64Encode(str:String):String;
    
    #if server
    /**
        Adds the specified string to a string table, which will cache it and network it to all clients automatically. Whenever you want to create a net message with net.Start, you must add the name of that message as a networked string via this function. 
		
		If the passed string already exists, nothing will happen and the ID of the existing item will be returned.
		
		**Note:** Each unique network name needs to be pooled once - do not put this function call into any other functions if you're using a constant string. Preferable place for this function is in a serverside lua file, or in a shared file with the net.Receive function.
		
		**Note:** The string table used for this function does not interfere with the engine string tables and has 2048 slots.
		
		Name | Description
		--- | ---
		`str` | Adds the specified string to the string table.
		
		
		`**Returns:** The id of the string that was added to the string table. Same as calling util. NetworkStringToID.
    **/
    
    public static function AddNetworkString(str:String):Float;
    #end
    
    /**
        Compresses the given string using the LZMA algorithm. 
		
		Use with net.WriteData and net.ReadData for networking and util.Decompress to decompress the data.
		
		Name | Description
		--- | ---
		`str` | String to compress.
		
		
		`**Returns:** The compressed string, or nil if the input string was zero length ("").
    **/
    
    public static function Compress(str:String):String;
    
    
    /**
        Similar to util.KeyValuesToTable but it also preserves order of keys.
		
		Name | Description
		--- | ---
		`keyvals` | The key value string
		`usesEscapeSequences` | If set to true, will replace \t, \n, \" and \\ in the input text with their escaped variants
		`preserveKeyCase` | Whether we should preserve key case or not.
		
		
		`**Returns:** The output table
		
		___
		### Lua Examples
		#### Example 1
		Example usage and output of this function. Note how there are multiple entries where they key is "solid", just like in the input string.
		
		```lua 
		local ModelInfo = util.GetModelInfo("models/combine_gate_vehicle.mdl" )
		PrintTable( util.KeyValuesToTablePreserveOrder( ModelInfo.KeyValues ) )
		```
    **/
    
    public static function KeyValuesToTablePreserveOrder(keyvals:String, ?usesEscapeSequences:Bool, ?preserveKeyCase:Bool):AnyTable;
    
    
    /**
        Sets PData for offline player using his SteamID
		
		**Warning:** This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
		
		Name | Description
		--- | ---
		`steamID` | SteamID of the player
		`name` | Variable name to store the value in
		`value` | The value to store
    **/
    
    public static function SetPData(steamID:String, name:String, value:Dynamic):Void;
    
    
    /**
        Returns the absolute system path the file relative to /garrysmod/.
		
		Name | Description
		--- | ---
		`file` | The file to get the absolute path of.
		
		
		`**Returns:** absolutePath
    **/
    
    public static function RelativePathToFull(file:String):String;
    
    
    /**
        Gets the full material path by the decal name. Used with util.DecalEx.
		
		Name | Description
		--- | ---
		`decalName` | Name of the decal.
		
		
		`**Returns:** Material path of the decal.
    **/
    
    public static function DecalMaterial(decalName:String):String;
    
    
    /**
        Creates an effect with the specified data. 
		
		You can find a list of built-in engine effects here. You can create your own. Example effects can be found here and here.
		
		**Note:** When dispatching an effect from the server, some values may be clamped for networking optimizations. Visit the Set accessors on CEffectData to see which ones are affected.
		
		**Note:** You will need to couple this function with IsFirstTimePredicted should you use this in a predicted hook.
		
		Name | Description
		--- | ---
		`effectName` | The name of the effect to create.
		`effectData` | The effect data describing the effect.
		`allowOverride` | Whether Lua-defined effects should override engine-defined effects with the same name for this/single function call.
		`ignorePredictionOrRecipientFilter` | Can either be a boolean to ignore the prediction filter or a CRecipientFilter. Set this to true if you wish to call this function in multiplayer from server.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a HelicopterMegaBomb effect at the origin of the map. ( 0, 0, 0 )
		
		```lua 
		local vPoint = Vector( 0, 0, 0 )
		local effectdata = EffectData()
		effectdata:SetOrigin( vPoint )
		util.Effect( "HelicopterMegaBomb", effectdata )
		```
    **/
    
    public static function Effect(effectName:String, effectData:CEffectData, ?allowOverride:Bool, ?ignorePredictionOrRecipientFilter:Dynamic):Void;
    
    
    /**
        Performs a trace with the given trace data.
		
		**Note:** Clientside entities will not be hit by traces.
		
		Name | Description
		--- | ---
		`TraceData` | The trace data to use. See Trace structure
		
		
		`**Returns:** Trace result. See TraceResult structure. Can return nil if game. GetWorld or its physics object is invalid. This will be the case for any traces done before GM: InitPostEntity is called.
		
		___
		### Lua Examples
		#### Example 1
		Using a function callback as filter.
		
		```lua 
		local tr = util.TraceLine( {
		    start = LocalPlayer():EyePos(),
		    endpos = LocalPlayer():EyePos() + EyeAngles():Forward() * 10000,
		    filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
		} )
		
		print( tr.HitPos, tr.Entity )
		```
		**Output:**
		
		The trace will only hit prop_physics or world.
    **/
    
    public static function TraceLine(TraceData:Trace):TraceResult;
    
    
    /**
        Checks if the specified model name points to a valid ragdoll.
		
		Name | Description
		--- | ---
		`ragdollName` | Name/Path of the ragdoll model to check.
		
		
		`**Returns:** Returns true if the specified model name points to a valid ragdoll; otherwise false.
    **/
    
    public static function IsValidRagdoll(ragdollName:String):Bool;
    
    
    /**
        Performs a trace with the given origin, direction and filter.
		
		Name | Description
		--- | ---
		`origin` | The origin of the trace.
		`endpos` | The end point of the trace, relative to the start. This is the direction of the trace times the distance of the trace.
		`filter` | Entity which should be ignored by the trace. Can also be a table of entities or a function - see Trace structure.
		
		
		`**Returns:** Trace result. See TraceResult structure.
    **/
    
    public static function QuickTrace(origin:Vector, endpos:Vector, ?filter:Trace):TraceResult;
    
    

}


@:multiReturn extern class UtilLibIntersectRayWithOBBReturn {
var a:Vector;
var b:Vector;
var c:Float;

}
@:multiReturn extern class UtilLibDistanceToLineReturn {
var a:Float;
var b:Vector;
var c:Float;

}

