package gmod.gclass;


/**
    A list of functions available inside a Sandbox Toolgun tool. 
	
	You can find the hooks here and members here.
**/
extern class Tool {
    
    /**
        Returns the owner of this tool.
		
		`**Returns:** Player using the tool
    **/
    
    public function GetOwner():Entity;
    
    
    /**
        Retrieves an local vector previously stored using Tool:SetObject. See also Tool:GetPos.
		
		Name | Description
		--- | ---
		`id` | The id of the object which was set in Tool: SetObject.
		
		
		`**Returns:** Associated local vector with given id.
    **/
    
    public function GetLocalPos(id:Float):Vector;
    
    
    /**
        Returns a language key based on this tool's name and the current stage it is on.
		
		`**Returns:** The returned language key, for example "#tool.weld.1"
    **/
    
    public function GetHelpText():String;
    
    
    /**
        Returns the name of the current tool mode.
		
		`**Returns:** The current tool mode.
		
		___
		### Lua Examples
		#### Example 1
		The Toolgun weapon has a similar function, checking weapon class is strongly recommended as GetMode() is not available on all weapons.
		
		```lua 
		local wep = Entity( 1 ):GetActiveWeapon()
		if ( IsValid( wep ) && wep:GetClass() == "gmod_tool" ) then
		    print( wep:GetMode() )
		end
		```
    **/
    
    public function GetMode():String;
    
    
    /**
        Clears all objects previously set with Tool:SetObject.
    **/
    
    public function ClearObjects():Void;
    
    
    /**
        Retrieves an vector previously stored using Tool:SetObject. See also Tool:GetLocalPos.
		
		Name | Description
		--- | ---
		`id` | The id of the object which was set in Tool: SetObject.
		
		
		`**Returns:** Associated vector with given id. The vector is converted from Tool: GetLocalPos.
    **/
    
    public function GetPos(id:Float):Vector;
    
    
    /**
        Retrieves an PhysObj previously stored using Tool:SetObject. See also Tool:GetEnt.
		
		Name | Description
		--- | ---
		`id` | The id of the object which was set in Tool: SetObject.
		
		
		`**Returns:** Associated PhysObj with given id. If it wasn't specified, returns current PhysObj of associated Entity
    **/
    
    public function GetPhys(id:Float):PhysObj;
    
    
    /**
        Stores an Entity for later use in the tool. 
		
		The stored values can be retrieved by Tool:GetEnt, Tool:GetPos, Tool:GetLocalPos, Tool:GetPhys, Tool:GetBone and Tool:GetNormal
		
		**Note:** this position is in global space and is internally converted to local space relative to the object, so when you retrieve it later it will be corrected to the object's new position
		
		Name | Description
		--- | ---
		`id` | The id of the object to store.
		`ent` | The entity to store.
		`pos` | The position to store. NOTE this position is in global space and is internally converted to local space relative to the object, so when you retrieve it later it will be corrected to the object's new position
		`phys` | The physics object to store.
		`bone` | The hit bone to store.
		`normal` | The hit normal to store.
    **/
    
    public function SetObject(id:Float, ent:Entity, pos:Vector, phys:PhysObj, bone:Float, normal:Vector):Void;
    
    
    /**
        Sets the current operation of the tool. Does nothing clientside. See also Tool:SetStage. 
		
		Operations and stages work as follows:
		
		Name | Description
		--- | ---
		`operation` | The new operation ID to set.
    **/
    
    public function SetOperation(operation:Float):Void;
    
    
    /**
        ***INTERNAL** This is called automatically for all tools.
		
		Initializes the tool object
		
		`**Returns:** The created tool object.
    **/
    @:deprecated("INTERNAL: This is called automatically for all tools.")
    public function Create():Tool;
    
    
    /**
        Removes any ghost entity created for this tool.
    **/
    
    public function ReleaseGhostEntity():Void;
    
    
    /**
        Attempts to grab a clientside tool ConVar.
		
		Name | Description
		--- | ---
		`name` | Name of the convar to retrieve. The function will automatically add the "mytoolfilename_" part to it.
		
		
		`**Returns:** The value of the requested ConVar.
    **/
    
    public function GetClientInfo(name:String):String;
    
    
    /**
        Retrieves an normal vector previously stored using Tool:SetObject.
		
		Name | Description
		--- | ---
		`id` | The id of the object which was set in Tool: SetObject.
		
		
		`**Returns:** Associated normal vector with given id.
    **/
    
    public function GetNormal(id:Float):Vector;
    
    
    /**
        Initializes the ghost entity with the given model. Removes any old ghost entity if called multiple times. 
		
		The ghost is a regular prop_physics entity in singleplayer games, and a clientside prop in multiplayer games.
		
		Name | Description
		--- | ---
		`model` | The model of the new ghost entity
		`pos` | Position to initialize the ghost entity at, usually not needed since this is updated in Tool: UpdateGhostEntity.
		`angle` | Angle to initialize the ghost entity at, usually not needed since this is updated in Tool: UpdateGhostEntity.
    **/
    
    public function MakeGhostEntity(model:String, pos:Vector, angle:Angle):Void;
    
    
    /**
        Retrieves a physics bone number previously stored using Tool:SetObject.
		
		Name | Description
		--- | ---
		`id` | The id of the object which was set in Tool: SetObject.
		
		
		`**Returns:** Associated physics bone with given id.
    **/
    
    public function GetBone(id:Float):Float;
    
    
    /**
        Initializes the ghost entity based on the supplied entity.
		
		Name | Description
		--- | ---
		`ent` | The entity to copy ghost parameters off
    **/
    
    public function StartGhostEntity(ent:Entity):Void;
    
    
    /**
        Attempts to grab a serverside tool ConVar. This will not do anything on client, despite the function being defined shared.
		
		Name | Description
		--- | ---
		`name` | Name of the convar to retrieve. The function will automatically add the "mytoolfilename_" part to it.
		
		
		`**Returns:** The value of the requested ConVar.
    **/
    
    public function GetServerInfo(name:String):String;
    
    
    /**
        ***INTERNAL** Called on deploy automatically
		
		Sets the tool's stage to how many stored objects the tool has.
    **/
    @:deprecated("INTERNAL: Called on deploy automatically")
    public function UpdateData():Void;
    
    
    /**
        ***INTERNAL** This is called automatically for all tools.
		
		Creates clientside ConVars based on the ClientConVar table specified in the tool structure. Also creates the 'toolmode_allow_X' ConVar.
    **/
    @:deprecated("INTERNAL: This is called automatically for all tools.")
    public function CreateConVars():Void;
    
    
    /**
        Sets the current stage of the tool. Does nothing clientside. 
		
		See also Tool:SetOperation.
		
		Name | Description
		--- | ---
		`stage` | The new stage to set.
    **/
    
    public function SetStage(stage:Float):Void;
    
    
    /**
        Returns the amount of stored objects ( Entitys ) the tool has.
		
		`**Returns:** The amount of stored objects, or Tool: GetStage clientide.
    **/
    
    public function NumObjects():Float;
    
    
    /**
        Returns the current stage of the tool set by Tool:SetStage.
		
		`**Returns:** The current stage of the current operation the tool is at.
    **/
    
    public function GetStage():Float;
    
    
    /**
        Checks whether the tool is allowed on the server. This will always return true clientside and will not be affected by SANDBOX:CanTool. 
		
		This function uses TOOL.AllowedCVar which is a ConVar object pointing to toolmode_allow_*toolname* convar.
		
		`**Returns:** Returns true if the tool is allowed.
    **/
    
    public function Allowed():Bool;
    
    
    /**
        Retrieves an Entity previously stored using Tool:SetObject.
		
		Name | Description
		--- | ---
		`id` | The id of the object which was set in Tool: SetObject.
		
		
		`**Returns:** Associated Entity with given id.
    **/
    
    public function GetEnt(id:Float):Entity;
    
    
    /**
        Builds a list of all ConVars set via the ClientConVar variable on the TOOL structure and their default values. This is used for the preset system.
		
		`**Returns:** A list of all convars and their default values.
    **/
    
    public function BuildConVarList():AnyTable;
    
    
    /**
        Updates the position and orientation of the ghost entity based on where the toolgun owner is looking along with data from object with id 1 set by Tool:SetObject. 
		
		This should be called in the tool's TOOL:Think hook. 
		
		 This command is only used for tools that move props, such as easy weld, axis and motor. If you want to update a ghost like the thruster tool does it for example, check its source code.
    **/
    
    public function UpdateGhostEntity():Void;
    
    
    /**
        Attempts to grab a clientside tool ConVar.
		
		Name | Description
		--- | ---
		`name` | Name of the convar to retrieve. The function will automatically add the "mytoolfilename_" part to it.
		`default` | The default value to return in case the lookup fails.
		
		
		`**Returns:** The value of the requested ConVar.
    **/
    
    public function GetClientNumber(name:String, ?_default:Float):Float;
    
    
    /**
        Returns the current operation of the tool set by Tool:SetOperation.
		
		`**Returns:** The current operation the tool is at.
    **/
    
    public function GetOperation():Float;
    
    
    /**
        ***INTERNAL** This is called automatically for most toolgun actions so you shouldn't need to use it.
		
		Checks all added objects to see if they're still valid, if not, clears the list of objects.
    **/
    @:deprecated("INTERNAL: This is called automatically for most toolgun actions so you shouldn't need to use it.")
    public function CheckObjects():Void;
    
    
}



