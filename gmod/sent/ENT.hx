package gmod.sent;

class ENT {
    /**
        Called when the entity is created. This is called when you Entity:Spawn the custom entity. 
		
		This is called after ENTITY:SetupDataTables and GM:OnEntityCreated. 
		
		 
		___
		### Lua Examples
		#### Example 1
		Example Initialize function
		
		```lua 
		function ENT:Initialize()
		    -- Sets what model to use
		    self:SetModel( "models/props/cs_assault/money.mdl" )
		
		    -- Sets what color to use
		    self:SetColor( Color( 200, 255, 200 ) )
		
		    -- Physics stuff
		    self:SetMoveType( MOVETYPE_VPHYSICS )
		    self:SetSolid( SOLID_VPHYSICS )
		
		    -- Init physics only on server, so it doesn't mess up physgun beam
		    if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
		    
		    -- Make prop to fall on spawn
		    local phys = self:GetPhysicsObject()
		    if ( IsValid( phys ) ) then phys:Wake() end
		end
		```
		
		#### Example 2
		Fixes the function not being called clientside.
		
		```lua 
		function SWEP:Initialize()
		    self.m_bInitialized = true
		
		    -- Other code
		end
		
		function SWEP:Think()
		    if (not self.m_bInitialized) then
		        self:Initialize()
		    end
		
		    -- Other code
		end
		```
		
		
    **/
    
    @:hook
	private function Initialize():Void {}
	
	#if server
    /**
        Called when another entity fires an event to this entity. 
		
		
		Name | Description
		--- | ---
		`inputName` | The name of the input that was triggered.
		`activator` | The initial cause for the input getting triggered. (EG the player who pushed a button)
		`caller` | The entity that directly triggered the input. (EG the button that was pushed)
		`data` | The data passed.
		
		
		**Returns:** Should we suppress the default action for this input?
		
		
    **/
    
    @:hook
    private function AcceptInput(inputName:String, activator:Entity, caller:Entity, data:String):Bool {return null;}
	#end
	
	#if server
    /**
        Called when the engine sets a value for this scripted entity. 
		
		See GM:EntityKeyValue for a hook that works for all entities. See WEAPON:KeyValue for a hook that works for scripted weapons. 
		
		 
		Name | Description
		--- | ---
		`key` | The key that was affected.
		`value` | The new value.
		
		
		**Returns:** Return true to suppress this KeyValue or return false or nothing to apply this key value.
		
		
    **/
    
    @:hook
    private function KeyValue(key:String, value:String):Bool {return null;}
	#end
	
	/**
        Called when the entity is reloaded by the lua auto-refresh system, i.e. when the developer edits the lua file for the entity while the game is running. 
		
		
		
    **/
    
    @:hook
	private function OnReloaded():Void {}
	
	/**
        Called when the entity is about to be removed. 
		
		See also Entity:CallOnRemove, which can even be used on engine (non-Lua) entities. 
		
		 
		
    **/
    
    @:hook
	private function OnRemove():Void {}
	
	/**
        Called when the entity is reloaded from a Source Engine save (not the Sandbox saves or dupes) or on a changelevel (for example Half-Life 2 campaign level transitions). 
		
		For the duplicator library callbacks, see ENTITY:OnDuplicated. 
		
		 
		
    **/
    
    @:hook
	private function OnRestore():Void {}
	
	#if server
    /**
        Used to store an output so it can be triggered with ENTITY:TriggerOutput. Outputs compiled into a map are passed to entities as key/value pairs through ENTITY:KeyValue. 
		
		TriggerOutput will do nothing if this function has not been called first. 
		
		 
		Name | Description
		--- | ---
		`name` | Name of output to store
		`info` | Output info
		
		
		___
		### Lua Examples
		#### Example 1
		Stores all outputs that are assigned to an entity in Hammer.
		
		```lua 
		function ENT:KeyValue( k, v )
		    -- 99% of all outputs are named 'OnSomethingHappened'.
		    if ( string.Left( k, 2 ) == "On" ) then
		        self:StoreOutput( k, v )
		    end
		end
		```
		
		
    **/
    
    @:hook
    private function StoreOutput(name:String, info:String):Void {}
	#end
	

    /**
        Called every frame on the client. Called every tick on the server. 
		
		
		**Returns:** Return true if you used Entity: NextThink to override the next execution time.
		
		___
		### Lua Examples
		#### Example 1
		Force the think hook to run at the maximum frequency. This is generally only used for anim entities, if the entity has to play any animations.
		
		```lua 
		ENT.AutomaticFrameAdvance = true -- Must be set on client
		
		function ENT:Think()
		    -- Do stuff
		
		    self:NextThink( CurTime() )
		    return true
		end
		```
		
		
    **/
    
    @:hook
	private function Think():Bool {return null;}
	
	#if server
    /**
        Triggers all outputs stored using ENTITY:StoreOutput. 
		
		
		Name | Description
		--- | ---
		`output` | Name of output to fire
		`activator` | Activator entity
		`data` | The data to give to the output.
		
		
		
    **/
    
    @:hook
    private function TriggerOutput(output:String, activator:Entity, ?data:String):Void {}
	#end
	

    /**
        Called whenever the entity's position changes. A callback for when an entity's angle changes is available via Entity:AddCallback. 
		
		Like ENTITY:RenderOverride, this hook works on any entity (scripted or not) it is applied on. 
		
		 
		Name | Description
		--- | ---
		`pos` | The entity's actual position. May differ from Entity: GetPos
		`ang` | The entity's actual angles. May differ from Entity: GetAngles
		
		
		Name | Description
		--- | ---
		`a` | New position
		`b` | New angles
		
		
		
    **/
    
    @:hook
	private function CalcAbsolutePosition(pos:Vector, ang:Angle):Dynamic {return null;}
	

    /**
        Controls if a property can be used on this entity or not. 
		
		This hook will only work in Sandbox derived gamemodes that do not have SANDBOX:CanProperty overridden. 
		
		 
		Name | Description
		--- | ---
		`ply` | Player, that tried to use the property
		`property` | Class of the property that is tried to use, for example - bonemanipulate
		
		
		**Returns:** Return false to disallow using that property, return true to allow. You must return a value. Not returning anything can cause unexpected results.
		
		
    **/
    
    @:hook
	private function CanProperty(ply:Player, property:String):Bool {return null;}
	

    /**
        Called so the entity can override the bullet impact effects it makes. 
		
		
		Name | Description
		--- | ---
		`tr` | A TraceResult structure from the bullet's start point to the impact point
		`damageType` | The damage type of bullet. See DMG_ Enums
		
		
		**Returns:** Return true to not do the default thing - which is to call UTIL_ImpactTrace in C++
		
		___
		### Lua Examples
		#### Example 1
		Makes the ENT have the AR2 bullet impact effect.
		
		```lua 
		function ENT:DoImpactEffect( tr, nDamageType )
		
		    if ( tr.HitSky ) then return end
		    
		    local effectdata = EffectData()
		    effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
		    effectdata:SetNormal( tr.HitNormal )
		    util.Effect( "AR2Impact", effectdata )
		
		end
		```
		
		
    **/
    
    @:hook
	private function DoImpactEffect(tr:AnyTable, damageType:Float):Bool {return null;}
	
	#if client
    /**
        Called before firing clientside animation events, such as muzzle flashes or shell ejections. 
		
		See ENTITY:HandleAnimEvent for the serverside version. 
		
		 
		Name | Description
		--- | ---
		`pos` | Position of the effect
		`ang` | Angle of the effect
		`event` | The event ID of happened even. See this page.
		`name` | Name of the event
		
		
		**Returns:** Return true to disable the effect
		
		
    **/
    
    @:hook
    private function FireAnimationEvent(pos:Vector, ang:Angle, event:Float, name:String):Bool {return null;}
	#end
	
	#if client
    /**
        Specify a mesh that should be rendered instead of this SENT's model. 
		
		
		**Returns:** A table containing the following keys: IMesh Mesh - Required IMaterial Material - Required VMatrix Matrix - Optional
		
		___
		### Lua Examples
		#### Example 1
		A box that renders nicely with ambient lighting, projected textures, and bumpmaps. Performed in the most lines of code possible.
		
		```lua 
		AddCSLuaFile()
		
		DEFINE_BASECLASS( "base_anim" )
		
		ENT.PrintName = "Other Cube"
		ENT.Spawnable = true
		
		ENT.Mins = Vector( -16, -16, -16 )
		ENT.Maxs = Vector(  16,  16,  16 )
		
		ENT.Material = Material( "hunter/myplastic" )
		
		function ENT:SpawnFunction( ply, tr, ClassName )
		    local ent = ents.Create( ClassName )
		    ent:SetPos( tr.HitPos + tr.HitNormal * 32 )
		    ent:Spawn()
		    return ent
		end
		
		function ENT:Initialize()
		    if CLIENT then
		        self:CreateMesh()
		        self:SetRenderBounds( self.Mins, self.Maxs )
		    end
		
		    self:DrawShadow( false )
		end
		
		function ENT:GetRenderMesh()
		    return { Mesh = self.Mesh, Material = self.Material }
		end
		
		function ENT:CreateMesh()
		    self.Mesh = Mesh()
		
		    local positions = {
		        Vector( -0.5, -0.5, -0.5 ),
		        Vector(  0.5, -0.5, -0.5 ),
		        Vector( -0.5,  0.5, -0.5 ),
		        Vector(  0.5,  0.5, -0.5 ),
		        Vector( -0.5, -0.5,  0.5 ),
		        Vector(  0.5, -0.5,  0.5 ),
		        Vector( -0.5,  0.5,  0.5 ),
		        Vector(  0.5,  0.5,  0.5 ),
		    };
		
		    local indices = {
		        1, 7, 5,
		        1, 3, 7,
		        6, 4, 2,
		        6, 8, 4,
		        1, 6, 2,
		        1, 5, 6,
		        3, 8, 7,
		        3, 4, 8,
		        1, 4, 3,
		        1, 2, 4,
		        5, 8, 6,
		        5, 7, 8,
		    }
		
		    local normals = {
		       Vector( -1,  0,  0 ),
		       Vector(  1,  0,  0 ),
		       Vector(  0, -1,  0 ),
		       Vector(  0,  1,  0 ),
		       Vector(  0,  0, -1 ),
		       Vector(  0,  0,  1 ),
		    }
		
		    local tangents = {
		        { 0, 1, 0, -1 },
		        { 0, 1, 0, -1 },
		        { 0, 0, 1, -1 },
		        { 1, 0, 0, -1 },
		        { 1, 0, 0, -1 },
		        { 0, 1, 0, -1 },
		    }
		
		    local uCoords = {
		       0, 1, 0,
		       0, 1, 1,
		       0, 1, 0,
		       0, 1, 1,
		       0, 1, 0,
		       0, 1, 1,
		       0, 1, 0,
		       0, 1, 1,
		       0, 1, 0,
		       0, 1, 1,
		       0, 1, 0,
		       0, 1, 1,
		    }
		
		    local vCoords = {
		       0, 1, 1,
		       0, 0, 1,
		       0, 1, 1,
		       0, 0, 1,
		       0, 1, 1,
		       0, 0, 1,
		       0, 1, 1,
		       0, 0, 1,
		       0, 1, 1,
		       0, 0, 1,
		       0, 1, 1,
		       0, 0, 1,
		    }
		
		    local verts = {}
		    local scale = self.Maxs - self.Mins
		
		    for vert_i = 1, #indices do
		        local face_i = math.ceil( vert_i / 6 )
		
		        verts[vert_i] = {
		            pos = positions[indices[vert_i]] * scale,
		            normal = normals[face_i],
		            u = uCoords[vert_i],
		            v = vCoords[vert_i],
		            userdata = tangents[face_i]
		        }
		    end
		    
		    self.Mesh:BuildFromTriangles( verts )
		end
		```
		
		
    **/
    
    @:hook
    private function GetRenderMesh():AnyTable {return null;}
	#end
	
	#if server
    /**
        Called by GM:GravGunPickupAllowed on ALL entites in Sandbox-derived gamemodes and acts as an override. 
		
		
		Name | Description
		--- | ---
		`ply` | The player aiming at us
		
		
		**Returns:** Return true to allow the entity to be picked up
		
		
    **/
    
    @:hook
    private function GravGunPickupAllowed(ply:Player):Bool {return null;}
	#end
	
	/**
        Called when this entity is about to be punted with the gravity gun (primary fire). 
		
		Only works in Sandbox derived gamemodes and only if GM:GravGunPunt is not overridden. 
		
		 
		Name | Description
		--- | ---
		`ply` | The player pressing left-click with the gravity gun at an entity
		
		
		**Returns:** Return true or false to enable or disable punting respectively.
		
		___
		### Lua Examples
		#### Example 1
		Enables a scripted entity to be punted even when frozen.
		
		```lua 
		function ENT:GravGunPunt( ply )
		    self:GetPhysicsObject():EnableMotion( true )
		    return true
		end
		```
		
		
    **/
    
    @:hook
	private function GravGunPunt(ply:Player):Bool {return null;}
	
	#if server
    /**
        Called before firing serverside animation events, such as weapon reload, drawing and holstering for NPCs, scripted sequences, etc. 
		
		See ENTITY:FireAnimationEvent for the clientside version. 
		
		 
		Name | Description
		--- | ---
		`event` | The event ID of happened even. See this page.
		`eventTime` | The absolute time this event occurred using CurTime.
		`cycle` | The frame this event occurred as a number between 0 and 1.
		`type` | Event type. See the Source SDK.
		`options` | Name or options of this event.
		
		
		
    **/
    
    @:hook
    private function HandleAnimEvent(event:Float, eventTime:Float, cycle:Float, type:Float, options:String):Void {}
	#end
	
	#if server
    /**
        Called when deciding if the Scripted NPC should be able to perform a certain jump or not. 
		
		
		Name | Description
		--- | ---
		`startPos` | Start of the jump
		`apex` | Apex point of the jump
		`endPos` | The landing position
		
		
		**Returns:** Return true if this jump should be allowed to be performed, false otherwise. Not returning anything, or returning a non boolean will perform the default action.
		
		
    **/
    
    @:hook
    private function IsJumpLegal(startPos:Vector, apex:Vector, endPos:Vector):Bool {return null;}
	#end
	
	#if server
    /**
        Called on any entity after it has been created by the duplicator library and before any bone/entity modifiers have been applied. 
		
		This hook is called after ENTITY:Initialize and before ENTITY:PostEntityPaste. 
		
		 
		Name | Description
		--- | ---
		`entTable` | EntityCopyData structure of the source entity.
		
		
		
    **/
    
    @:hook
    private function OnDuplicated(entTable:AnyTable):Void {}
	#end
	
	#if server
    /**
        Called after duplicator finishes saving the entity, allowing you to modify the save data. 
		
		This is called after ENTITY:PostEntityCopy. 
		
		 
		Name | Description
		--- | ---
		`data` | The save EntityCopyData structure that you can modify.
		
		
		___
		### Lua Examples
		#### Example 1
		Prevent this entity from being copied and subsequently pasted.
		
		```lua 
		function ENT:OnEntityCopyTableFinish( data )
		    for k, v in pairs( data ) do data[ k ] = nil end
		end
		```
		
		
    **/
    
    @:hook
    private function OnEntityCopyTableFinish(data:AnyTable):Void {}
	#end
	
	#if server
    /**
        Called after the duplicator library pastes the entity, after the bone/entity modifiers have been applied to the entity. 
		
		This hook is called after ENTITY:OnDuplicated. 
		
		 
		Name | Description
		--- | ---
		`ply` | The player who pasted the entity. WARNING This may not be a valid player in some circumstances. For example, when a save is loaded from the main menu, this hook will be called before the player is spawned. This argument will be a NULL entity in that case. BUG This will be nil for invalid players. Pull Request: #1408
		`ent` | The entity itself. Same as 'self'.
		`createdEntities` | All entities that are within the placed dupe. NOTE The keys of each value in this table are the original entity indexes when the duplication was created. This can be utilized to restore entity references that don't get saved in duplications.
		
		
		
    **/
    
    @:hook
    private function PostEntityPaste(ply:Player, ent:Entity, createdEntities:AnyTable):Void {}
	#end
	
	#if server
    /**
        Called before the duplicator copies the entity. 
		
		If you are looking for a way to make the duplicator spawn another entity when duplicated. ( For example, you duplicate a "prop_physics", but you want the duplicator to spawn "prop_physics_my" ), you should add prop_physics.ClassOverride = "prop_physics_my". The duplication table should be also stored on that prop_physics, not on prop_physics_my. 
		
		 
		___
		### Lua Examples
		#### Example 1
		Example on how to store values for duplicator, and then restore them afterwards
		
		```lua 
		-- Store the value for duplicator
		function ENT:PreEntityCopy()
		    self.MyDuplicatorVariasble = self:GetSequence()
		end
		
		-- Restore the saved value
		function ENT:PostEntityPaste()
		    -- Always validate data before using it
		    if ( !self.MyDuplicatorVariasble ) then return end
		
		    self:ResetSequence( self.MyDuplicatorVariasble )
		end
		```
		
		
    **/
    
    @:hook
    private function PreEntityCopy():Void {}
	#end
	
	#if client
    /**
        Called instead of the engine drawing function of the entity. This hook works on any entity (scripted or not) it is applied on. 
		
		This does not work on "physgun_beam", use GM:DrawPhysgunBeam instead. 
		
		 
		___
		### Lua Examples
		#### Example 1
		Set the entity the player is looking at to not draw if the player is its owner.
		
		```lua 
		local function DontDrawMe( self )
		    if ( self:GetOwner() == LocalPlayer() ) then
		        return
		    end
		    
		    self:DrawModel()
		end
		
		local pickent = LocalPlayer():GetEyeTrace().Entity
		
		if ( IsValid( pickent ) ) then
		    pickent.RenderOverride = DontDrawMe
		end
		```
		
		
    **/
    
    @:hook
    private function RenderOverride():Void {}
	#end

	
    /**
        Toggles automatic frame advancing for animated sequences on an entity. 
		
		This has the same effect as setting the ENT.AutomaticFrameAdvance property. 
		
		 
		Name | Description
		--- | ---
		`enable` | Whether or not to set automatic frame advancing.
		
		
		
    **/
    
    @:hook
	private function SetAutomaticFrameAdvance(enable:Bool):Void {}
	
	/**
        Called when the entity should set up its Data Tables. 
		
		This is a much better option than using Set/Get Networked Values. 
		
		 This hook is called after GM:OnEntityCreated and GM:NetworkEntityCreated. 
		
		 
		___
		### Lua Examples
		#### Example 1
		Sets up networked variables, adds functions SetAmount, GetAmount, GetBloodPos, SetBloodPos, GetUrinePos, SetUrinePos.This function only supports 64 data tables per type (#0-63), except for strings which only supports 4.
		
		```lua 
		function ENT:SetupDataTables()
		
		    self:NetworkVar( "Float", 0, "Amount" )
		    self:NetworkVar( "Vector", 0, "BloodPos" )
		    self:NetworkVar( "Vector", 1, "UrinePos" )
		
		    if SERVER then
		        self:SetAmount( 3 )
		        self:SetBloodPos( Vector( 0, -32, 0 ) )
		        self:SetUrinePos( Vector( 0, 0, -16 ) )
		    end
		
		end
		```
		
		
    **/
    
    @:hook
	private function SetupDataTables():Void {}
	
}
@:multiReturn extern class EntCalcAbsolutePositionReturn {
	var a:Vector;
	var b:Angle;
	
}