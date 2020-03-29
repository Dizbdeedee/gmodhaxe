package gmod.gclass;


/**
    This is a list of all available methods for entites, which includes Players, Weapons, NPCs and Vehicles.
**/
extern class Entity {
    #if server
    /**
        When called on a constraint entity, sets the two physics objects to be constrained. 
		
		Usage is not recommended as the Constraint library provides easier ways to deal with constraints.
		
		Name | Description
		--- | ---
		`Phys1` | The first physics object to be constrained.
		`Phys2` | The second physics object to be constrained.
		
		
		___
		### Lua Examples
		#### Example 1
		From constraint.lua
		
		```lua 
		Constraint = ents.Create("phys_lengthconstraint")
		    Constraint:SetPos( WPos1 )
		    Constraint:SetKeyValue( "attachpoint", tostring(WPos2) )
		    Constraint:SetKeyValue( "minlength", "0.0" )
		    Constraint:SetKeyValue( "length", length + addlength )
		    if ( forcelimit ) then Constraint:SetKeyValue( "forcelimit", forcelimit ) end
		    if ( rigid ) then Constraint:SetKeyValue( "spawnflags", 2 ) end
		    Constraint:SetPhysConstraintObjects( Phys1, Phys2 )
		Constraint:Spawn()
		Constraint:Activate()
		```
    **/
    
    public function SetPhysConstraintObjects(Phys1:PhysObj, Phys2:PhysObj):Void;
    #end
    
    /**
        ***Deprecated:** You should use Entity: SetNWInt instead.
		
		Sets a networked integer value at specified index on the entity. 
		
		The value then can be accessed with Entity:GetNetworkedInt both from client and server.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
    **/
    @:deprecated("You should use Entity: SetNWInt instead.")
    public function SetNetworkedInt(key:String, ?value:Float):Void;
    
    
    /**
        Returns an integer that represents how deep in water the entity is.
		
		`**Returns:** The water level.
    **/
    
    public function WaterLevel():Float;
    
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Returns an entity stored in the datatable of the entity.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 63. Specifies what key to grab from datatable.
		
		
		`**Returns:** Requested entity.
    **/
    @:deprecated("INTERNAL")
    public function GetDTEntity(key:Float):Entity;
    
    
    /**
        Returns name of given pose parameter
		
		Name | Description
		--- | ---
		`id` | Id of the pose paremeter
		
		
		`**Returns:** Name of given pose parameter
    **/
    
    public function GetPoseParameterName(id:Float):String;
    
    
    /**
        Returns the owner entity of this entity. See Entity:SetOwner for more info.
		
		`**Returns:** The owner entity of this entity.
    **/
    
    public function GetOwner():Entity;
    
    
    /**
        Returns the last trace used in the collision callbacks such as ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch.
		
		**Note:** This returns the last collision trace used, regardless of the entity that caused it. As such, it's only reliable when used in the hooks mentioned above
		
		`**Returns:** The TraceResult structure
		
		___
		### Lua Examples
		#### Example 1
		Dispatches an explosion at the point of impact with another entity.
		
		```lua 
		function ENT:Touch( otherEntity )
		    local tr = self:GetTouchTrace()
		    local hitPos = tr.HitPos
		
		    local effectdata = EffectData()
		    effectdata:SetOrigin( hitPos )
		    util.Effect( "Explosion", effectdata )
		
		end
		```
    **/
    
    public function GetTouchTrace():TraceResult;
    
    
    /**
        Removes the entity it is used on.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		ents.FindByClass( "prop_physics" )[1]:Remove()
		```
		**Output:**
		
		Removes whichever prop is first found or errors if no entity was found.
    **/
    
    public function Remove():Void;
    
    
    /**
        Returns name of given bone id.
		
		Name | Description
		--- | ---
		`index` | ID of bone to lookup name of
		
		
		`**Returns:** The name of given bone nil in case we failed or entity doesn't have a model "__INVALIDBONE__" in case the name cannot be read or the index is out of range.
		
		___
		### Lua Examples
		#### Example 1
		Will print name of bone name with id 0 for first player.
		
		```lua 
		print( Entity( 1 ):GetBoneName( 0 ) )
		```
		**Output:**
		
		ValveBiped.Bip01_Pelvis
		
		#### Example 2
		Prints all the bones of an entity.
		
		```lua 
		function PrintBones(ent)
		    for i=0, ent:GetBoneCount()-1 do
		        print(i,ent:GetBoneName(i))
		    end
		end
		```
    **/
    
    public function GetBoneName(index:Float):String;
    
    
    /**
        Returns the entity's base velocity which is their velocity due to forces applied by other entities. This includes entity-on-entity collision or riding a treadmill.
		
		`**Returns:** The base velocity of the entity.
    **/
    
    public function GetBaseVelocity():Vector;
    
    
    /**
        Returns current render FX of the entity.
		
		`**Returns:** The current render FX of the entity. See kRenderFx_ Enums
    **/
    
    public function GetRenderFX():KRenderFx;
    
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Get a boolean stored in the datatable of the entity.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 63. Specifies what key to grab from datatable.
		
		
		`**Returns:** Requested boolean.
    **/
    @:deprecated("INTERNAL")
    public function GetDTBool(key:Float):Bool;
    
    #if client
    /**
        Moves the model instance from the source entity to this entity. This can be used to transfer decals that have been applied on one entity to another. 
		
		Both entities must have the same model.
		
		Name | Description
		--- | ---
		`srcEntity` | Entity to move the model instance from.
		
		
		`**Returns:** Whether the operation was successful or not
    **/
    
    public function SnatchModelInstance(srcEntity:Entity):Bool;
    #end
    
    /**
        Sets whether or not the given entity is persistent. A persistent entity will be saved on server shutdown and loaded back when the server starts up. Additionally, by default persistent entities cannot be grabbed with the physgun and tools cannot be used on them. 
		
		In sandbox, this can be set on an entity by opening the context menu, right clicking the entity, and choosing "Make Persistent".
		
		**Note:** Persistence can only be enabled with the sbox_persist convar, which works as an identifier for the current set of persistent entities. An empty identifier (which is the default value) disables this feature.
		
		Name | Description
		--- | ---
		`persist` | Whether or not the entity should be persistent.
    **/
    
    public function SetPersistent(persist:Bool):Void;
    
    #if server
    /**
        Prevents the server from sending any further information about the entity to a player.
		
		**Bug:** BUG This does not work for nextbots. Issue Tracker: #1736
		
		Name | Description
		--- | ---
		`player` | The player to stop networking the entity to.
		`stopTransmitting` | true to stop the entity from networking, false to make it network again.
    **/
    
    public function SetPreventTransmit(player:Player, stopTransmitting:Bool):Void;
    #end
    
    /**
        Returns whether the entity is on ground or not. 
		
		Internally, this checks if FL_ONGROUND is set on the entity. 
		
		 This function is an alias of Entity:OnGround.
		
		`**Returns:** Whether the entity is on ground or not.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( Entity( 1 ):IsOnGround() )
		print( IsValid( Entity( 1 ):GetGroundEntity() ) ) -- This should give the exact output as the first line
		```
		**Output:**
		
		Outputs 'true' to the console if the player 1 is on ground.
    **/
    
    public function IsOnGround():Bool;
    
    
    /**
        Returns the surface property of the specified bone.
		
		Name | Description
		--- | ---
		`bone` | The bone id. See Entity: LookupBone.
		
		
		`**Returns:** The surface property of the bone to be used with util. GetSurfaceIndex or an empty string on failure.
    **/
    
    public function GetBoneSurfaceProp(bone:Float):String;
    
    
    /**
        Returns the max health that the entity was given. It can be set via Entity:SetMaxHealth.
		
		`**Returns:** Max health.
		
		___
		### Lua Examples
		#### Example 1
		Prints the maximum health set for player 1.
		
		```lua 
		print( Entity( 1 ):GetMaxHealth() )
		```
		**Output:**
		
		By default, 100.
    **/
    
    public function GetMaxHealth():Float;
    
    
    /**
        Returns the entity's velocity.
		
		**Note:** Actually binds to CBaseEntity::GetAbsVelocity() on the server and C_BaseEntity::EstimateAbsVelocity() on the client. This returns the total velocity of the entity and is equal to local velocity + base velocity.
		
		**Bug:** BUG This can become out-of-sync on the client if the server has been up for a long time. Issue Tracker: #774
		
		`**Returns:** The velocity of the entity.
    **/
    
    public function GetVelocity():Vector;
    
    
    /**
        Sets the position an entity's eyes look toward.
		
		Name | Description
		--- | ---
		`pos` | The world position the entity is looking toward.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes an NPC (self) look into a nearby player's eyes.
		
		```lua 
		for p, ply in pairs(player.GetAll()) do
		    if(ply:EyePos():Distance(self:EyePos()) <= 60) then
		        self:SetEyeTarget(ply:EyePos())
		        break
		    end
		end
		```
		
		#### Example 2
		Makes an entity look at a vector the way the eyeposer does it
		
		```lua 
		local lookat = Vector( 0, 0, 0 )
		
		local attachment = ent:GetAttachment( ent:LookupAttachment( "eyes" ) )
		local LocalPos, LocalAng = WorldToLocal( lookat, Angle( 0, 0, 0 ), attachment.Pos, attachment.Ang )
		ent:SetEyeTarget( LocalPos )
		```
    **/
    
    public function SetEyeTarget(pos:Vector):Void;
    
    #if server
    /**
        Activates the entity, as if a player pressed the Use key (Default E) on it.
		
		Name | Description
		--- | ---
		`activator` | The player who is using the entity
		`caller` | This should be the same as activator. This is supposed to be the entity that is acting as a proxy for the player (eg a button), but due to confusion over the difference between activator and caller, third party code may expect caller to be the activator and vice versa. Therefore, the only safe thing to do is to set both arguments to be the player.
		`useType` | The type of use to trigger. See USE_ Enums
		`integer` | You can usually set this to 1.
    **/
    
    public function Use(activator:Player, caller:Entity, useType:USE, integer:Float):Void;
    #end
    
    /**
        Gets the selected entity's model scale.
		
		`**Returns:** Scale of that entity's model.
		
		___
		### Lua Examples
		#### Example 1
		This example shows how one can get the model scale of their self.
		
		```lua 
		lua_run_cl print(LocalPlayer():GetModelScale())
		```
		**Output:**
		
		1
    **/
    
    public function GetModelScale():Float;
    
    #if server
    /**
        Returns the duration of given layer.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		
		
		`**Returns:** The duration of the layer
    **/
    
    public function GetLayerDuration(layerID:Float):Float;
    #end
    
    /**
        Returns the matrix (position / rotation transform) of a given bone entity.
		
		**Bug:** BUG This can return the server's matrix during server lag. Issue Tracker: #884
		
		**Bug:** BUG This can return garbage serverside or a 0,0,0 fourth column (represents position) for v49 models. Issue Tracker: #3285
		
		Name | Description
		--- | ---
		`boneID` | The bone to retrieve matrix of. Bones clientside and serverside will differ
		
		
		`**Returns:** The matrix Some entities don't update animation every frame such as prop_physics and won't have accurate bone matrix.
    **/
    
    public function GetBoneMatrix(boneID:Float):VMatrix;
    
    #if server
    /**
        Returns true if the entity is being held by a player. Either by physics gun, gravity gun or use-key (+use).
		
		**Bug:** BUG If multiple players are holding an object and one drops it, this will return false despite the object still being held. Issue Tracker: #2046
		
		`**Returns:** IsBeingHeld
    **/
    
    public function IsPlayerHolding():Bool;
    #end
    #if server
    /**
        Returns the amount a momentary_rot_button entity is turned based on the given angle. 0 meaning completely turned closed, 1 meaning completely turned open.
		
		**Warning:** This only works on momentary_rot_button entities.
		
		Name | Description
		--- | ---
		`turnAngle` | The angle of rotation to compare - usually should be Entity: GetAngles.
		
		
		`**Returns:** The amount the momentary_rot_button is turned, ranging from 0 to 1, or nil if the entity is not a momentary_rot_button.
    **/
    
    public function GetMomentaryRotButtonPos(turnAngle:Angle):Float;
    #end
    
    /**
        Returns whether the entity is dormant or not. Client/server entities become dormant when they leave the PVS on the server. Client side entities can decide for themselves whether to become dormant. This mainly applies to PVS.
		
		`**Returns:** Whether the entity is dormant or not.
    **/
    
    public function IsDormant():Bool;
    
    
    /**
        Sets the entity's move type. This should be called before initializing the physics object on the entity, unless it will override SetMoveType such as Entity:PhysicsInitBox. 
		
		Despite existing on client, it doesn't actually do anything on client.
		
		Name | Description
		--- | ---
		`movetype` | The new movetype, see MOVETYPE_ Enums
    **/
    
    public function SetMoveType(movetype:MOVETYPE):Void;
    
    
    /**
        Returns the number of pose parameters this entity has.
		
		`**Returns:** Amount of pose parameters the entity has
		
		___
		### Lua Examples
		#### Example 1
		Prints all the entities poses.The entity used to generate the output is a model of the combine helicopter.
		
		```lua 
		for i=0, ent:GetNumPoseParameters() - 1 do
		    local min, max = ent:GetPoseParameterRange( i )
		    print( ent:GetPoseParameterName( i ) .. ' ' .. min .. " / " .. max )
		end
		```
		**Output:**
		
		weapon_pitch -90 / 20 weapon_yaw -40 / 40 rudder -45 / 45
    **/
    
    public function GetNumPoseParameters():Float;
    
    
    /**
        Sets the entity's velocity. For entities with physics, consider using PhysObj:SetVelocity on the PhysObj of the entity.
		
		**Warning:** If applied to a player, this will actually ADD velocity, not set it.
		
		**Note:** Actually binds to CBaseEntity::SetBaseVelocity() which sets the entity's velocity due to forces applied by other entities.
		
		Name | Description
		--- | ---
		`velocity` | The new velocity to set.
    **/
    
    public function SetVelocity(velocity:Vector):Void;
    
    
    /**
        Sets custom bone angles.
		
		**Note:** The repeated use of bone manipulation in multiplayer games is highly discouraged due to the huge produced network traffic.
		
		Name | Description
		--- | ---
		`boneID` | Index of the bone you want to manipulate
		`ang` | Angle to apply. The angle is relative to the original bone angle, not relative to the world or the entity.
		
		
		___
		### Lua Examples
		#### Example 1
		This example shows the network usage impact of repeatedly using bone manipulation serverside.To see the difference, type in client's console: net_graph 3The rotation is not smooth when using Entity:SetNWFloat() because it does not update the value on every frame.
		
		```lua 
		local server_only = true -- Change the value!
		
		if server_only then
		    if SERVER then
		        hook.Add( "Think", "bone_manipulation_test", function()
		            for _,ent in ipairs( ents.FindByModel( "models/buggy.mdl" ) ) do
		                ent:ManipulateBoneAngles( 28, Angle( 0,0,RealTime()*180 ) )
		            end
		        end )
		    else
		        hook.Add( "Think", "bone_manipulation_test", function()
		        end )
		    end
		else
		    if SERVER then
		        hook.Add( "Think", "bone_manipulation_test", function()
		            for _,ent in ipairs( ents.FindByModel( "models/buggy.mdl" ) ) do
		                ent:SetNWFloat( "bone_manipulation_test", RealTime()*180 ) -- Entity:SetNW....() do not broadcast new values instantly
		            end
		        end )
		    else
		        hook.Add( "Think", "bone_manipulation_test", function()
		            for _,ent in ipairs( ents.GetAll() ) do
		                if ent:GetModel() == "models/buggy.mdl" then
		                    ent:ManipulateBoneAngles( 28, Angle( 0,0,ent:GetNWFloat( "bone_manipulation_test" ) ) )
		                end
		            end
		        end )
		    end
		end
		```
		**Output:**
		
		Rotation of the ammo box of all HL2 buggies.
    **/
    
    public function ManipulateBoneAngles(boneID:Float, ang:Angle):Void;
    
    #if server
    /**
        Normalizes the ragdoll. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
    **/
    
    public function RagdollSolve():Void;
    #end
    #if client
    /**
        Gets networked angles for entity.
		
		`**Returns:** angle
    **/
    
    public function GetNetworkAngles():Angle;
    #end
    #if server
    /**
        Returns if the entity is unfreezable, meaning it can't be frozen with the physgun. By default props are freezable, so this function will typically return false.
		
		**Bug:** BUG This will return nil if Entity:SetUnFreezable has not been called. Pull Request: #1488
		
		`**Returns:** True if the entity is unfreezable, false otherwise.
    **/
    
    public function GetUnFreezable():Bool;
    #end
    
    /**
        Manipulates the bone's jiggle status. This allows non jiggly bones to become jiggly.
		
		Name | Description
		--- | ---
		`boneID` | Index of the bone you want to manipulate.
		`enabled` | 0 = No Jiggle 1 = Jiggle
		
		
		___
		### Lua Examples
		#### Example 1
		Turn everyone into jelly mode
		
		```lua 
		for k, v in pairs(player.GetAll()) do
		    local i = 0
		
		    while i < v:GetBoneCount() do
		        v:ManipulateBoneJiggle(i, 1)
		        i = i + 1
		    end
		end
		```
    **/
    
    public function ManipulateBoneJiggle(boneID:Float, enabled:Float):Void;
    
    
    /**
        Sets the entity's angular velocity (rotation speed).
		
		Name | Description
		--- | ---
		`angVel` | The angular velocity to set.
    **/
    
    public function SetLocalAngularVelocity(angVel:Angle):Void;
    
    
    /**
        Returns the flex scale of the entity.
		
		`**Returns:** The flex scale
    **/
    
    public function GetFlexScale():Float;
    
    
    /**
        Returns a list of all sequences ( animations ) the model has.
		
		`**Returns:** The list of all sequences ( animations ) the model has. The indices start with 0!
		
		___
		### Lua Examples
		#### Example 1
		Example showing table structure. Prints a list of player model sequences.
		
		```lua 
		PrintTable( Entity(1):GetSequenceList() )
		```
		**Output:**
		
		0	=	ragdoll
		1	=	reference
		2	=	idle_all_01
		3	=	idle_all_02
		4	=	idle_all_angry
		5	=	idle_all_scared
		6	=	idle_all_cower
		7	=	cidle_all
		8	=	swim_idle_all
		9	=	sit
		10	=	menu_walk
		11	=	menu_combine
		12	=	menu_gman
		13	=	walk_all
		-- The rest of the sequences
    **/
    
    public function GetSequenceList():AnyTable;
    
    
    /**
        Returns the amount of sequences ( animations ) the entity's model has.
		
		`**Returns:** The amount of sequences ( animations ) the entity's model has.
    **/
    
    public function GetSequenceCount():Float;
    
    
    /**
        Sets the model of the entity.
		
		**Warning:** This silently fails when given an empty string.
		
		Name | Description
		--- | ---
		`modelName` | New model value.
    **/
    
    public function SetModel(modelName:String):Void;
    
    
    /**
        ***Deprecated:** You should be using Entity: GetNWVarTable instead.
		
		Returns all the networked variables in an entity.
		
		`**Returns:** Key-Value table of all networked variables.
		
		___
		### Lua Examples
		#### Example 1
		Prints all NWVars that exist for Player 1.
		
		```lua 
		PrintTable( Entity(1):GetNWVarTable() )
		```
		**Output:**
		
		UserGroup	=	owner
    **/
    @:deprecated("You should be using Entity: GetNWVarTable instead.")
    public function GetNetworkedVarTable():AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Sets the specified entity on this entity's datatable.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 31.
		`ent` | The entity to write on this entity's datatable.
    **/
    @:deprecated("INTERNAL")
    public function SetDTEntity(key:Float, ent:Entity):Void;
    
    
    /**
        ***INTERNAL** 
		
		Sets up a self.dt.NAME alias for a Data Table variable.
		
		**Warning:** You should use Entity:NetworkVar instead
		
		Name | Description
		--- | ---
		`Type` | The type of the DTVar being set up. It can be one of the following: 'Int', 'Float', 'Vector', 'Angle', 'Bool', 'Entity' or 'String'
		`ID` | The ID of the DTVar. Can be between 0 and 3 for strings, 0 and 31 for everything else.
		`Name` | Name by which you will refer to DTVar. It must be a valid variable name. (No spaces!)
		
		
		___
		### Lua Examples
		#### Example 1
		Sets up two float networked variables, TargetZ and Speed
		
		```lua 
		function ENT:SetupDataTables()
		
		    self:DTVar( "Float", 0, "TargetZ" )
		    self:DTVar( "Float", 1, "Speed" )
		
		end
		```
    **/
    @:deprecated("INTERNAL")
    public function DTVar(Type:String, ID:Float, Name:String):Void;
    
    #if server
    /**
        Sets the creator of the SENT.
		
		Name | Description
		--- | ---
		`ply` | The creator
    **/
    
    public function SetCreator(ply:Player):Void;
    #end
    
    /**
        Returns a table containing all attachments of the given entitys model. Returns an empty table or nil in case it's model has no attachments.
		
		**Bug:** BUG This can have inconsistent results in single-player. Issue Tracker: #3167
		
		`**Returns:** Attachment data. See AttachmentData structure.
		
		___
		### Lua Examples
		#### Example 1
		All the attachments present on the Kliener player model
		
		```lua 
		PrintTable(LocalPlayer():GetAttachments())
		```
		**Output:**
		
		1: id = 1 name = eyes 2: id = 2 name = lefteye 3: id = 3 name = righteye 4: id = 4 name = nose 5: id = 5 name = mouth 6: id = 6 name = tie 7: id = 7 name = pen 8: id = 8 name = chest 9: id = 9 name = hips 10: id = 10 name = lefthand 11: id = 11 name = righthand 12: id = 12 name = forward 13: id = 13 name = anim_attachment_RH 14: id = 14 name = anim_attachment_LH 15: id = 15 name = anim_attachment_head
    **/
    
    public function GetAttachments():AttachmentData;
    
    
    /**
        Gets networked origin for entity.
		
		`**Returns:** origin
    **/
    
    public function GetNetworkOrigin():Vector;
    
    
    /**
        Returns if the entity is the map's Entity[0] worldspawn
		
		`**Returns:** isWorld
		
		___
		### Lua Examples
		#### Example 1
		Stool boilerplate for the ignite tool
		
		```lua 
		function TOOL:LeftClick( trace )
		 local ent = trace.Entity
		 if !ent or !ent:IsValid() or ent:IsPlayer() or ent:IsWorld() then return false end
		 ...
		```
		**Output:**
		
		LeftClick will not run for no ent, invalid ents, players, or worldspawn.
    **/
    
    public function IsWorld():Bool;
    
    
    /**
        Returns the entity's model bounds. This is different than the collision bounds/hull. This is not scaled with Entity:SetModelScale, and will return the model's original, unmodified mins and maxs.
		
		Name | Description
		--- | ---
		`a` | The minimum vector of the bounds
		`b` | The maximum vector of the bounds
    **/
    
    public function GetModelBounds():EntityGetModelBoundsReturn;
    
    
    /**
        Gets the bone index of the given bone name, returns nothing if the bone does not exist.
		
		Name | Description
		--- | ---
		`boneName` | The name of the bone. Common generic bones ( for player models and some HL2 models ): ValveBiped.Bip01_Head1 ValveBiped.Bip01_Spine ValveBiped.Anim_Attachment_RH Common hand bones (left hand equivalents also available, replace _R_ with _L_) ValveBiped.Bip01_R_Hand ValveBiped.Bip01_R_Forearm ValveBiped.Bip01_R_Foot ValveBiped.Bip01_R_Thigh ValveBiped.Bip01_R_Calf ValveBiped.Bip01_R_Shoulder ValveBiped.Bip01_R_Elbow
		
		
		`**Returns:** Index of the given bone name
    **/
    
    public function LookupBone(boneName:String):Float;
    
    #if client
    /**
        Enables the use of clipping planes to "cut" objects.
		
		Name | Description
		--- | ---
		`enabled` | Enable or disable clipping planes
    **/
    
    public function SetRenderClipPlaneEnabled(enabled:Bool):Void;
    #end
    
    /**
        Sets the activity of the entity's active weapon.
		
		**Note:** This does nothing on the client.
		
		**Note:** Only works for CBaseCombatCharacter entities, which includes players and NPCs.
		
		Name | Description
		--- | ---
		`act` | Activity number. See ACT_ Enums.
		`duration` | How long the animation should take in seconds.
    **/
    
    public function Weapon_SetActivity(act:ACT, duration:Float):Void;
    
    
    /**
        Sets the skin of the entity.
		
		Name | Description
		--- | ---
		`skinIndex` | 0-based index of the skin to use.
    **/
    
    public function SetSkin(skinIndex:Float):Void;
    
    
    /**
        Searches for bodygroup with given name.
		
		Name | Description
		--- | ---
		`name` | The bodygroup name to search for.
		
		
		`**Returns:** Bodygroup ID, -1 if not found
    **/
    
    public function FindBodygroupByName(name:String):Float;
    
    #if client
    /**
        Returns render bounds of the entity. Can be overridden by Entity:SetRenderBounds. 
		
		If the render bounds are not inside players view, the entity will not be drawn!
		
		Name | Description
		--- | ---
		`a` | The minimum vector of the bounds
		`b` | The maximum vector of the bounds.
    **/
    
    public function GetRenderBounds():EntityGetRenderBoundsReturn;
    #end
    #if server
    /**
        Returns the current weight of the layer. See Entity:SetLayerWeight for more information.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		
		
		`**Returns:** The current weight of the layer
    **/
    
    public function GetLayerWeight(layerID:Float):Float;
    #end
    
    /**
        Checks if given flag is set or not.
		
		Name | Description
		--- | ---
		`flag` | The engine flag to test, see EFL_ Enums
		
		
		`**Returns:** Is set or not
    **/
    
    public function IsEFlagSet(flag:EFL):Bool;
    
    #if server
    /**
        Returns whether the given layer ID is valid and exists on this entity.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		
		
		`**Returns:** Whether the given layer ID is valid and exists on this entity.
    **/
    
    public function IsValidLayer(layerID:Float):Bool;
    #end
    
    /**
        Returns the contents of the specified bone.
		
		Name | Description
		--- | ---
		`bone` | The bone id. See Entity: LookupBone.
		
		
		`**Returns:** The contents as a CONTENTS_ Enums or 0 on failure.
    **/
    
    public function GetBoneContents(bone:Float):CONTENTS;
    
    
    /**
        Returns entity's position relative to it's parent.
		
		`**Returns:** Relative position
    **/
    
    public function GetLocalPos():Vector;
    
    
    /**
        Gets the angles of given entity.
		
		**Bug:** BUG This returns incorrect results for the local player clientside. Issue Tracker: #2764
		
		**Bug:** BUG This will return the local player's EyeAngles in rendering hooks. Issue Tracker: #3106
		
		**Bug:** BUG This will return Angle(0,0,0) in rendering hooks while paused in single-player. Issue Tracker: #3107
		
		`**Returns:** The angles of the entity.
		
		___
		### Lua Examples
		#### Example 1
		Prints the 1st player's angles.
		
		```lua 
		print( player.GetByID(1):GetAngles() )
		```
		**Output:**
		
		Something like "0.000 34.529 0.000" in console.
    **/
    
    public function GetAngles():Angle;
    
    
    /**
        Returns the delta movement and angles of a sequence of the entity's model.
		
		Name | Description
		--- | ---
		`sequenceId` | The sequence index. See Entity: GetSequenceName.
		`startCycle` | The sequence start cycle. 0 is the start of the animation, 1 is the end.
		`endCyclnde` | The sequence end cycle. 0 is the start of the animation, 1 is the end. Values like 2, etc are allowed.
		
		
		Name | Description
		--- | ---
		`a` | Whether the operation was successful
		`b` | The delta vector of the animation, how much the model's origin point moved.
		`c` | The delta angle of the animation.
    **/
    
    public function GetSequenceMovement(sequenceId:Float, startCycle:Float, endCyclnde:Float):EntityGetSequenceMovementReturn;
    
    #if server
    /**
        Toggles the constraints of this ragdoll entity on and off.
		
		Name | Description
		--- | ---
		`toggleConstraints` | Set to true to enable the constraints and false to disable them. Disabling constraints will delete the constraint entities.
    **/
    
    public function EnableConstraints(toggleConstraints:Bool):Void;
    #end
    #if client
    /**
        Stops all particle effects parented to the entity with given name.
		
		Name | Description
		--- | ---
		`name` | The name of the particle to stop.
    **/
    
    public function StopParticlesNamed(name:String):Void;
    #end
    #if client
    /**
        Set the origin in which the Entity will be drawn from.
		
		Name | Description
		--- | ---
		`newOrigin` | The new origin in world coordinates where the Entity's model will now be rendered from.
    **/
    
    public function SetRenderOrigin(newOrigin:Vector):Void;
    #end
    
    /**
        Sets the progress of the current animation to a specific value between 0 and 1.
		
		**Bug:** BUG This does not work with viewmodels. Issue Tracker: #3038
		
		Name | Description
		--- | ---
		`value` | The desired cycle value
		
		
		___
		### Lua Examples
		#### Example 1
		Set the entity to be half way through its current sequence
		
		```lua 
		ent:SetCycle( .5 )
		```
    **/
    
    public function SetCycle(value:Float):Void;
    
    #if server
    /**
        Changes an entities angles so that it faces the target entity.
		
		Name | Description
		--- | ---
		`target` | The entity to face.
    **/
    
    public function PointAtEntity(target:Entity):Void;
    #end
    #if server
    /**
        
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`blendOut` | 
    **/
    
    public function SetLayerBlendOut(layerID:Float, blendOut:Float):Void;
    #end
    
    /**
        Returns if the entity is solid or not. Very useful for determining if the entity is a trigger or not.
		
		`**Returns:** Whether the entity is solid or not.
    **/
    
    public function IsSolid():Bool;
    
    
    /**
        ***Deprecated:** You should use Entity: GetNWEntity instead.
		
		Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworkedEntity.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. ( If it isn't set )
		
		
		`**Returns:** The retrieved value
    **/
    @:deprecated("You should use Entity: GetNWEntity instead.")
    public function GetNetworkedEntity(key:String, ?fallback:Entity):Entity;
    
    
    /**
        Sets the flex weight.
		
		Name | Description
		--- | ---
		`flex` | The ID of the flex to modify weight of
		`weight` | The new weight to set
    **/
    
    public function SetFlexWeight(flex:Float, weight:Float):Void;
    
    
    /**
        Sets whether or not the entity should make a physics contact sound when it's been picked up by a player.
		
		Name | Description
		--- | ---
		`playsound` | True to play the pickup sound, false otherwise.
		
		
		___
		### Lua Examples
		#### Example 1
		Enable pickup sound on all entities.
		
		```lua 
		function GM:OnEntityCreated(ent)
		    ent:SetShouldPlayPickupSound(true)
		end
		```
    **/
    
    public function SetShouldPlayPickupSound(?playsound:Bool):Void;
    
    
    /**
        Sets custom bone scale.
		
		**Warning:** When used serverside, this method produces a huge network consumption!
		
		**Bug:** BUG This does not scale procedural bones. Issue Tracker: #3502
		
		**Bug:** BUG The vector will be normalised if its longer than 32 units. Issue Tracker: #1249
		
		Name | Description
		--- | ---
		`boneID` | Index of the bone you want to manipulate
		`scale` | Scale vector to apply. Note that the scale is relative to the original bone scale, not relative to the world or the entity. BUG The vector will be normalised if its longer than 32 units. Issue Tracker: #1249
    **/
    
    public function ManipulateBoneScale(boneID:Float, scale:Vector):Void;
    
    #if server
    /**
        Sets the mapping name of the entity.
		
		Name | Description
		--- | ---
		`mappingName` | The name to set for the entity.
    **/
    
    public function SetName(mappingName:String):Void;
    #end
    
    /**
        Sets a save value for an entity.
		
		Name | Description
		--- | ---
		`name` | Name of the save value to set
		`value` | Value to set
		
		
		`**Returns:** Key successfully set
		
		___
		### Lua Examples
		#### Example 1
		Make all rollermines currently on the map friendly
		
		```lua 
		for k, v in pairs( ents.FindByClass( "npc_rollermine" ) ) do
		    v:SetSaveValue( "m_bHackedByAlyx", true )
		end
		```
    **/
    
    public function SetSaveValue(name:String, value:Dynamic):Bool;
    
    #if client
    /**
        Returns the render group of the entity.
		
		`**Returns:** The render group. See RENDERGROUP_ Enums
    **/
    
    public function GetRenderGroup():RENDERGROUP;
    #end
    
    /**
        Retrieves a networked integer (whole number) value that was previously set by Entity:SetNWInt.
		
		**Bug:** BUG This function will not round decimal values as it actually networks a float internally. Issue Tracker: #3374
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value (If it isn't set).
		
		
		`**Returns:** The value associated with the key
    **/
    
    public function GetNWInt(key:String, ?fallback:Dynamic):Dynamic;
    
    
    /**
        Sets a networked integer (whole number) value on the entity. 
		
		The value can then be accessed with Entity:GetNWInt both from client and server. 
		
		 See Entity:SetNWFloat for numbers that aren't integers.
		
		**Note:** Running this function clientside will only set it for the client it is called on.
		
		**Bug:** BUG This function will not round decimal values as it actually networks a float internally. Issue Tracker: #3374
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
		
		
		___
		### Lua Examples
		#### Example 1
		This will set the networked integer 'money' on all clients to 100.
		
		```lua 
		for k, v in ipairs( player.GetAll() ) do
		    v:SetNWInt( 'money', 100 )
		end
		```
    **/
    
    public function SetNWInt(key:String, value:Float):Void;
    
    
    /**
        Marks the entity to call GM:ShouldCollide.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable the custom collision check
    **/
    
    public function SetCustomCollisionCheck(enable:Bool):Void;
    
    #if client
    /**
        Stops all particle effects parented to the entity and immediately destroys them.
    **/
    
    public function StopAndDestroyParticles():Void;
    #end
    #if server
    /**
        Returns entity's map creation ID. Unlike Entity:EntIndex or Entity:GetCreationID, it will always be the same on same map, no matter how much you clean up or restart it. 
		
		To be used in conjunction with ents.GetMapCreatedEntity.
		
		`**Returns:** The map creation ID or -1 if the entity is not compiled into the map.
    **/
    
    public function MapCreationID():Float;
    #end
    #if server
    /**
        Restarts the entity's animation gesture. If the given gesture is already playing, it will reset it and play it from the beginning.
		
		**Note:** This function only works on BaseAnimatingOverlay entites.
		
		Name | Description
		--- | ---
		`activity` | The activity number to send to the entity. See ACT_ Enums and Entity: GetSequenceActivity
		`addIfMissing` | Add/start the gesture to if it has not been yet started.
		`autokill` | 
    **/
    
    public function RestartGesture(activity:ACT, ?addIfMissing:Bool, ?autokill:Bool):Void;
    #end
    #if client
    /**
        Sets the next time the clientside ENTITY:Think is called.
		
		Name | Description
		--- | ---
		`nextthink` | The next time, relative to CurTime, to execute the ENTITY: Think clientside.
    **/
    
    public function SetNextClientThink(nextthink:Float):Void;
    #end
    
    /**
        ***Deprecated:** You should use Entity: GetNWAngle instead.
		
		Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNetworkedAngle.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. ( If it isn't set )
		
		
		`**Returns:** The retrieved value
    **/
    @:deprecated("You should use Entity: GetNWAngle instead.")
    public function GetNetworkedAngle(key:String, ?fallback:Angle):Angle;
    
    
    /**
        Checks if the entity is a weapon or not.
		
		`**Returns:** Whether the entity is a weapon
    **/
    
    public function IsWeapon():Bool;
    
    #if server
    /**
        Returns the mapping name of this entity.
		
		`**Returns:** The name of the Entity
    **/
    
    public function GetName():String;
    #end
    
    /**
        Returns current weight ( value ) of the flex.
		
		Name | Description
		--- | ---
		`flex` | The ID of the flex to get weight of
		
		
		`**Returns:** The current weight of the flex
    **/
    
    public function GetFlexWeight(flex:Float):Float;
    
    
    /**
        Returns the position and angle of the entity as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a rotation matrix, and the fourth column stores the position vector.
		
		**Bug:** BUG This returns incorrect results for the angular component (columns 1-3) for the local player clientside. Issue Tracker: #2764
		
		**Bug:** BUG This will use the local player's EyeAngles in rendering hooks. Issue Tracker: #3106
		
		**Bug:** BUG Columns 1-3 will be all 0 (angular component) in rendering hooks while paused in single-player. Issue Tracker: #3107
		
		`**Returns:** The position and angle matrix.
    **/
    
    public function GetWorldTransformMatrix():VMatrix;
    
    #if server
    /**
        Returns the entity that is being used as the light origin position for this entity.
		
		`**Returns:** The lighting entity. This will usually be NULL.
    **/
    
    public function GetLightingOriginEntity():Entity;
    #end
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Sets the specified integer on the entity's datatable.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 31.
		`integer` | The integer to write on the entity's datatable. This will be cast to a 32-bit signed integer internally.
    **/
    @:deprecated("INTERNAL")
    public function SetDTInt(key:Float, integer:Float):Void;
    
    
    /**
        Adds flags to the entity.
		
		Name | Description
		--- | ---
		`flag` | Flag to add, see FL_ Enums
    **/
    
    public function AddFlags(flag:FL):Void;
    
    
    /**
        Returns the ID of a PhysObj attached to the given bone. To be used with Entity:GetPhysicsObjectNum. 
		
		See Entity:TranslatePhysBoneToBone for reverse function.
		
		**Bug:** BUG This does not work on clientside-only entities. Issue Tracker: #3714
		
		Name | Description
		--- | ---
		`boneID` | The ID of a bone to look up the "physics root" bone of.
		
		
		`**Returns:** The PhysObj ID of the given bone. -1 if we somehow cannot translate
    **/
    
    public function TranslateBoneToPhysBone(boneID:Float):Float;
    
    #if client
    /**
        Sets the Level Of Detail model to use with this entity. This may not work for all models if the model doesn't include any LOD sub models. 
		
		This function works exactly like the clientside r_lod convar and takes priority over it.
		
		Name | Description
		--- | ---
		`lod` | The Level Of Detail model ID to use. -1 leaves the engine to automatically set the Level of Detail. The Level Of Detail may range from 0 to 8, with 0 being the highest quality and 8 the lowest.
    **/
    
    public function SetLOD(?lod:Float):Void;
    #end
    
    /**
        Creates a callback that will execute when the given network variable changes - that is, when the Set<name> function is run.
		
		**Warning:** A clientside NetworkVarNotify will not be called when the network var is changed serverside! This makes the function less useful. This is a bug. [1]
		
		**Note:** The callback is executed before the value is changed, and is called even if the new and old values are the same.
		
		**Note:** This function does not exist on entities in which Entity:InstallDataTable has not been called. By default, this means this function only exists on SENTs (both serverside and clientside) and on players with a Player Class (serverside and clientside LocalPlayer only!). It is therefore safest to only use this in ENTITY:SetupDataTables.
		
		Name | Description
		--- | ---
		`name` | Name of variable to track changes of
		`callback` | The function to call when the variable changes. It is passed 4 arugments: Entity entity - Entity whos variable changed (This will be variable called "self" in ENT:CallBack format.) string name - Name of changed variable any old - Old/current variable value any new - New variable value that it was set to
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		function ENT:SetupDataTables()
		
		    self:NetworkVar( "Float", 0, "Amount" )
		    self:NetworkVar( "Vector", 1, "StartPos" )
		    self:NetworkVar( "Vector", 2, "EndPos" )
		
		    if ( SERVER ) then
		        self:NetworkVarNotify( "EndPos", self.OnVarChanged )
		    end
		
		end
		
		function ENT:OnVarChanged( name, old, new )
		    print( name, old, new )
		end
		```
		**Output:**
		
		Prints variable name, old value and new value whenever SetEndPos function is called
    **/
    
    public function NetworkVarNotify(name:String, callback:Function):Void;
    
    #if client
    /**
        Refreshes the shadow of the entity.
    **/
    
    public function MarkShadowAsDirty():Void;
    #end
    #if server
    /**
        Returns the surface material of this entity.
		
		`**Returns:** Surface material. See MAT_ Enums
		
		___
		### Lua Examples
		#### Example 1
		Prints the MAT_ enum name for every prop on the map.
		
		```lua 
		local function BackwardsEnums( enumname ) -- Helper function to build our table of values.
		    local backenums = {}
		
		    for k, v in pairs( _G ) do
		        if type( k ) == "string" and string.find( k, "^"..enumname ) then
		            backenums[ v ] = k
		        end
		    end
		
		    return backenums
		end
		
		local MAT = BackwardsEnums( "MAT_" )
		
		local validclasses = { prop_physics = true, prop_physics_multiplayer = true, prop_dynamic = true }
		for k, v in pairs( ents.GetAll() ) do
		    if validclasses[ v:GetClass() ] then
		        print( v:GetModel(), MAT[ v:GetMaterialType() ] or "UNKNOWN" )
		    end
		end
		```
    **/
    
    public function GetMaterialType():MAT;
    #end
    
    /**
        Returns the position and angle of the given attachment, relative to the world.
		
		**Bug:** BUG This can return the server's position during server lag. Issue Tracker: #884
		
		**Bug:** BUG This can return garbage serverside or Vector(0,0,0) for v49 models. Issue Tracker: #3285
		
		**Bug:** BUG This can return garbage if a trace passed through the target bone during bone matrix access. Issue Tracker: #3739
		
		Name | Description
		--- | ---
		`boneIndex` | The bone index of the bone to get the position of. See Entity: LookupBone.
		
		
		Name | Description
		--- | ---
		`a` | The bone's position relative to the world.
		`b` | The bone's angle relative to the world.
    **/
    
    public function GetBonePosition(boneIndex:Float):EntityGetBonePositionReturn;
    
    #if server
    /**
        Precaches gibs for the entity's model. 
		
		Normally this function should be ran when the entity is spawned, for example the ENTITY:Initialize, after Entity:SetModel is called. 
		
		 This is required for Entity:GibBreakServer and Entity:GibBreakClient to work.
    **/
    
    public function PrecacheGibs():Void;
    #end
    
    /**
        Sets the parent of an entity to another entity with the given physics bone number. Similar to Entity:SetParent, except it is parented to a physbone. This function is useful mainly for ragdolls.
		
		**Note:** Despite this function being available server side, it doesn't actually do anything server side.
		
		Name | Description
		--- | ---
		`bone` | Physics bone number to attach to. Use 0 for objects with only one physics bone. (See Entity: GetPhysicsObjectNum)
    **/
    
    public function SetParentPhysNum(bone:Float):Void;
    
    
    /**
        Returns the amount of skins the entity has.
		
		`**Returns:** The amount of skins the entity's model has.
    **/
    
    public function SkinCount():Float;
    
    
    /**
        Turns the Entity:GetPhysicsObject into a physics shadow. It's used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane. 
		
		A physics shadow can be used to have static entities that never move by setting both arguments to false.
		
		**Note:** Unlike Entity:PhysicsInitShadow, this function doesn't remove the current physics object.
		
		Name | Description
		--- | ---
		`allowPhysicsMovement` | Whether to allow the physics shadow to move under stress.
		`allowPhysicsRotation` | Whether to allow the physics shadow to rotate under stress.
    **/
    
    public function MakePhysicsObjectAShadow(allowPhysicsMovement:Bool, allowPhysicsRotation:Bool):Void;
    
    
    /**
        ***INTERNAL** 
		
		Sets up Data Tables from entity to use with [Entity](https://wiki.garrysmod.com/page/Category:Entity): [NetworkVar](https://wiki.garrysmod.com/page/Entity/NetworkVar).
    **/
    @:deprecated("INTERNAL")
    public function InstallDataTable():Void;
    
    
    /**
        Sets the rendering material override of the entity. 
		
		To set a Lua material created with CreateMaterial, just prepend a "!" to the material name.
		
		**Note:** If you wish to override a single material on the model, use Entity:SetSubMaterial instead.
		
		**Note:** Please note that to apply materials to models, that material must have VertexLitGeneric shader. For that reason you cannot apply map textures onto models, map textures use a different material shader - LightmappedGeneric.
		
		**Bug:** BUG The server's value takes priority on the client. Issue Tracker: #3362
		
		Name | Description
		--- | ---
		`materialName` | New material name. Use an empty string ( "") to reset to the default materials.
		`forceMaterial` | Use it if you wish to apply material other than VertexLitGeneric (such as tools/toolswhite).
    **/
    
    public function SetMaterial(materialName:String, ?forceMaterial:Bool):Void;
    
    
    /**
        Returns the contents of the entity's current model.
		
		`**Returns:** The contents of the entity's model. See CONTENTS_ Enums.
    **/
    
    public function GetModelContents():CONTENTS;
    
    
    /**
        Returns the entity's movetype
		
		`**Returns:** Move type. See MOVETYPE_ Enums
    **/
    
    public function GetMoveType():MOVETYPE;
    
    
    /**
        Returns all materials of the entity's model. 
		
		This function is unaffected by Entity:SetSubMaterial as it returns the original materials.
		
		**Bug:** BUG The server's values take priority on the client. Issue Tracker: #3362
		
		**Bug:** BUG The table returned by this function will not contain materials if they are missing from the disk/repository. This means that if you are attempting to find the ID of a material to replace with Entity:SetSubMaterial and there are missing materials on the model, all subsequent materials will be offset in the table, meaning that the ID you are trying to get will be incorrect.
		
		**Bug:** BUG This table is limited to 127 materials, even if the entity has more. Issue Tracker: #3216
		
		`**Returns:** A table containing full paths to the materials of the model. BUG This table is limited to 127 materials, even if the entity has more. Issue Tracker: #3216
    **/
    
    public function GetMaterials():AnyTable;
    
    #if server
    /**
        Returns player who is claiming kills of physics damage the entity deals.
		
		**Note:** Some entities such as the Combine Ball disregard the time limit and always return the physics attacker.
		
		Name | Description
		--- | ---
		`timeLimit` | The time to check if the entity was still a proper physics attacker. NOTE Some entities such as the Combine Ball disregard the time limit and always return the physics attacker.
		
		
		`**Returns:** The player. If entity that was set is not a player, it will return NULL entity.
    **/
    
    public function GetPhysicsAttacker(timeLimit:Float):Player;
    #end
    
    /**
        Returns the rightward vector of the entity, as a normalized direction vector
		
		`**Returns:** rightDir
    **/
    
    public function GetRight():Vector;
    
    
    /**
        Plays a sound on an entity. If run clientside, the sound will only be heard locally. 
		
		If used on a player or NPC character with the mouth rigged, the character will "lip-sync". This does not work with all sound files. 
		
		 It is recommended to use sound scripts ( see sound.Add ) over direct file paths. This will allow you to use Entity:StopSound to stop the played sound scripts.
		
		**Warning:** The string will cannot have whitespace at the start or end. You can remove this with string.Trim.
		
		**Note:** When using this function with weapons, use the Weapon itself as the entity, not its owner!
		
		**Bug:** BUG This does not respond to SuppressHostEvents. Issue Tracker: #2651
		
		Name | Description
		--- | ---
		`soundName` | The name of the sound to be played. WARNING The string will cannot have whitespace at the start or end. You can remove this with string.Trim.
		`soundLevel` | A modifier for the distance this sound will reach, acceptable range is 0 to 511. 100 means no adjustment to the level. See SNDLVL_ Enums Will not work if a sound script is used.
		`pitchPercent` | The pitch applied to the sound. The acceptable range is from 0 to 255. 100 means the pitch is not changed.
		`volume` | The volume, from 0 to 1.
		`channel` | The sound channel, see CHAN_ Enums. Will not work if a sound script is used.
		
		
		___
		### Lua Examples
		#### Example 1
		Plays sound from the first player on the server.
		
		```lua 
		Entity(1):EmitSound( "path/to/sound.wav", 75, 100, 1, CHAN_AUTO ) -- Same as below
		Entity(1):EmitSound( "path/to/sound.wav" ) -- You can remove the arguments that have default values.
		```
    **/
    
    public function EmitSound(soundName:String, ?soundLevel:SNDLVL, ?pitchPercent:Float, ?volume:Float, ?channel:CHAN):Void;
    
    #if server
    /**
        Makes the entity play a .vcd scene.
		
		Name | Description
		--- | ---
		`scene` | Filepath to scene
		`delay` | Delay in seconds until the scene starts playing.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes the entity that the player 1 is looking at play the "Welcome to City 17" speech.
		
		```lua 
		local ent = Entity( 1 ):GetEyeTrace().Entity
		
		if( IsValid( ent ) ) then
		    npc:PlayScene( "scenes/breencast/welcome.vcd" )
		end
		```
		**Output:**
		
		The entity plays the scene.
    **/
    
    public function PlayScene(scene:String, ?delay:Float):Void;
    #end
    
    /**
        ***Deprecated:** You should be using Entity: SetNWVarProxy instead.
		
		Sets callback function to be called when given NWVar changes.
		
		**Note:** Currently this function only works for the NW2Var system (accessed by adding a 2 in between Networked and Var for most NetworkedVar functions), which will replace the original one at some point in the future
		
		Name | Description
		--- | ---
		`name` | The name of the NWVar to add callback for.
		`callback` | The function to be called when the NWVar changes.
    **/
    @:deprecated("You should be using Entity: SetNWVarProxy instead.")
    public function SetNetworkedVarProxy(name:String, callback:Function):Void;
    
    
    /**
        Returns the movement parent of this entity. 
		
		See Entity:SetMoveParent for more info.
		
		`**Returns:** The movement parent of this entity.
    **/
    
    public function GetMoveParent():Entity;
    
    
    /**
        Changes the table that can be accessed by indexing an entity. Each entity starts with its own table by default.
		
		Name | Description
		--- | ---
		`tab` | Table for the entity to use
    **/
    
    public function SetTable(tab:AnyTable):Void;
    
    
    /**
        Returns the center of an entity's bounding box as a local vector.
		
		`**Returns:** OBBCenter
    **/
    
    public function OBBCenter():Vector;
    
    
    /**
        Sets custom bone offsets.
		
		Name | Description
		--- | ---
		`boneID` | Index of the bone you want to manipulate
		`pos` | Position vector to apply Note that the position is relative to the original bone position, not relative to the world or the entity.
    **/
    
    public function ManipulateBonePosition(boneID:Float, pos:Vector):Void;
    
    
    /**
        Return the name of the sequence for the index provided. Refer to Entity:GetSequence to find the current active sequence on this entity.
		
		Name | Description
		--- | ---
		`index` | The index of the sequence to look up.
		
		
		`**Returns:** Name of the sequence.
    **/
    
    public function GetSequenceName(index:Float):String;
    
    
    /**
        Returns if the entity's rendering and transmitting has been disabled.
		
		**Note:** This is equivalent to calling Entity:IsEffectActive( EF_NODRAW )
		
		`**Returns:** Whether the entity's rendering and transmitting has been disabled.
    **/
    
    public function GetNoDraw():Bool;
    
    
    /**
        Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNWBool.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. (If it isn't set)
		
		
		`**Returns:** The value associated with the key
    **/
    
    public function GetNWBool(key:String, ?fallback:Dynamic):Dynamic;
    
    
    /**
        Sets the bodygroups from a string. A convenience function for Entity:SetBodygroup.
		
		Name | Description
		--- | ---
		`bodygroups` | Body groups to set. Each single-digit number in the string represents a separate bodygroup. This make it impossible to set any bodygroup to a value higher than 9! For that you need to use Entity: SetBodygroup.
		
		
		___
		### Lua Examples
		#### Example 1
		Example of the format
		
		```lua 
		Entity(1):SetBodyGroups( "021" )
		```
		**Output:**
		
		Sets first bodygroup value to 0, second to 2 and third to 1.
    **/
    
    public function SetBodyGroups(bodygroups:String):Void;
    
    
    /**
        Returns the amount of bones in the entity.
		
		**Note:** Will return -1 for ClientsideModel or undrawn entities until Entity:SetupBones is called on the entity.
		
		`**Returns:** The amount of bones in given entity; -1 on failure.
		
		___
		### Lua Examples
		#### Example 1
		Prints amount of bones in player 1
		
		```lua 
		print( Entity(1):GetBoneCount() )
		```
		**Output:**
		
		The amount of bones in player 1, which normally would be 68.
    **/
    
    public function GetBoneCount():Float;
    
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Get an angle stored in the datatable of the entity.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 63. Specifies what key to grab from datatable.
		
		
		`**Returns:** Requested angle.
    **/
    @:deprecated("INTERNAL")
    public function GetDTAngle(key:Float):Angle;
    
    #if server
    /**
        Returns whether there's a gesture is given activity being played.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`activity` | The activity to test. See ACT_ Enums.
		
		
		`**Returns:** Whether there's a gesture is given activity being played.
    **/
    
    public function IsPlayingGesture(activity:ACT):Bool;
    #end
    
    /**
        Returns the center of the entity according to its collision model.
		
		`**Returns:** The center of the entity
    **/
    
    public function WorldSpaceCenter():Vector;
    
    
    /**
        Returns a specific physics object from an entity with multiple PhysObjects (like ragdolls) 
		
		See also Entity:TranslateBoneToPhysBone.
		
		Name | Description
		--- | ---
		`physNum` | The number corresponding to the PhysObj to grab. Starts at 0.
		
		
		`**Returns:** The physics object
		
		___
		### Lua Examples
		#### Example 1
		When run, if the player is dead it will throw their ragdoll up in the air by their head.
		
		```lua 
		if ( !LocalPlayer():Alive() && LocalPlayer():GetRagdollEntity() ) then
		    local ent = LocalPlayer():GetRagdollEntity()
		    local head = ent:GetPhysicsObjectNum( 10 ) // 10 is usually the bone number of the head.
		    head:ApplyForceCenter( Vector( 0, 0, 6000 ) )
		end
		```
		
		#### Example 2
		Example function that applies force to all physics objects of given entity.
		
		```lua 
		function ApplySomeForce( ent )
		    for i = 0, ent:GetPhysicsObjectCount() - 1 do
		        local phys = ent:GetPhysicsObjectNum( i )
		        phys:ApplyForceCenter( Vector( 0, 0, 10000 ) )
		    end
		end
		```
    **/
    
    public function GetPhysicsObjectNum(physNum:Float):PhysObj;
    
    #if server
    /**
        Removes and stops the gesture with given activity.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`activity` | The activity remove. See ACT_ Enums.
    **/
    
    public function RemoveGesture(activity:ACT):Void;
    #end
    
    /**
        Makes the physics object of the entity a sphere.
		
		**Note:** This function will automatically destroy any previous physics objects and call Entity:SetSolid( SOLID_BBOX ) and Entity:SetMoveType( MOVETYPE_VPHYSICS ).
		
		**Bug:** BUG Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
		
		Name | Description
		--- | ---
		`radius` | The radius of the sphere.
		`physmat` | Physical material from surfaceproperties.txt or added with physenv. AddSurfaceData.
		
		
		`**Returns:** Returns true on success, false otherwise
    **/
    
    public function PhysicsInitSphere(radius:Float, physmat:String):Bool;
    
    
    /**
        Returns the position of an Player/NPC's view.
		
		`**Returns:** View position of the entity.
    **/
    
    public function EyePos():Vector;
    
    
    /**
        Returns entity's current hit box set
		
		Name | Description
		--- | ---
		`a` | The current hit box set id, or no value if the entity doesn't have hit boxes
		`b` | The current hit box set name, or no value if the entity doesn't have hit boxes
    **/
    
    public function GetHitboxSet():EntityGetHitboxSetReturn;
    
    
    /**
        Allows you to set how fast an entity's animation will play, with 1.0 being the default speed.
		
		Name | Description
		--- | ---
		`fSpeed` | How fast the animation will play.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes Entity(1)'s viewmodel play animations 50% slower.
		
		```lua 
		Entity(1):GetViewModel():SetPlaybackRate(0.5)
		```
		**Output:**
		
		Entity(1)'s viewmodel now plays animations 50% slower.
    **/
    
    public function SetPlaybackRate(fSpeed:Float):Void;
    
    
    /**
        Sets the owner of this entity, disabling all physics interaction with it.
		
		**Note:** This function is generally used to disable physics interactions on projectiles being fired by their owner, but can also be used for normal ownership in case physics interactions are not involved at all. The Gravity gun will be able to pick up the entity even if the owner can't collide with it
		
		Name | Description
		--- | ---
		`owner` | The entity to be set as owner.
		
		
		___
		### Lua Examples
		#### Example 1
		Taken from Garry's Flechette gun , shoots a hunter's flechette and sets the owner of the flechette to the player using the weapon.
		
		```lua 
		function SWEP:PrimaryAttack()
		    self:SetNextPrimaryFire( CurTime() + 0.1 )
		    
		    if (!SERVER) then return end
		
		    local Forward = self.Owner:EyeAngles():Forward()
		
		    local ent = ents.Create( "hunter_flechette" )
		    
		    if ( IsValid( ent ) ) then
		
		        ent:SetPos( self.Owner:GetShootPos() + Forward * 32 )
		        ent:SetAngles( self.Owner:EyeAngles() )
		        ent:Spawn()
		        ent:SetVelocity( Forward * 2000 )
		        ent:SetOwner( self.Owner )
		    end
		end
		```
    **/
    
    public function SetOwner(?owner:Entity):Void;
    
    
    /**
        Gets the position of entity in world.
		
		`**Returns:** The position of the entity.
		
		___
		### Lua Examples
		#### Example 1
		Utility command that would give you the position of the entity you are looking at.
		
		```lua 
		concommand.Add( "entity_pos", function( ply )
		    local tr = ply:GetEyeTrace()
		    if ( IsValid( tr.Entity ) ) then
		        print( "Entity position:", tr.Entity:GetPos() )
		    else
		        print( "Crosshair position:", tr.HitPos )
		    end
		end )
		```
    **/
    
    public function GetPos():Vector;
    
    
    /**
        ***Deprecated:** You should be using Entity: GetNWVarProxy instead.
		
		Returns callback function for given NWVar of this entity.
		
		**Note:** Currently this function only works for the NW2Var system (accessed by adding a 2 in between Networked and Var for most NetworkedVar functions), which will replace the original one at some point in the future
		
		Name | Description
		--- | ---
		`name` | The name of the NWVar to get callback of.
		
		
		`**Returns:** The callback of given NWVar, if any.
		
		___
		### Lua Examples
		#### Example 1
		Prints callback function of a NWVar called "Key" of Player 1.
		
		```lua 
		print( Entity(1):GetNetworkedVarProxy( "Key" ) )
		Entity(1):SetNetworkedVarProxy( "Key", print )
		print( Entity(1):GetNetworkedVarProxy( "Key" ) )
		```
    **/
    @:deprecated("You should be using Entity: GetNWVarProxy instead.")
    public function GetNetworkedVarProxy(name:String):Function;
    
    #if client
    /**
        Sets the render angles of the Entity.
		
		Name | Description
		--- | ---
		`newAngles` | The new render angles to be set to.
    **/
    
    public function SetRenderAngles(newAngles:Angle):Void;
    #end
    
    /**
        Returns the rotation of the entity relative to its parent entity.
		
		`**Returns:** Relative angle
    **/
    
    public function GetLocalAngles():Angle;
    
    
    /**
        Returns sequence ID from its name.
		
		Name | Description
		--- | ---
		`name` | Sequence name
		
		
		Name | Description
		--- | ---
		`a` | Sequence ID for that name. This will differ for models with same sequence names. Will be -1 whether the sequence is invalid.
		`b` | The sequence duration 0 if the sequence is invalid
    **/
    
    public function LookupSequence(name:String):EntityLookupSequenceReturn;
    
    
    /**
        Returns whether or not the bone manipulation functions have ever been called on given entity. 
		
		Related functions are Entity:ManipulateBonePosition, Entity:ManipulateBoneAngles, Entity:ManipulateBoneJiggle, and Entity:ManipulateBoneScale.
		
		**Bug:** BUG This will return true if the entity's bones have ever been manipulated. Resetting the position/angles/jiggle/scaling to 0,0,0 will not affect this function. Issue Tracker: #3131
		
		`**Returns:** True if the entity has been bone manipulated, false otherwise.
    **/
    
    public function HasBoneManipulations():Bool;
    
    
    /**
        Gets the unique entity index of an entity.
		
		**Note:** Entity indices are marked as unused after deletion, and can be reused by newly-created entities
		
		`**Returns:** The index of the entity. -1 for clientside-only or serverside-only entities.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( player.GetAll()[1]:EntIndex() )
		```
		**Output:**
		
		1
    **/
    
    public function EntIndex():Int;
    
    
    /**
        Removes a callback previously added with Entity:AddCallback
		
		Name | Description
		--- | ---
		`hook` | The hook name to remove. See Entity Callbacks
		`callbackid` | The callback id previously retrieved with the return of Entity: AddCallback or Entity: GetCallbacks
    **/
    
    public function RemoveCallback(hook:String, callbackid:Float):Void;
    
    #if server
    /**
        Returns whether the entity was created by map or not.
		
		`**Returns:** Is created by map?
    **/
    
    public function CreatedByMap():Bool;
    #end
    
    /**
        Allows to quickly set variable to entity's Entity:GetTable.
		
		**Note:** This will not network the variable to client(s). You want Entity:SetNWString and similar functions for that
		
		Name | Description
		--- | ---
		`key` | Key of the value to set
		`value` | Value to set the variable to
    **/
    
    public function SetVar(key:Dynamic, value:Dynamic):Void;
    
    
    /**
        Sets a networked boolean value on the entity. 
		
		The value can then be accessed with Entity:GetNWBool both from client and server.
		
		**Note:** Running this function clientside will only set it for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
		
		
		___
		### Lua Examples
		#### Example 1
		Sets a networked boolean with a key of "VIP" and a value of true on a player.
		
		```lua 
		player:SetNWBool( "VIP", true )
		print( player:GetNWBool( "VIP" ) )
		```
		**Output:**
		
		true
    **/
    
    public function SetNWBool(key:String, value:Bool):Void;
    
    
    /**
        Initializes the physics object of the entity using its current model. Deletes the previous physics object if it existed and the new object creation was successful. 
		
		If the entity's current model has no physics mesh associated to it, no physics object will be created and the previous object will still exist, if applicable.
		
		**Note:** When called clientside, this will not create a valid PhysObj if the model hasn't been precached serverside.
		
		**Note:** If successful, this function will automatically call Entity:SetSolid( solidType ) and Entity:SetSolidFlags( 0 ).
		
		**Note:** Using SOLID_NONE will only delete the current physics object - it does not create a new one.
		
		**Bug:** BUG Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
		
		Name | Description
		--- | ---
		`solidType` | The solid type of the physics object to create, see SOLID_ Enums. Should be SOLID_VPHYSICS in most cases. NOTE Using SOLID_NONE will only delete the current physics object - it does not create a new one.
		
		
		`**Returns:** Returns true on success, false otherwise.
    **/
    
    public function PhysicsInit(solidType:SOLID):Bool;
    
    #if server
    /**
        Sets whether the layer should loop or not.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`loop` | Whether the layer should loop or not.
    **/
    
    public function SetLayerLooping(layerID:Float, loop:Bool):Void;
    #end
    
    /**
        Gets the model of given entity.
		
		**Bug:** BUG This does not necessarily return the model's path, as is the case for brush and virtual models. This is intentional behaviour, however, there is currently no way to retrieve the actual file path. Issue Tracker: #2246
		
		`**Returns:** The entity's model. Will be a filesystem path for most models. This will be nil for entities which cannot have models, such as point entities.
    **/
    
    public function GetModel():String;
    
    
    /**
        Returns the material override for this entity. 
		
		Returns an empty string if no material override exists. Use Entity:GetMaterials to list it's default materials.
		
		**Bug:** BUG The server's value takes priority on the client. Issue Tracker: #3362
		
		`**Returns:** material
    **/
    
    public function GetMaterial():String;
    
    
    /**
        Returns the frame of the currently played sequence. This will be a number between 0 and 1 as a representation of sequence progress.
		
		`**Returns:** The frame of the currently played sequence
    **/
    
    public function GetCycle():Float;
    
    
    /**
        Returns if the entity is going to be deleted in the next frame.
		
		`**Returns:** If the entity is going to be deleted.
    **/
    
    public function IsMarkedForDeletion():Bool;
    
    
    /**
        Plays an animation on the entity. This may not always work on engine entities.
		
		**Warning:** This will not reset the animation on viewmodels, use Entity:SendViewModelMatchingSequence instead.
		
		**Note:** This will not work properly if called directly after calling Entity:SetModel. Consider waiting until the next Tick. Will not work on players due to the animations being reset every frame by the base gamemode animation system. See GM:CalcMainActivity. For custom scripted entities you will want to apply example from ENTITY:Think to make animations work.
		
		**Note:** If set to a string, the function will automatically call Entity:LookupSequence to retrieve the sequence ID as a number.
		
		Name | Description
		--- | ---
		`sequence` | The sequence to play. Also accepts strings. NOTE If set to a string, the function will automatically call Entity:LookupSequence to retrieve the sequence ID as a number.
		
		
		___
		### Lua Examples
		#### Example 1
		Minimal code needed to make sequences work as expected on custom "anim" type entities.In this example, when the player uses the crate, it will open, and when they use it again, it will close.
		
		```lua 
		ENT.Base = "base_anim"
		ENT.Spawnable = true
		ENT.AutomaticFrameAdvance = true
		
		ENT.PrintName = "Animation Test"
		ENT.Category = "My Entity Category"
		
		function ENT:Initialize()
		    if ( SERVER ) then -- Only set this stuff on the server, it is networked to clients automatically
		        self:SetModel( "models/items/ammocrate_ar2.mdl" ) -- Set the model
		        self:PhysicsInit( SOLID_VPHYSICS ) -- Initialize physics
		        self:SetUseType( SIMPLE_USE ) -- Make sure ENT:Use is ran only once per use ( per press of the use button on the entity, by default the E key )
		    end
		end
		
		function ENT:Think()
		    if ( SERVER ) then -- Only set this stuff on the server
		        self:NextThink( CurTime() ) -- Set the next think for the serverside hook to be the next frame/tick
		        return true -- Return true to let the game know we want to apply the self:NextThink() call
		    end
		end
		
		if ( SERVER ) then -- This hook is only available on the server
		    function ENT:Use( activator, caller ) -- If a player uses this entity, play an animation
		        if ( !self.Opened ) then -- If we are not "opened"
		            self:ResetSequence( "open" ) -- Play the open sequence
		            self.Opened = true -- We are now opened
		        else
		            self:ResetSequence( "close" ) -- Play the close sequence
		            self.Opened = false -- We are now closed
		        end
		    end
		end
		```
    **/
    
    public function ResetSequence(sequence:Float):Void;
    
    #if server
    /**
        Adds a gesture animation to the entity and plays it. See Entity:AddGestureSequence for a function that doesn't take priority. See Entity:AddGesture for a function that takes ACT_ Enums.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`sequence` | The sequence ID to play as the gesture. See Entity: LookupSequence.
		`priority` | 
		
		
		`**Returns:** Layer ID of created layer
    **/
    
    public function AddLayeredSequence(sequence:Float, priority:Float):Float;
    #end
    
    /**
        Sets the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
		
		Name | Description
		--- | ---
		`moveCollideType` | The move collide type, see MOVECOLLIDE_ Enums
    **/
    
    public function SetMoveCollide(moveCollideType:MOVECOLLIDE):Void;
    
    #if server
    /**
        Makes the physics objects follow the set bone positions. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
    **/
    
    public function RagdollUpdatePhysics():Void;
    #end
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Get a float stored in the datatable of the entity.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 31. Specifies what key to grab from datatable.
		
		
		`**Returns:** Requested float.
    **/
    @:deprecated("INTERNAL")
    public function GetDTFloat(key:Float):Float;
    
    
    /**
        ***Deprecated:** You should be using Entity: SetParent instead.
		
		Parents the sprite to an attachment on another model. 
		
		Works only on env_sprite. 
		
		 Despite existing on client, it doesn't actually do anything on client.
		
		Name | Description
		--- | ---
		`ent` | The entity to attach/parent to
		`attachment` | The attachment ID to parent to
    **/
    @:deprecated("You should be using Entity: SetParent instead.")
    public function SetAttachment(ent:Entity, attachment:Float):Void;
    
    
    /**
        Returns the min and max of the entity's axis-aligned bounding box.
		
		Name | Description
		--- | ---
		`min` | Minimum extent of the bounding box.
		`max` | Maximum extent of the bounding box.
		
		
		Name | Description
		--- | ---
		`a` | Minimum extent of the AABB
		`b` | Maximum extent of the AABB
		
		
		___
		### Lua Examples
		#### Example 1
		The entity's AABB center (regardless of model origin) is stored in 'pos'.
		
		```lua 
		local a, b = ent:GetRotatedAABB( v:OBBMins(), v:OBBMaxs() )
		local pos = ( ent:GetPos() + ( a + b ) / 2 )
		```
		**Output:**
		
		pos has the coordinates of the AABB center.
    **/
    
    public function GetRotatedAABB(min:Vector, max:Vector):EntityGetRotatedAABBReturn;
    
    
    /**
        Returns the entity's collision group
		
		`**Returns:** The collision group. See COLLISION_GROUP_ Enums
    **/
    
    public function GetCollisionGroup():COLLISION_GROUP;
    
    
    /**
        If the entity is parented to an entity that has a model with multiple physics objects (like a ragdoll), this is used to retrieve what physics object number the entity is parented to on it's parent.
		
		`**Returns:** The physics object id, or nil if the entity has no parent
    **/
    
    public function GetParentPhysNum():Float;
    
    
    /**
        Returns the distance between the center of the bounding box and the furthest bounding box corner.
		
		`**Returns:** The radius of the bounding box.
    **/
    
    public function BoundingRadius():Float;
    
    
    /**
        Sets the render mode of the entity.
		
		Name | Description
		--- | ---
		`renderMode` | New render mode to set, see RENDERMODE_ Enums.
    **/
    
    public function SetRenderMode(renderMode:RENDERMODE):Void;
    
    
    /**
        Converts a vector local to an entity into a worldspace vector
		
		Name | Description
		--- | ---
		`lpos` | The local vector
		
		
		`**Returns:** The translated to world coordinates vector
		
		___
		### Lua Examples
		#### Example 1
		Produces a worldvector 100 units in front of the center of the entity, taking into account the entity's angle
		
		```lua 
		return ent:LocalToWorld(Vector(100,0,0))
		```
    **/
    
    public function LocalToWorld(lpos:Vector):Vector;
    
    
    /**
        Returns the attachment index of the entity's parent. Returns 0 if the entity is not parented to a specific attachment or if it isn't parented at all. 
		
		This is set by second argument of Entity:SetParent or the SetParentAttachment input.
		
		`**Returns:** The parented attachment index
    **/
    
    public function GetParentAttachment():Float;
    
    
    /**
        Gets the entity's position manipulation of the given bone. This is relative to the default position, so it is zero when unmodified.
		
		Name | Description
		--- | ---
		`boneId` | The bone's ID
		
		
		`**Returns:** The entity's position manipulation of the given bone.
    **/
    
    public function GetManipulateBonePosition(boneId:Float):Vector;
    
    
    /**
        Returns parent bone of given bone.
		
		**Note:** Will return -1 for ClientsideModel until Entity:SetupBones is called on the entity.
		
		Name | Description
		--- | ---
		`bone` | The bode ID of the bone to get parent of
		
		
		`**Returns:** Parent bone ID or -1 if we failed for some reason.
    **/
    
    public function GetBoneParent(bone:Float):Float;
    
    #if client
    /**
        Creates a clientside particle system attached to the entity. See also CreateParticleSystem
		
		**Note:** The particle effect must be precached with PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
		
		Name | Description
		--- | ---
		`particle` | The particle name to create
		`attachment` | Attachment ID to attach the particle to
		`options` | A table of tables ( IDs 1 to 64 ) having the following structure: number attachtype - The particle attach type. See PATTACH_ Enums. Default: PATTACH_ABSORIGIN Entity entity - The parent entity? Default: NULL Vector position - The offset position for given control point. Default: nil This only affects the control points of the particle effects and will do nothing if the effect doesn't use control points.
		
		
		`**Returns:** The created particle system.
    **/
    
    public function CreateParticleEffect(particle:String, attachment:Float, ?options:PATTACH):CNewParticleEffect;
    #end
    
    /**
        Starts a motion controller in the physics engine tied to this entity's PhysObj, which enables the use of ENTITY:PhysicsSimulate. 
		
		The motion controller can later be destroyed via Entity:StopMotionController. 
		
		 Motion controllers are used internally to control other Entities' PhysObjects, such as the Gravity Gun, +use pickup and the Physics Gun. 
		
		 This function should be called every time you recreate the Entity's PhysObj. Or alternatively you should call Entity:AddToMotionController on the new PhysObj. 
		
		 Also see Entity:AddToMotionController and Entity:RemoveFromMotionController.
		
		**Note:** Only works on a scripted Entity of anim type.
    **/
    
    public function StartMotionController():Void;
    
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Get an integer stored in the datatable of the entity.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 63. Specifies what key to grab from datatable.
		
		
		`**Returns:** 32-bit signed integer
    **/
    @:deprecated("INTERNAL")
    public function GetDTInt(key:Float):Float;
    
    
    /**
        Returns true if the TransmitWithParent flag is set or not.
		
		`**Returns:** Is the TransmitWithParent flag is set or not
    **/
    
    public function GetTransmitWithParent():Bool;
    
    
    /**
        Returns if we should show a spawn effect on spawn on this entity.
		
		`**Returns:** The flag to allow or disallow the spawn effect.
		
		___
		### Lua Examples
		#### Example 1
		Taken from sandbox's cl_init.lua
		
		```lua 
		function GM:NetworkEntityCreated( ent )
		
		    --
		    -- If the entity wants to use a spawn effect
		    -- then create a propspawn effect if the entity was
		    -- created within the last second (this function gets called
		    -- on every entity when joining a server)
		    --
		
		    if ( ent:GetSpawnEffect() && ent:GetCreationTime() > ( CurTime() - 1.0 ) ) then
		    
		        local ed = EffectData()
		        ed:SetEntity( ent )
		        util.Effect( "propspawn", ed, true, true )
		
		    end
		
		end
		```
		**Output:**
		
		Checks if the entity has the spawnEffect flag set to true and checks if it was created in the last second, and then shows the propspawn effect.
    **/
    
    public function GetSpawnEffect():Bool;
    
    #if server
    /**
        Applies the specified amount of damage to the entity with DMG_GENERIC flag.
		
		**Warning:** Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.
		
		Name | Description
		--- | ---
		`damageAmount` | The amount of damage to be applied.
		`attacker` | The entity that initiated the attack that caused the damage.
		`inflictor` | The entity that applied the damage, eg. a weapon.
    **/
    
    public function TakeDamage(damageAmount:Float, attacker:Entity, inflictor:Entity):Void;
    #end
    
    /**
        Returns the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
		
		`**Returns:** The move collide type, see MOVECOLLIDE_ Enums
    **/
    
    public function GetMoveCollide():MOVECOLLIDE;
    
    
    /**
        Returns whether the entity is a widget or not. 
		
		This is used by the "Edit Bones" context menu property.
		
		`**Returns:** Whether the entity is a widget or not.
    **/
    
    public function IsWidget():Bool;
    
    
    /**
        Returns solid flag(s) of an entity.
		
		`**Returns:** The flag(s) of the entity, see FSOLID_ Enums.
    **/
    
    public function GetSolidFlags():FSOLID;
    
    
    /**
        Returns true if the entity has constraints attached to it
		
		**Bug:** BUG This will only update clientside if the server calls it first. This only checks constraints added through the constraint library so this will not react to map constraints. Issue Tracker: #3837
		
		`**Returns:** Whether the entity is constrained or not.
		
		___
		### Lua Examples
		#### Example 1
		From entities/prop_effect.lua
		
		```lua 
		function ENT:PhysicsUpdate( physobj )
		
		    if ( CLIENT ) then return end
		
		    -- Don't do anything if the player isn't holding us
		    if ( !self:IsPlayerHolding() && !self:IsConstrained() ) then
		        physobj:SetVelocity( Vector(0,0,0) )
		        physobj:Sleep() 
		    end
		end
		```
    **/
    
    public function IsConstrained():Bool;
    
    
    /**
        Returns the skin index of the current skin.
		
		`**Returns:** skinIndex
    **/
    
    public function GetSkin():Float;
    
    
    /**
        Returns the direction a player/npc/ragdoll is looking as a world-oriented angle.
		
		**Bug:** BUG This can return an incorrect value in pods. Issue Tracker: #1150
		
		**Bug:** BUG This can return an incorrect value in jeeps when used with Player:EnterVehicle. Issue Tracker: #2620
		
		`**Returns:** eyeAng
		
		___
		### Lua Examples
		#### Example 1
		Print the local player's angles
		
		```lua 
		print(LocalPlayer():EyeAngles())
		```
		**Output:**
		
		When looking straight down, it might return Angle(89,-175.38,0)
    **/
    
    public function EyeAngles():Angle;
    
    #if server
    /**
        This removes the argument entity from an ent's list of entities to 'delete on remove'
		
		Name | Description
		--- | ---
		`entityToUnremove` | The entity to be removed from the list of entities to delete
    **/
    
    public function DontDeleteOnRemove(entityToUnremove:Entity):Void;
    #end
    
    /**
        Returns acceptable value range for the flex.
		
		Name | Description
		--- | ---
		`flex` | The ID of the flex to look up bounds of
		
		
		Name | Description
		--- | ---
		`a` | The minimum value for this flex
		`b` | The maximum value for this flex
    **/
    
    public function GetFlexBounds(flex:Float):EntityGetFlexBoundsReturn;
    
    
    /**
        Sets the specified value on the bone controller with the given ID of this entity, it's used in HL1 to change the head rotation of NPCs, turret aiming and so on.
		
		**Note:** This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.
		
		Name | Description
		--- | ---
		`boneControllerID` | The ID of the bone controller to set the value to. Goes from 0 to 3.
		`value` | The value to set on the specified bone controller.
    **/
    
    public function SetBoneController(boneControllerID:Float, value:Float):Void;
    
    
    /**
        Sets a networked angle value on the entity. 
		
		The value can then be accessed with Entity:GetNWAngle both from client and server.
		
		**Note:** Running this function clientside will only set it for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
		
		
		___
		### Lua Examples
		#### Example 1
		This will set the networked angle 'direction' on all clients that is pointing straight up.
		
		```lua 
		for k, v in pairs( player.GetAll() ) do
		    v:SetNWAngle( 'direction', Angle( -90, 0, 0 ) )
		end
		```
    **/
    
    public function SetNWAngle(key:String, value:Angle):Void;
    
    
    /**
        Gets the exact value for specific bodygroup of given entity.
		
		Name | Description
		--- | ---
		`id` | The id of bodygroup to get value of. Starts from 0.
		
		
		`**Returns:** Current bodygroup. Starts from 0.
		
		___
		### Lua Examples
		#### Example 1
		Gets the value of bodygroup 2 of entity player 1 is aiming at.
		
		```lua 
		print( Entity(1):GetEyeTrace().Entity:GetBodygroup(2) )
		```
		**Output:**
		
		"1" in console, if player 1 is aiming at airboat.
    **/
    
    public function GetBodygroup(id:Float):Float;
    
    
    /**
        Gets the entity's angle manipulation of the given bone. This is relative to the default angle, so the angle is zero when unmodified.
		
		Name | Description
		--- | ---
		`boneID` | The bone's ID
		
		
		`**Returns:** The entity's angle manipulation of the given bone.
    **/
    
    public function GetManipulateBoneAngles(boneID:Float):Angle;
    
    
    /**
        Returns the number of physics objects an entity has (usually 1 for non-ragdolls)
		
		`**Returns:** numObjects
		
		___
		### Lua Examples
		#### Example 1
		Finds all the Physics Objects in a ragdoll and applies an upward force
		
		```lua 
		for i=0, ragdoll:GetPhysicsObjectCount() - 1 do -- "ragdoll" being a ragdoll entity
		 
		    local phys = ragdoll:GetPhysicsObjectNum(i)
		    phys:ApplyForceCenter( Vector( 0, 0, 10000 ) )
		
		end
		```
    **/
    
    public function GetPhysicsObjectCount():Float;
    
    
    /**
        Returns the index of this view model, it can be used to identify which one of the player's view models this entity is.
		
		`**Returns:** View model index, ranges from 0 to 2, nil if the entity is not a view model
    **/
    
    public function ViewModelIndex():Float;
    
    #if server
    /**
        Fires input to the entity with the ability to make another entity responsible. 
		
		See also Entity:Fire and GM:AcceptInput.
		
		Name | Description
		--- | ---
		`input` | The name of the input to fire
		`activator` | The entity that caused this input (EG the player who pushed a button)
		`caller` | The entity that is triggering this input (EG the button that was pushed)
		`param` | The value to give to the input. Can be either a string, a number or a boolean.
    **/
    
    public function Input(input:String, activator:Entity, caller:Entity, ?param:Dynamic):Void;
    #end
    
    /**
        Returns a list of all bodygroups of the entity.
		
		`**Returns:** Bodygroups as a table of BodyGroupData structures if the entity can have bodygroups.
    **/
    
    public function GetBodyGroups():BodyGroupData;
    
    
    /**
        Performs a Ray OBBox intersection from the given position to the origin of the OBBox with the entity and returns the hit position on the OBBox
		
		Name | Description
		--- | ---
		`position` | The vector to start the intersection from.
		
		
		`**Returns:** The nearest hit point of the entity's bounding box in world coordinates.
    **/
    
    public function NearestPoint(position:Vector):Vector;
    
    
    /**
        ***Deprecated:** You should use Entity: GetNWFloat instead.
		
		Retrieves a networked float value at specified index on the entity that is set by Entity:SetNetworkedFloat. 
		
		Seems to be the same as Entity:GetNetworkedInt.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. ( If it isn't set )
		
		
		`**Returns:** The retrieved value
    **/
    @:deprecated("You should use Entity: GetNWFloat instead.")
    public function GetNetworkedFloat(key:String, ?fallback:Float):Float;
    
    #if server
    /**
        Marks the entity as a trigger, so it will generate ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch callbacks. 
		
		Internally this is stored as FSOLID_TRIGGER flag.
		
		Name | Description
		--- | ---
		`maketrigger` | Make the entity trigger or not
    **/
    
    public function SetTrigger(maketrigger:Bool):Void;
    #end
    
    /**
        Makes the physics object of the entity a AABB.
		
		**Note:** If the volume of the resulting box is 0 (the mins and maxs are the same), the mins and maxs will be changed to Vector( -1, -1, -1 ) and Vector( 1, 1, 1 ), respectively.
		
		**Note:** This function will automatically destroy any previous physics objects if successful and call Entity:SetSolid( SOLID_BBOX ), Entity:SetMoveType( MOVETYPE_VPHYSICS ), and Entity:SetCollisionBounds( mins, maxs ).
		
		**Bug:** BUG Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
		
		Name | Description
		--- | ---
		`mins` | The minimum position of the box. This is automatically ordered with the maxs.
		`maxs` | The maximum position of the box. This is automatically ordered with the mins.
		
		
		`**Returns:** Returns true on success, nil otherwise. This fails when the game cannot create any more PhysCollides.
    **/
    
    public function PhysicsInitBox(mins:Vector, maxs:Vector):Bool;
    
    
    /**
        Returns callback function for given NWVar of this entity.
		
		Name | Description
		--- | ---
		`key` | The key of the NWVar to get callback of.
		
		
		`**Returns:** The callback of given NWVar, or nil if not found.
		
		___
		### Lua Examples
		#### Example 1
		Prints callback function of a NWVar called "Key" of Player 1.
		
		```lua 
		print( Entity(1):GetNWVarProxy( "Key" ) )
		Entity(1):SetNWVarProxy( "Key", print )
		print( Entity(1):GetNWVarProxy( "Key" ) )
		```
    **/
    
    public function GetNWVarProxy(key:Dynamic):Function;
    
    
    /**
        ***Deprecated:** You should use Entity: SetNWVector instead.
		
		Sets a networked vector value at specified index on the entity. 
		
		The value then can be accessed with Entity:GetNetworkedVector both from client and server.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
    **/
    @:deprecated("You should use Entity: SetNWVector instead.")
    public function SetNetworkedVector(key:String, ?value:Vector):Void;
    
    
    /**
        Sets a networked string value on the entity. 
		
		The value can then be accessed with Entity:GetNWString both from client and server.
		
		**Note:** Running this function clientside will only set it for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set, up to 199 characters.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets a networked string with a key of "Nickname" and a value of "John" on a player.
		
		```lua 
		player:SetNWString( "Nickname", "John" )
		print( player:GetNWString( "Nickname" ) )
		```
		**Output:**
		
		"John"
    **/
    
    public function SetNWString(key:String, value:String):Void;
    
    
    /**
        Returns the sequence ID corresponding to given activity ID, and uses the provided seed for random selection. The seed should be the same server-side and client-side if used in a predicted environment. 
		
		See Entity:SelectWeightedSequence for a provided-seed version of this function.
		
		Name | Description
		--- | ---
		`act` | The activity ID, see ACT_ Enums.
		`seed` | The seed to use for randomly selecting a sequence in the case the activity ID has multiple sequences bound to it. Entity: SelectWeightedSequence uses the same seed as util. SharedRandom internally for this.
		
		
		`**Returns:** The sequence ID
    **/
    
    public function SelectWeightedSequenceSeeded(act:ACT, seed:Float):Float;
    
    
    /**
        Allows you to set the Start or End entity attachment for the rope.
		
		Name | Description
		--- | ---
		`name` | The name of the variable to modify. Accepted names are StartEntity and EndEntity.
		`entity` | The entity to apply to the specific attachment.
		
		
		___
		### Lua Examples
		#### Example 1
		As seen in the constraints module.
		
		```lua 
		local rope = ents.Create( "keyframe_rope" )
		
		-- Attachment point 1
		rope:SetEntity( "StartEntity",     Entity(1) )
		-- Attachment point 2
		rope:SetEntity( "EndEntity",     Entity(2) )
		```
    **/
    
    public function SetEntity(name:String, entity:Entity):Void;
    
    
    /**
        Returns a list of models included into the entity's model in the .qc file.
		
		`**Returns:** The list of models included into the entity's model in the .qc file.
		
		___
		### Lua Examples
		#### Example 1
		Example structure of the table. Prints into console sub models of a player model.
		
		```lua 
		PrintTable(Entity(1):GetSubModels() )
		```
		**Output:**
		
		1:
				name	=	models/m_anm.mdl
				id	=	0
    **/
    
    public function GetSubModels():AnyTable;
    
    #if server
    /**
        Sets how much friction an entity has when sliding against a surface. Entities default to 1 (100%) and can be higher or even negative.
		
		**Note:** Works only for MOVETYPE_STEP entities.
		
		**Bug:** BUG This has no effect on players. Issue Tracker: #1395
		
		Name | Description
		--- | ---
		`friction` | Friction multiplier
    **/
    
    public function SetFriction(friction:Float):Void;
    #end
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Sets the specified float on the entity's datatable.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 31.
		`float` | The float to write on the entity's datatable.
    **/
    @:deprecated("INTERNAL")
    public function SetDTFloat(key:Float, float:Float):Void;
    
    
    /**
        Converts a worldspace vector into a vector local to an entity
		
		Name | Description
		--- | ---
		`wpos` | The world vector
		
		
		`**Returns:** The local vector
    **/
    
    public function WorldToLocal(wpos:Vector):Vector;
    
    
    /**
        Virtually changes entity position for clients. Does the same thing as Entity:SetPos when used serverside.
		
		Name | Description
		--- | ---
		`origin` | The position to make clients think this entity is at.
    **/
    
    public function SetNetworkOrigin(origin:Vector):Void;
    
    #if client
    /**
        ***Deprecated:** 
		
		Initializes this entity as being clientside only. 
		
		Only works on entities fully created clientside, and as such it has currently no use due to the lack of clientside ents.Create. 
		
		 This function is automatically called by ents.CreateClientProp and ClientsideModel, ClientsideModel and ClientsideScene.
		
		**Bug:** BUG Calling this on a clientside entity will crash the game. Issue Tracker: #3368
    **/
    @:deprecated("")
    public function InitializeAsClientEntity():Void;
    #end
    
    /**
        Returns the parent entity of this entity.
		
		`**Returns:** parentEntity
    **/
    
    public function GetParent():Entity;
    
    #if server
    /**
        Returns the change in heading direction in between the start and the end of the sequence.
		
		Name | Description
		--- | ---
		`seq` | The sequence index. See Entity: LookupSequence.
		
		
		`**Returns:** The yaw delta. Returns 99999 for no movement.
    **/
    
    public function GetSequenceMoveYaw(seq:Float):Float;
    #end
    
    /**
        Checks if the entity is a ragdoll.
		
		`**Returns:** Is ragdoll or not
    **/
    
    public function IsRagdoll():Bool;
    
    
    /**
        Initializes the physics mesh of the entity from a triangle soup defined by a table of vertices. The resulting mesh is hollow, may contain holes, and always has a volume of 0. 
		
		While this is very useful for static geometry such as terrain displacements, it is advised to use Entity:PhysicsInitConvex or Entity:PhysicsInitMultiConvex for moving solid objects instead. 
		
		 Entity:EnableCustomCollisions needs to be called if you want players to collide with the entity correctly.
		
		Name | Description
		--- | ---
		`vertices` | A table consisting of MeshVertex structure (only the pos element is taken into account). Every 3 vertices define a triangle in the physics mesh.
		
		
		`**Returns:** Returns true on success, nil otherwise.
    **/
    
    public function PhysicsFromMesh(vertices:MeshVertex):Bool;
    
    #if server
    /**
        Sets the function to build the ragdoll. This is used alongside Kinect, for more info see ragdoll_motion entity.
		
		Name | Description
		--- | ---
		`func` | The build function. This function has one argument: Entity ragdoll - The ragdoll to build
    **/
    
    public function SetRagdollBuildFunction(func:Function):Void;
    #end
    #if client
    /**
        Sets the time (relative to CurTime) of the current animation frame, which is used to determine Entity:GetCycle.
		
		Name | Description
		--- | ---
		`time` | The current animation time.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets each player's animation time to 1 second in the future, which causes their animations to freeze in place.
		
		```lua 
		function GM:PrePlayerDraw(ply)
		
		    ply:SetAnimTime(CurTime()+1)
		
		end
		```
    **/
    
    public function SetAnimTime(time:Float):Void;
    #end
    
    /**
        Returns a table of save values for an entity. 
		
		These tables are not the same between the client and the server, and different entities may have different fields. 
		
		 You can get the list different fields an entity has by looking at it's source code ( the 2013 SDK can be found online, https://github.com/ValveSoftware/source-sdk-2013 ). Accessible fields are defined by each DEFINE_FIELD and DEFINE_KEYFIELD inside the DATADESC block. 
		
		 Take the headcrab, for example:
		
		Name | Description
		--- | ---
		`showAll` | If set, shows all variables, not just the ones for save.
		
		
		`**Returns:** A table containing all save values in key/value format. The value may be a sequential table (starting with 1) if the field in question is an array in engine.
		
		___
		### Lua Examples
		#### Example 1
		Get how long it has been since the player was damaged
		
		```lua 
		local meta = FindMetaTable( "Player" )
		
		function meta:GetLastDamageTime()
		    return self:GetSaveTable().m_flLastDamageTime
		end
		
		print( Entity( 1 ):GetLastDamageTime() )
		```
		**Output:**
		
		-31.965000152588
		
		#### Example 2
		Determine if a door is locked (only works on server side otherwise returns nil)
		
		```lua 
		function IsDoorLocked(ent)
		    return ent:GetSaveTable().m_bLocked
		end
		```
		**Output:**
		
		returns true if the door is locked
		
		#### Example 3
		Function DoorIsOpen( door ) that returns whether a door is open or not, for different door classes
		
		```lua 
		local TestingFunctions = {
		    ["func_door"] = function( self )
		        return ( self:GetSaveTable().m_toggle_state == 0 )
		    end,
		    ["func_door_rotating"] = function( self )
		        return ( self:GetSaveTable().m_toggle_state == 0 )
		    end,
		    ["prop_door_rotating"] = function( self )
		        return ( self:GetSaveTable().m_eDoorState ~= 0 )
		    end,
		}
		function DoorIsOpen( door )
		    local func = TestingFunctions[door:GetClass()]
		    if func then
		        return func( door )
		    end
		end
		```
    **/
    
    public function GetSaveTable(showAll:Bool):AnyTable;
    
    
    /**
        Returns whether the entity is on fire.
		
		`**Returns:** Whether the entity is on fire or not.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( Entity(1):IsOnFire() )
		```
		**Output:**
		
		Outputs 'true' to the console if the player 1 is on fire.
    **/
    
    public function IsOnFire():Bool;
    
    
    /**
        Gets the models radius.
		
		`**Returns:** The radius of the model
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function, tested on player.
		
		```lua 
		print( Entity(1):GetModelRadius() )
		```
		**Output:**
		
		72
    **/
    
    public function GetModelRadius():Float;
    
    #if server
    /**
        Returns the animation cycle/frame for given layer.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		
		
		`**Returns:** The animation cycle/frame for given layer.
    **/
    
    public function GetLayerCycle(layerID:Float):Float;
    #end
    
    /**
        Performs a trace attack.
		
		**Warning:** Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.
		
		Name | Description
		--- | ---
		`damageInfo` | The damage to apply.
		`traceRes` | Trace result to use to deal damage. See TraceResult structure
		`dir` | Direction of the attack.
    **/
    
    public function DispatchTraceAttack(damageInfo:CTakeDamageInfo, traceRes:TraceResult, ?dir:Vector):Void;
    
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Sets the specified vector on the entity's datatable.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 31.
		`vec` | The vector to write on the entity's datatable.
    **/
    @:deprecated("INTERNAL")
    public function SetDTVector(key:Float, vec:Vector):Void;
    
    
    /**
        Sets the entity's model sequence. 
		
		If the specified sequence is already active, the animation will not be restarted. See Entity:ResetSequence for a function that restarts the animation even if it is already playing. 
		
		 In some cases you want to run Entity:ResetSequenceInfo to make this function run.
		
		**Note:** This will not work properly if called directly after calling Entity:SetModel. Consider waiting until the next Tick.
		
		**Note:** Will not work on players due to the animations being reset every frame by the base gamemode animation system in GM:CalcMainActivity. For Players, use in GM:UpdateAnimation instead.
		
		**Note:** If set to a string, the function will automatically call Entity:LookupSequence to retrieve the sequence ID as a number.
		
		Name | Description
		--- | ---
		`sequenceId` | The sequence to play. Also accepts strings. NOTE If set to a string, the function will automatically call Entity:LookupSequence to retrieve the sequence ID as a number.
		
		
		___
		### Lua Examples
		#### Example 1
		Set the entity to play the "idle" sequence.
		
		```lua 
		self:SetSequence( "idle" )
		```
		
		#### Example 2
		Set the entity to play the first sequence defined on the model (usually idle).
		
		```lua 
		self:SetSequence( 0 )
		```
    **/
    
    public function SetSequence(sequenceId:Float):Void;
    
    
    /**
        Returns whether the entity's bone has the flag or not.
		
		Name | Description
		--- | ---
		`boneID` | Bone ID to test flag of.
		`flag` | The flag to test, see BONE_ Enums
		
		
		`**Returns:** Whether the bone has that flag or not
    **/
    
    public function BoneHasFlag(boneID:Float, flag:BONE):Bool;
    
    #if server
    /**
        Returns a centered vector of this entity, NPCs use this internally to aim at their targets.
		
		**Note:** This only works on players and NPCs.
		
		Name | Description
		--- | ---
		`origin` | The vector of where the the attack comes from.
		`noisy` | Decides if it should return the centered vector with a random offset to it.
		
		
		`**Returns:** The centered vector.
    **/
    
    public function BodyTarget(origin:Vector, ?noisy:Bool):Vector;
    #end
    
    /**
        Adds a PhysObject to the entity's motion controller so that ENTITY:PhysicsSimulate will be called for given PhysObject as well. 
		
		You must first create a motion controller with Entity:StartMotionController. 
		
		 You can remove added PhysObjects by using Entity:RemoveFromMotionController.
		
		**Note:** Only works on a scripted Entity of anim type
		
		Name | Description
		--- | ---
		`physObj` | The PhysObj to add to the motion controller.
    **/
    
    public function AddToMotionController(physObj:PhysObj):Void;
    
    
    /**
        Retrieves a networked string value at specified index on the entity that is set by Entity:SetNWString.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. (If it isn't set)
		
		
		`**Returns:** The value associated with the key
		
		___
		### Lua Examples
		#### Example 1
		Prints the player's rank
		
		```lua 
		print( Entity(1):GetNWString( "usergroup" ) )
		```
		**Output:**
		
		"superadmin" in single-player
    **/
    
    public function GetNWString(key:String, ?fallback:Dynamic):Dynamic;
    
    
    /**
        Returns the amount of planes of non-nodraw brush model surfaces of the entity's model.
		
		`**Returns:** The amount of brush model planes of the entity's model. This will be 0 for any non-brush model.
    **/
    
    public function GetBrushPlaneCount():Float;
    
    #if server
    /**
        Sets the blood color this entity uses.
		
		Name | Description
		--- | ---
		`bloodColor` | An integer corresponding to BLOOD_COLOR_ Enums.
    **/
    
    public function SetBloodColor(bloodColor:BLOOD_COLOR):Void;
    #end
    
    /**
        Returns whether an entity has engine effect applied or not.
		
		Name | Description
		--- | ---
		`effect` | The effect to check for, see EF_ Enums.
		
		
		`**Returns:** whether an entity has the engine effect applied or not.
    **/
    
    public function IsEffectActive(effect:EF):Bool;
    
    #if client
    /**
        Sets the render bounds for the entity. For world space coordinates see Entity:SetRenderBoundsWS.
		
		Name | Description
		--- | ---
		`mins` | The minimum corner of the bounds, relative to origin of the entity.
		`maxs` | The maximum corner of the bounds, relative to origin of the entity.
		`add` | If defined, adds this vector to maxs and subtracts this vector from mins.
    **/
    
    public function SetRenderBounds(mins:Vector, maxs:Vector, ?add:Vector):Void;
    #end
    
    /**
        Stops the motion controller created with Entity:StartMotionController.
    **/
    
    public function StopMotionController():Void;
    
    
    /**
        Returns the playback rate of the main sequence on this entity, with 1.0 being the default speed.
		
		`**Returns:** The playback rate.
    **/
    
    public function GetPlaybackRate():Float;
    
    
    /**
        Wakes up the entity's physics object
		
		___
		### Lua Examples
		#### Example 1
		This is what the function does internally.
		
		```lua 
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
		    phys:Wake()
		end
		```
    **/
    
    public function PhysWake():Void;
    
    
    /**
        Sets the entity's velocity.
		
		**Note:** Actually binds to CBaseEntity::SetLocalVelocity() which sets the entity's velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.
		
		Name | Description
		--- | ---
		`velocity` | The new velocity to set.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes Entity(1) fly upwards.
		
		```lua 
		Entity( 1 ):SetAbsVelocity( Vector( 0, 0, 500 ) )
		```
    **/
    
    public function SetAbsVelocity(velocity:Vector):Void;
    
    #if server
    /**
        Sets the bone angles. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
		
		Name | Description
		--- | ---
		`boneid` | Bone ID
		`pos` | Angle to set
    **/
    
    public function SetRagdollAng(boneid:Float, pos:Angle):Void;
    #end
    
    /**
        Causes a specified function to be run if the entity is removed by any means. This can later be undone by Entity:RemoveCallOnRemove if you need it to not run.
		
		**Bug:** BUG Using players with this function will provide a gimped entity to the callback. Pull Request: #1275
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the function within CallOnRemove
		`removeFunc` | Function to be called on remove
		`argn...` | Optional arguments to pass to removeFunc. Do note that the first argument passed to the function will always be the entity being removed, and the arguments passed on here start after that.
		
		
		___
		### Lua Examples
		#### Example 1
		Stops an engine sound when the entity is removed
		
		```lua 
		Entity:CallOnRemove("StopEngineSound",function(ent) ent:StopSound( "enginenoise.wav" ) end)
		```
    **/
    
    public function CallOnRemove(identifier:String, removeFunc:Function, argn:Rest<Dynamic>):Void;
    
    
    /**
        Converts world angles to local angles ( local to the entity )
		
		Name | Description
		--- | ---
		`ang` | The world angles
		
		
		`**Returns:** The local angles
    **/
    
    public function WorldToLocalAngles(ang:Angle):Angle;
    
    #if client
    /**
        Stops all particle effects parented to the entity with given name on given attachment.
		
		Name | Description
		--- | ---
		`name` | The name of the particle to stop.
		`attachment` | The attachment of the entity to stop particles on.
    **/
    
    public function StopParticlesWithNameAndAttachment(name:String, attachment:Float):Void;
    #end
    
    /**
        Returns the number of flexes this entity has.
		
		`**Returns:** The number of flexes.
    **/
    
    public function GetFlexNum():Float;
    
    
    /**
        Sets Hammer key values on an entity. 
		
		You can look up which entities have what key values on the Valve Developer Community on entity pages. A list of basic entities can be found here. 
		
		 Alternatively you can look at the .fgd files shipped with Garry's Mod in the bin/ folder with a text editor to see the key values as they appear in Hammer.
		
		Name | Description
		--- | ---
		`key` | The internal key name
		`value` | The value to set
		
		
		___
		### Lua Examples
		#### Example 1
		Makes an NPC not drop his weapon and drop a healthkit on death, using SF Enumerations on a Combine Soldier.A list of spawnflags a Combine Soldier has can be found here.
		
		```lua 
		npc:SetKeyValue( "spawnflags", bit.bor( SF_NPC_NO_WEAPON_DROP, SF_NPC_DROP_HEALTHKIT ) )
		```
    **/
    
	public function SetKeyValue(key:String, value:Dynamic):Void;
    
    
    /**
        Gets the children of the entity - that is, every entity whose move parent is this entity.
		
		**Note:** This function returns Entity:SetMoveParent children, NOT Entity:SetParent! Entity:SetParent however also calls Entity:SetMoveParent. This means that some entities in the returned list might have a NULL Entity:GetParent. This also means that using this function on players will return their weapons on the client but not the server.
		
		`**Returns:** A list of movement children entities
		
		___
		### Lua Examples
		#### Example 1
		Example usage and output
		
		```lua 
		-- ent is a prop_effect entity
		PrintTable( ent:GetChildren() )
		```
		**Output:**
		
		1 = Entity [184][prop_dynamic]
    **/
    
    public function GetChildren():AnyTable;
    
    
    /**
        Returns the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
		
		`**Returns:** elasticity
    **/
    
    public function GetElasticity():Float;
    
    
    /**
        Returns the position and angle of the entity's move parent as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a rotation matrix, and the fourth column stores the position vector.
		
		`**Returns:** The position and angle matrix. If the entity has no move parent, an identity matrix will be returned. If the entity is parented to attachment 0 or the parent isn't a BaseAnimating entity, the equivalent of Entity:GetMoveParent():GetWorldTransformMatrix() will be returned.
    **/
    
    public function GetParentWorldTransformMatrix():VMatrix;
    
    #if server
    /**
        ***Deprecated:** 
		
		Returns ID of workshop addon that the entity is from.
		
		**Warning:** The function currently does nothing and always returns nil
		
		`**Returns:** The workshop ID
    **/
    @:deprecated("")
    public function GetWorkshopID():Float;
    #end
    
    /**
        Causes the entity to break into its current models gibs, if it has any. 
		
		You must call Entity:PrecacheGibs on the entity before using this function, or it will not create any gibs. 
		
		 If called on server, the gibs will be spawned on the currently connected clients and will not be synchronized. Otherwise the gibs will be spawned only for the client the function is called on. 
		
		 Note, that this function will not remove or hide the entity it is called on. 
		
		 For more expensive version of this function see Entity:GibBreakServer.
		
		Name | Description
		--- | ---
		`force` | The force to apply to the created gibs.
		`clr` | If set, this will be color of the broken gibs instead of the entity's color.
		
		
		___
		### Lua Examples
		#### Example 1
		A console command that breaks the prop the player is aiming at when they runt he command.
		
		```lua 
		concommand.Add( "break", function( ply )
		    local tr = ply:GetEyeTrace()
		    local ent = tr.Entity
		    if ( !IsValid( ent ) ) then return end -- playing not looking at any entity, bail
		
		    ent:PrecacheGibs()
		    ent:GibBreakClient( tr.HitNormal * 100 ) -- Break in some direction
		end )
		```
    **/
    
    public function GibBreakClient(force:Vector, ?clr:AnyTable):Void;
    
    #if client
    /**
        Returns the last time the entity had an animation update. Returns 0 if the entity doesn't animate.
		
		`**Returns:** The last time the entity had an animation update.
    **/
    
    public function GetAnimTime():Float;
    #end
    
    /**
        Returns whether or not the the entity has had flex manipulations performed with Entity:SetFlexWeight or Entity:SetFlexScale.
		
		`**Returns:** True if the entity has flex manipulations, false otherwise.
		
		___
		### Lua Examples
		#### Example 1
		Defines server-side function which manipulates all of an entity's flexes and prints true if the entity has flex manipulations.
		
		```lua 
		function FlexExample(ent)
		
		    if(!IsValid(ent)) then return end
		    
		    -- Loop through all flexes
		    for i = 0, ent:GetFlexNum()-1 do
		    
		        -- Set each flex to number ranging from 0.0 to 2.0
		        ent:SetFlexWeight(i, math.random()*2)
		        
		    end
		    
		    -- Print whether or not we have flex manipulations
		    print(ent:HasFlexManipulatior())
		
		end
		```
		**Output:**
		
		true
    **/
    
    public function HasFlexManipulatior():Bool;
    
    
    /**
        Resets all pose parameters such as aim_yaw, aim_pitch and rotation.
    **/
    
    public function ClearPoseParameters():Void;
    
    
    /**
        Returns whether this entity uses custom collision check set by Entity:SetCustomCollisionCheck.
		
		`**Returns:** Whether this entity uses custom collision check or not
    **/
    
    public function GetCustomCollisionCheck():Bool;
    
    
    /**
        Converts a local angle (local to the entity) to a world angle.
		
		Name | Description
		--- | ---
		`ang` | The local angle
		
		
		`**Returns:** The world angle
    **/
    
    public function LocalToWorldAngles(ang:Angle):Angle;
    
    
    /**
        Checks if given flag(s) is set or not.
		
		Name | Description
		--- | ---
		`flag` | The engine flag(s) to test, see FL_ Enums
		
		
		`**Returns:** Is set or not
		
		___
		### Lua Examples
		#### Example 1
		Checks if the player is on the ground.
		
		```lua 
		print( Entity( 1 ):IsFlagSet( FL_ONGROUND ))
		```
    **/
    
    public function IsFlagSet(flag:FL):Bool;
    
    #if server
    /**
        Adds a gesture animation to the entity and plays it. See Entity:AddGesture for a function that takes ACT_ Enums. See also Entity:AddLayeredSequence.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`sequence` | The sequence ID to play as the gesture. See Entity: LookupSequence.
		`autokill` | 
		
		
		`**Returns:** Layer ID of the started gesture, used to manipulate the played gesture by other functions.
    **/
    
    public function AddGestureSequence(sequence:Float, ?autokill:Bool):Float;
    #end
    #if client
    /**
        Returns the entity's render origin, set by Entity:SetRenderOrigin in a drawing hook.
		
		`**Returns:** The entitys render origin
    **/
    
    public function GetRenderOrigin():Vector;
    #end
    #if server
    /**
        Returns the two entities involved in a constraint ent, or nil if the entity is not a constraint.
		
		Name | Description
		--- | ---
		`a` | ent1
		`b` | ent2
		
		
		___
		### Lua Examples
		#### Example 1
		From gmsave/constraints.lua
		
		```lua 
		function gmsave.ConstraintSave( ent )
		    local t = {}
		    t.EntOne, t.EntTwo = ent:GetConstrainedEntities()
		    local PhysA, PhysB = ent:GetConstrainedPhysObjects()
		
		    t.BoneOne = GetPhysicsObjectNum( t.EntOne, PhysA )
		    t.BoneTwo = GetPhysicsObjectNum( t.EntTwo, PhysB )
		    t.EntOne = gmsave.EntityEncode( t.EntOne )
		    t.EntTwo = gmsave.EntityEncode( t.EntTwo )
		    return t
		
		end
		```
    **/
    
    public function GetConstrainedEntities():EntityGetConstrainedEntitiesReturn;
    #end
    
    /**
        Initializes the entity's physics object as a physics shadow. Removes the previous physics object if successful. This is used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane. 
		
		A physics shadow can be used to have static entities that never move by setting both arguments to false.
		
		**Bug:** BUG Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
		
		Name | Description
		--- | ---
		`allowPhysicsMovement` | Whether to allow the physics shadow to move under stress.
		`allowPhysicsRotation` | Whether to allow the physics shadow to rotate under stress.
		
		
		`**Returns:** Return true on success, nil otherwise.
    **/
    
    public function PhysicsInitShadow(?allowPhysicsMovement:Bool, ?allowPhysicsRotation:Bool):Bool;
    
    #if server
    /**
        Sets the animation cycle/frame of given layer.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`cycle` | The new animation cycle/frame for given layer.
    **/
    
    public function SetLayerCycle(layerID:Float, cycle:Float):Void;
    #end
    
    /**
        Animations will be handled purely clientside instead of a fixed animtime, enabling interpolation. This does not affect layers and gestures.
		
		**Note:** Does nothing on server.
    **/
    
    public function UseClientSideAnimation():Void;
    
    
    /**
        Checks if the entity is a SENT or a built-in entity.
		
		`**Returns:** Returns true if entity is scripted ( SENT ), false if not ( A built-in engine entity )
    **/
    
    public function IsScripted():Bool;
    
    
    /**
        ***Deprecated:** You should use Entity: SetNWFloat instead.
		
		Sets a networked float value at specified index on the entity. 
		
		The value then can be accessed with Entity:GetNetworkedFloat both from client and server. 
		
		 Seems to be the same as Entity:GetNetworkedInt.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
    **/
    @:deprecated("You should use Entity: SetNWFloat instead.")
    public function SetNetworkedFloat(key:String, ?value:Float):Void;
    
    #if server
    /**
        Returns the position of the head of this entity, NPCs use this internally to aim at their targets.
		
		**Note:** This only works on players and NPCs.
		
		Name | Description
		--- | ---
		`origin` | The vector of where the attack comes from.
		
		
		`**Returns:** The head position.
    **/
    
    public function HeadTarget(origin:Vector):Vector;
    #end
    
    /**
        Sets the collision bounds for the entity, which are used for triggers ( Entity:SetTrigger, ENTITY:Touch ), determining if rendering is necessary clientside, and collision ( If Entity:SetSolid set as SOLID_BBOX ). 
		
		Input bounds are relative to Entity:GetPos! See also Entity:SetCollisionBoundsWS.
		
		Name | Description
		--- | ---
		`mins` | The minimum vector of the bounds. The vector must be smaller than second argument on all axises.
		`maxs` | The maximum vector of the bounds. The vector must be bigger than first argument on all axises.
    **/
    
    public function SetCollisionBounds(mins:Vector, maxs:Vector):Void;
    
    
    /**
        Activates the entity. This needs to be used on some entities (like constraints) after being spawned.
		
		**Note:** For some entity types when this function is used after Entity:SetModelScale, the physics object will be recreated with the new scale. Source-sdk-2013
		
		**Bug:** BUG This crashes the game with scaled vehicles. Issue Tracker: #3372
		
		___
		### Lua Examples
		#### Example 1
		Spawns a 'sent_ball' on the player.
		
		```lua 
		function ENT:SpawnMe(ply)
		    local SpawningPos = ply:GetPos()
		    local ent = ents.Create("sent_ball")
		    ent:SetPos( SpawningPos ) 
		    ent:Spawn()
		    ent:Activate()
		end
		```
    **/
    
    public function Activate():Void;
    
    
    /**
        Returns the value of the bone controller with the specified ID.
		
		**Note:** This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.
		
		Name | Description
		--- | ---
		`boneID` | ID of the bone controller. Goes from 0 to 3.
		
		
		`**Returns:** The value set on the bone controller.
    **/
    
    public function GetBoneController(boneID:Float):Float;
    
    
    /**
        Returns the forward vector of the entity, as a normalized direction vector
		
		`**Returns:** forwardDir
    **/
    
    public function GetForward():Vector;
    
    
    /**
        Returns a transition from the given start and end sequence. 
		
		This function was only used by HL1 entities and NPCs, before the advent of sequence blending and gestures.
		
		Name | Description
		--- | ---
		`currentSequence` | The currently playing sequence
		`goalSequence` | The goal sequence.
		
		
		`**Returns:** The transition sequence, -1 if not available.
    **/
    
    public function FindTransitionSequence(currentSequence:Float, goalSequence:Float):Float;
    
    #if server
    /**
        Fires an entity's input. You can find inputs for most entities on the Valve Developer Wiki 
		
		See also Entity:Input and GM:AcceptInput.
		
		Name | Description
		--- | ---
		`input` | The name of the input to fire
		`param` | The value to give to the input, can also be a number or a boolean.
		`delay` | Delay in seconds before firing
		
		
		___
		### Lua Examples
		#### Example 1
		If you are looking at a door, this will lock it
		
		```lua 
		// Entity(1) is considered a player in this example
		local tr = Entity( 1 ):GetEyeTrace()
		local ent = tr.Entity
		if IsValid( ent ) then
		    ent:Fire("Lock")
		end
		```
    **/
    
    public function Fire(input:String, ?param:String, ?delay:Float):Void;
    #end
    #if server
    /**
        Returns if entity is constraint or not
		
		`**Returns:** Is the entity a constraint or not
		
		___
		### Lua Examples
		#### Example 1
		Returns true if player 1 is aiming at constraint.
		
		```lua 
		print( player.GetByID(1):GetEyeTrace().Entity:IsConstraint() )
		```
		**Output:**
		
		false
    **/
    
    public function IsConstraint():Bool;
    #end
    
    /**
        Returns the non-VPhysics angular velocity of the entity relative to its parent entity.
		
		`**Returns:** The velocity
    **/
    
    public function GetLocalAngularVelocity():Angle;
    
    #if client
    /**
        Alters the entity's perceived serverside angle on the client.
		
		Name | Description
		--- | ---
		`angle` | Networked angle.
    **/
    
    public function SetNetworkAngles(angle:Angle):Void;
    #end
    
    /**
        Returns the jiggle amount of the entity's bone. 
		
		See Entity:ManipulateBoneJiggle for more info.
		
		Name | Description
		--- | ---
		`boneID` | The bone ID
		
		
		`**Returns:** Returns a value ranging from 0 to 255 depending on the value set with Entity: ManipulateBoneJiggle.
    **/
    
    public function GetManipulateBoneJiggle(boneID:Float):Float;
    
    #if server
    /**
        Gets the creator of the SENT.
		
		`**Returns:** The creator, NULL for no creator.
    **/
    
    public function GetCreator():Player;
    #end
    
    /**
        Returns true if the entity is on the ground, and false if it isn't. 
		
		Internally, this checks if FL_ONGROUND is set on the entity. This is only updated for players and NPCs, and thus won't inherently work for other entities.
		
		`**Returns:** Whether the entity is on the ground or not.
		
		___
		### Lua Examples
		#### Example 1
		Prints if Entity(1) is on the ground or not.
		
		```lua 
		print( Entity( 1 ):OnGround() )
		print( Entity( 1 ):IsFlagSet( FL_ONGROUND ) ) -- This should give exact same output as the first line
		```
		**Output:**
		
		In most cases, true.
    **/
    
    public function OnGround():Bool;
    
    #if client
    /**
        Resets the entity's bone cache values in order to prepare for a model change. 
		
		This should be called after calling Entity:SetPoseParameter.
    **/
    
    public function InvalidateBoneCache():Void;
    #end
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Get a string stored in the datatable of the entity.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 3. Specifies what key to grab from datatable.
		
		
		`**Returns:** Requested string.
    **/
    @:deprecated("INTERNAL")
    public function GetDTString(key:Float):String;
    
    
    /**
        ***Deprecated:** You should use Entity: SetNWEntity instead.
		
		Sets a networked entity value at specified index on the entity. 
		
		The value then can be accessed with Entity:GetNetworkedEntity both from client and server.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
    **/
    @:deprecated("You should use Entity: SetNWEntity instead.")
    public function SetNetworkedEntity(key:String, ?value:Entity):Void;
    
    #if client
    /**
        Sets the bone position and angles.
		
		Name | Description
		--- | ---
		`bone` | The bone ID to manipulate
		`pos` | The position to set
		`ang` | The angles to set
    **/
    
    public function SetBonePosition(bone:Float, pos:Vector, ang:Angle):Void;
    #end
    
    /**
        ***Deprecated:** You should use Entity: SetNWAngle instead.
		
		Sets a networked angle value at specified index on the entity. 
		
		The value then can be accessed with Entity:GetNetworkedAngle both from client and server.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
    **/
    @:deprecated("You should use Entity: SetNWAngle instead.")
    public function SetNetworkedAngle(key:String, ?value:Angle):Void;
    
    
    /**
        Sets a player's third-person animation. Mainly used by Weapons to start the player's weapon attack and reload animations.
		
		Name | Description
		--- | ---
		`playerAnim` | Player animation, see PLAYER_ Enums.
    **/
    
    public function SetAnimation(playerAnim:PLAYER):Void;
    
    
    /**
        Stops emitting the given sound script from the entity, especially useful for looping sound scripts.
		
		**Note:** This only works with sound scripts (sound.Add), using a file path will not work!
		
		Name | Description
		--- | ---
		`soundscript` | The name of the sound script to stop playback of.
    **/
    
    public function StopSound(soundscript:String):Void;
    
    
    /**
        Sets the collision bounds for the entity, which are used for triggers ( Entity:SetTrigger, ENTITY:Touch ), determining if rendering is necessary clientside, and collision ( If Entity:SetSolid set as SOLID_BBOX ). 
		
		Input bounds are in world coordinates! See also Entity:SetCollisionBounds.
		
		Name | Description
		--- | ---
		`vec1` | The first vector of the bounds.
		`vec2` | The second vector of the bounds.
    **/
    
    public function SetCollisionBoundsWS(vec1:Vector, vec2:Vector):Void;
    
    
    /**
        Returns the body group count of the entity.
		
		`**Returns:** Amount of bodygroups the entitys model has
    **/
    
    public function GetNumBodyGroups():Float;
    
    
    /**
        An advanced version of Entity:PhysicsInitConvex which initializes a physics object from multiple convex meshes. This should be used for physics objects with a custom shape which cannot be represented by a single convex mesh. 
		
		If successful, the previous physics object will be removed.
		
		**Bug:** BUG Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior. You can use the following work-around for movement, though clientside collisions will still be broken. function ENT:Think()
		
		if ( CLIENT ) then
		
				local physobj = self:GetPhysicsObject()
		
		
		
				if ( IsValid( physobj ) ) then
		
					physobj:SetPos( self:GetPos() )
		
					physobj:SetAngles( self:GetAngles() )
		
				end
		
			end
		
		end
		
		Name | Description
		--- | ---
		`vertices` | A table consisting of tables of Vectors. Each sub-table defines a set of points to be used in the computation of one convex mesh.
		
		
		`**Returns:** Returns true on success, nil otherwise
		
		___
		### Lua Examples
		#### Example 1
		Creates a physics mesh for the entity which consists of two boxes.
		
		```lua 
		local min1 = Vector( -30, -10, 0 ) -- Box1 minimum corner
		local max1 = Vector( -10, 10, 20 ) -- Box1 maximum corner
		
		local min2 = Vector( 10, -5, 10 ) -- Box2 minimum corner
		local max2 = Vector( 30, 5, 40 ) -- Box2 maximum corner
		
		if SERVER then
		    function ENT:Initialize()
		        self:SetModel( "models/props_c17/oildrum001.mdl" )
		
		        -- Initializing the multi-convex physics mesh
		        self:PhysicsInitMultiConvex( {
		            { -- Each sub-table is a set of vertices of a convex piece, order doesn't matter
		                Vector( min1.x, min1.y, min1.z ), -- The first box vertices
		                Vector( min1.x, min1.y, max1.z ),
		                Vector( min1.x, max1.y, min1.z ),
		                Vector( min1.x, max1.y, max1.z ),
		                Vector( max1.x, min1.y, min1.z ),
		                Vector( max1.x, min1.y, max1.z ),
		                Vector( max1.x, max1.y, min1.z ),
		                Vector( max1.x, max1.y, max1.z ),
		            },
		            { -- All these tables together form a concave collision mesh
		                Vector( min2.x, min2.y, min2.z ), -- The second box vertices
		                Vector( min2.x, min2.y, max2.z ),
		                Vector( min2.x, max2.y, min2.z ),
		                Vector( min2.x, max2.y, max2.z ),
		                Vector( max2.x, min2.y, min2.z ),
		                Vector( max2.x, min2.y, max2.z ),
		                Vector( max2.x, max2.y, min2.z ),
		                Vector( max2.x, max2.y, max2.z ),
		            },
		        } )
		
		        self:SetSolid( SOLID_VPHYSICS ) -- Setting the solidity
		        self:SetMoveType( MOVETYPE_VPHYSICS ) -- Setting the movement type
		
		        self:EnableCustomCollisions( true ) -- Enabling the custom collision mesh
		
		        self:PhysWake() -- Enabling the physics motion
		    end
		else
		    local col = Color( 0, 0, 255, 255 )
		
		    -- Drawing collision boxes on the client
		    function ENT:Draw()
		        self:DrawModel()
		
		        local pos, ang = self:GetPos(), self:GetAngles()
		
		        render.DrawWireframeBox( pos, ang, min1, max1, col ) -- Drawing the first collision box
		        render.DrawWireframeBox( pos, ang, min2, max2, col ) -- Drawing the second collision box
		    end
		end
		```
    **/
    
    public function PhysicsInitMultiConvex(vertices:AnyTable):Bool;
    
    
    /**
        Sets angles relative to angles of Entity:GetParent
		
		Name | Description
		--- | ---
		`ang` | The local angle
    **/
    
    public function SetLocalAngles(ang:Angle):Void;
    
    
    /**
        Removes solid flag(s) from the entity.
		
		Name | Description
		--- | ---
		`flags` | The flag(s) to remove, see FSOLID_ Enums.
    **/
    
    public function RemoveSolidFlags(flags:FSOLID):Void;
    
    
    /**
        Initializes a static physics object of the entity using its current model. If successful, the previous physics object is removed. 
		
		This is what used by entities such as func_breakable, prop_dynamic, item_suitcharger, prop_thumper and npc_rollermine while it is in its "buried" state in the Half-Life 2 Campaign. 
		
		 If the entity's current model has no physics mesh associated to it, no physics object will be created.
		
		**Note:** This function will automatically call Entity:SetSolid( solidType ).
		
		**Bug:** BUG Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
		
		Name | Description
		--- | ---
		`solidType` | The solid type of the physics object to create, see SOLID_ Enums. Should be SOLID_VPHYSICS in most cases.
		
		
		`**Returns:** Returns true on success, false otherwise. This will fail if the entity's current model has no associated physics mesh.
    **/
    
    public function PhysicsInitStatic(solidType:SOLID):Bool;
    
    #if server
    /**
        Extinguishes the entity if it is on fire. Has no effect if called inside EntityTakeDamage (and the attacker is the flame that's hurting the entity)
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		player.GetAll()[1]:Extinguish()
		```
		**Output:**
		
		Extinguishes the first player if he is on fire.
    **/
    
    public function Extinguish():Void;
    #end
    
    /**
        Sets the angles of the entity.
		
		**Note:** To set a player's angles, use Player:SetEyeAngles instead.
		
		Name | Description
		--- | ---
		`angles` | The new angles.
    **/
    
    public function SetAngles(angles:Angle):Void;
    
    
    /**
        Fires a bullet. 
		
		When used in a WEAPON hook such as WEAPON:Think or WEAPON:PrimaryAttack, it will use Player:LagCompensation internally.
		
		**Note:** Lag compensation will not work if this function is called in a timer, regardless if the timer was made in a WEAPON hook.
		
		Name | Description
		--- | ---
		`bulletInfo` | The bullet data to be used. See the Bullet structure.
		`suppressHostEvents` | Has the effect of encasing the FireBullets call in SuppressHostEvents, only works in multiplayer.
    **/
    
    public function FireBullets(bulletInfo:Bullet, ?suppressHostEvents:Bool):Void;
    
    
    /**
        Sets a networked vector value on the entity. 
		
		The value can then be accessed with Entity:GetNWVector both from client and server.
		
		**Note:** Running this function clientside will only set it for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
		
		
		___
		### Lua Examples
		#### Example 1
		This will set the networked angle 'direction' on all clients to straight up.
		
		```lua 
		for k, v in pairs( player.GetAll() ) do
		    v:SetNWVector( 'direction', Vector( 0, 0, 1 ) )
		end
		```
    **/
    
    public function SetNWVector(key:String, value:Vector):Void;
    
    #if server
    /**
        Returns entity's creation ID. Unlike Entity:EntIndex or Entity:MapCreationID, it will always increase and old values won't be reused.
		
		`**Returns:** The creation ID
    **/
    
    public function GetCreationID():Float;
    #end
    
    /**
        Returns the specified hook callbacks for this entity added with Entity:AddCallback 
		
		The callbacks can then be removed with Entity:RemoveCallback.
		
		Name | Description
		--- | ---
		`hook` | The hook to retrieve the callbacks from, see Entity Callbacks for the possible hooks.
		
		
		`**Returns:** A table containing the callbackid and function of all the callbacks for the specified hook
    **/
    
    public function GetCallbacks(hook:String):AnyTable;
    
    #if client
    /**
        Disables an active matrix.
		
		Name | Description
		--- | ---
		`matrixType` | The name of the matrix type to disable. The only known matrix type is "RenderMultiply".
    **/
    
    public function DisableMatrix(matrixType:String):Void;
    #end
    
    /**
        Sets the Movement Parent of an entity to another entity. 
		
		Similar to Entity:SetParent, except the object's coordinates are not translated automatically before parenting.
		
		Name | Description
		--- | ---
		`Parent` | The entity to change this entity's Movement Parent to.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the Movement Entity of a new entity to Player 1.
		
		```lua 
		local hat = ents.Create("prop_physics")
		//Position and angles are relative to our future parent.
		hat:SetPos(Vector(0,0,10))
		hat:SetAngles(Angle(0,90,0))
		
		hat:SetMoveParent(Entity(1))
		
		hat:Spawn()
		```
    **/
    
    public function SetMoveParent(Parent:Entity):Void;
    
    
    /**
        Return the index of the model sequence that is currently active for the entity.
		
		`**Returns:** The index of the model sequence.
    **/
    
    public function GetSequence():Float;
    
    
    /**
        Applies an engine effect to an entity. 
		
		See also Entity:IsEffectActive and Entity:RemoveEffects.
		
		Name | Description
		--- | ---
		`effect` | The effect to apply, see EF_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds a blinking effect to an entity.
		
		```lua 
		Entity:AddEffects( EF_ITEM_BLINK )
		```
    **/
    
    public function AddEffects(effect:EF):Void;
    
    #if client
    /**
        Stops all particle effects parented to the entity. 
		
		This is ran automatically on every client by Entity:StopParticles if called on the server.
    **/
    
    public function StopParticleEmission():Void;
    #end
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Sets the specified string on the entity's datatable.
		
		**Note:** The length of these strings are capped at 512 characters.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 3.
		`str` | The string to write on the entity's datatable, can't be more than 512 characters per string.
    **/
    @:deprecated("INTERNAL")
    public function SetDTString(key:Float, str:String):Void;
    
    
    /**
        Checks if the entity is a player or not.
		
		`**Returns:** Whether the entity is a player.
		
		___
		### Lua Examples
		#### Example 1
		Checks if two entities are players.
		
		```lua 
		print( player.GetByID( 1 ):IsPlayer() )
		print( ents.FindByClass( "prop_physics" )[ 1 ]:IsPlayer() )
		```
    **/
    
    public function IsPlayer():Bool;
    
    
    /**
        Returns the table that contains all values saved within the entity.
		
		`**Returns:** entTable
    **/
    
    public function GetTable():AnyTable;
    
    #if client
    /**
        Draws the shadow of an entity.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		function ENT:Draw()
		 self:DrawModel()
		 self:CreateShadow()
		end
		```
		**Output:**
		
		Draws the shadow of an entity
    **/
    
    public function CreateShadow():Void;
    #end
    
    /**
        Returns the entity's capabilities as a bitfield. In the engine this function is mostly used to check the use type, the save/restore system and level transitions flags. 
		
		Even though the function is defined shared, it is not guaranteed to return the same value across states.
		
		**Note:** The enums for this are not currently implemented in Lua, however you can access the defines here.
		
		`**Returns:** The bitfield, a combination of the FCAP_ flags.
    **/
    
    public function ObjectCaps():Float;
    
    
    /**
        Retrieves a networked float value at specified index on the entity that is set by Entity:SetNWFloat.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. (If it isn't set)
		
		
		`**Returns:** The value associated with the key
    **/
    
    public function GetNWFloat(key:String, ?fallback:Dynamic):Dynamic;
    
    
    /**
        Sets solid flag(s) for the entity. 
		
		This overrides any other flags the entity might have had. See Entity:AddSolidFlags for adding flags.
		
		Name | Description
		--- | ---
		`flags` | The flag(s) to set, see FSOLID_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Mimics Entity:SetTrigger call on the entity and adds FSOLID_USE_TRIGGER_BOUNDS flag to it.
		
		```lua 
		ent:SetSolidFlags( bit.bor( FSOLID_TRIGGER, FSOLID_USE_TRIGGER_BOUNDS ) )
		```
    **/
    
    public function SetSolidFlags(flags:FSOLID):Void;
    
    
    /**
        Sets the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
		
		Name | Description
		--- | ---
		`elasticity` | The elasticity to set.
    **/
    
    public function SetElasticity(elasticity:Float):Void;
    
    
    /**
        Stops a sound created by Entity:StartLoopingSound.
		
		Name | Description
		--- | ---
		`id` | The sound ID returned by Entity: StartLoopingSound
    **/
    
    public function StopLoopingSound(id:Float):Void;
    
    
    /**
        Checks if the entity is a vehicle or not.
		
		`**Returns:** Whether the entity is a vehicle.
    **/
    
    public function IsVehicle():Bool;
    
    
    /**
        Gets the orientation and position of the attachment by its ID, returns nothing if the attachment does not exist.
		
		**Note:** The update rate of this function is limited by the setting of ENT.AutomaticFrameAdvance for Scripted Entities!
		
		**Bug:** BUG This will return improper values for viewmodels if used in GM:CalcView. Issue Tracker: #1255
		
		Name | Description
		--- | ---
		`attachmentId` | The internal ID of the attachment.
		
		
		`**Returns:** The angle and position of the attachment. See the AngPos structure. Most notably, the table contains the keys "Ang" and "Pos".
		
		___
		### Lua Examples
		#### Example 1
		Grabs the muzzle position of a player's view model
		
		```lua 
		local vm = ply:GetViewModel()
		local obj = vm:LookupAttachment( "muzzle" )
		local muzzlepos = vm:GetAttachment( obj )
		```
    **/
    
    public function GetAttachment(attachmentId:Float):AngPos;
    
    #if server
    /**
        Sets the duration of given layer. This internally overrides the Entity:SetLayerPlaybackRate.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`duration` | The new duration of the layer in seconds.
    **/
    
    public function SetLayerDuration(layerID:Float, duration:Float):Void;
    #end
    
    /**
        Sets a networked entity value on the entity. 
		
		The value can then be accessed with Entity:GetNWEntity both from client and server.
		
		**Note:** Running this function clientside will only set it for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
		
		
		___
		### Lua Examples
		#### Example 1
		This will set the networked entity 'owner' on all clients to themselves.
		
		```lua 
		for k, v in pairs( player.GetAll() ) do
		    v:SetNWEntity( "owner", v )
		end
		```
    **/
    
    public function SetNWEntity(key:String, value:Entity):Void;
    
    
    /**
        Sets whether the entity is solid or not.
		
		Name | Description
		--- | ---
		`IsNotSolid` | True will make the entity not solid, false will make it solid.
    **/
    
    public function SetNotSolid(IsNotSolid:Bool):Void;
    
    
    /**
        Stops any attached to the entity .pcf particles using ParticleEffectAttach. 
		
		On client, this is the same as Entity:StopParticleEmission. ( and you should use StopParticleEmission instead ) On server, this is the same as running Entity:StopParticleEmission on every client.
    **/
    
    public function StopParticles():Void;
    
    
    /**
        Sets the entity's local velocity which is their velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.
		
		**Warning:** Same as Entity:SetAbsVelocity, but clamps the given velocity, and is not recommended to be used because of that.
		
		Name | Description
		--- | ---
		`velocity` | The new velocity to set.
    **/
    
    public function SetLocalVelocity(velocity:Vector):Void;
    
    
    /**
        Checks if the entity is an NPC or not. 
		
		This will return false for NextBots.
		
		`**Returns:** Whether the entity is an NPC.
    **/
    
    public function IsNPC():Bool;
    
    
    /**
        Sets the bone matrix of given bone to given matrix. See also Entity:GetBoneMatrix. 
		
		Despite existing serverside, it does nothing.
		
		Name | Description
		--- | ---
		`boneid` | The ID of the bone
		`matrix` | The matrix to set.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function.Aim at an NPC and enter "bones_cl" into your console.
		
		```lua 
		if ( CLIENT ) then
		    concommand.Add( "bones_cl", function( ply )
		        local ent = ply:GetEyeTrace().Entity
		        if ( !IsValid( ent ) ) then return end
		
		        ent:AddCallback( "BuildBonePositions", function( ent, numbones )
		            for i = 0, numbones - 1 do
		                local mat = ent:GetBoneMatrix( i )
		                if ( !mat ) then continue end
		
		                local scale = mat:GetScale()
		                mat:Scale( Vector( 1, 1, 1 ) * 0.5 )
		                ent:SetBoneMatrix( i, mat )
		            end
		        end )
		    end )
		end
		```
    **/
    
    public function SetBoneMatrix(boneid:Float, matrix:VMatrix):Void;
    
    
    /**
        Returns if entity should create a server ragdoll on death or a client one.
		
		`**Returns:** Returns true if ragdoll will be created on server, false if on client
    **/
    
    public function GetShouldServerRagdoll():Bool;
    
    
    /**
        Sets the solidity of an entity.
		
		Name | Description
		--- | ---
		`solid_type` | The solid type. See the SOLID_ Enums.
    **/
    
    public function SetSolid(solid_type:SOLID):Void;
    
    
    /**
        Returns ids of child bones of given bone.
		
		Name | Description
		--- | ---
		`boneid` | Bone id to lookup children of
		
		
		`**Returns:** A table of bone ids
    **/
    
    public function GetChildBones(boneid:Float):AnyTable;
    
    
    /**
        Forces the Entity to be dropped, when it is being held by a player's gravitygun or physgun.
    **/
    
    public function ForcePlayerDrop():Void;
    
    #if server
    /**
        Returns how much friction an entity has. Entities default to 1 (100%) and can be higher or even negative.
		
		`**Returns:** friction
    **/
    
    public function GetFriction():Float;
    #end
    
    /**
        Sets if the entity's model should render at all. 
		
		If set on the server, this entity will no longer network to clients, and for all intents and purposes cease to exist clientside.
		
		Name | Description
		--- | ---
		`shouldNotDraw` | true disables drawing
    **/
    
    public function SetNoDraw(shouldNotDraw:Bool):Void;
    
    
    /**
        Returns the lowest corner of an entity's bounding box as a local vector.
		
		`**Returns:** The local position of the lowest corner of the entity's oriented bounding box.
    **/
    
    public function OBBMins():Vector;
    
    
    /**
        Sets the specified pose parameter to the specified value. 
		
		You should call Entity:InvalidateBoneCache after calling this function.
		
		**Note:** Avoid calling this in draw hooks, especially when animating things, as it might cause visual artifacts.
		
		Name | Description
		--- | ---
		`poseName` | Name of the pose parameter.
		`poseValue` | The value to set the pose to.
		
		
		___
		### Lua Examples
		#### Example 1
		Copies pose parameters from one entity to another. Since Entity.GetPoseParameter returns pose parameter values 0-1 on the client, they have to be remapped to the range returned by Entity.GetPoseParameterRange before being set on the target entity.
		
		```lua 
		local function CopyPoseParams(pEntityFrom, pEntityTo)
		    if (SERVER) then
		        for i = 0, pEntityFrom:GetNumPoseParameters() - 1 do
		            local sPose = pEntityFrom:GetPoseParameterName(i)
		            pEntityTo:SetPoseParameter(sPose, pEntityFrom:GetPoseParameter(sPose))
		        end
		    else
		        for i = 0, pEntityFrom:GetNumPoseParameters() - 1 do
		            local flMin, flMax = pEntityFrom:GetPoseParameterRange(i)
		            local sPose = pEntityFrom:GetPoseParameterName(i)
		            pEntityTo:SetPoseParameter(sPose, math.Remap(pEntityFrom:GetPoseParameter(sPose), 0, 1, flMin, flMax))
		        end
		    end
		end
		```
    **/
    
    public function SetPoseParameter(poseName:String, poseValue:Float):Void;
    
    
    /**
        Starts a "looping" sound. As with any other sound playing methods, this function expects the sound file to be looping itself and will not automatically loop a non looping sound file as one might expect. 
		
		This function is almost identical to CreateSound, with the exception of the sound being created in the STATIC channel and with normal attenuation. 
		
		 See also Entity:StopLoopingSound
		
		Name | Description
		--- | ---
		`sound` | Sound to play. Can be either a sound script or a filepath.
		
		
		`**Returns:** The ID number of started sound starting with 0, or -1 if we failed for some reason.
    **/
    
    public function StartLoopingSound(sound:String):Float;
    
    
    /**
        Sets the entity's collision group.
		
		Name | Description
		--- | ---
		`group` | Collision group of the entity, see COLLISION_GROUP_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		Showcase function that produces reliable player-player nocollision for targets. First argument is any player entity, second is an optional number for min time. After min time elapsed, no-collision will turn off once we are not penetrating any players.Contains no fail-saves or checks.
		
		```lua 
		function ActivateNoCollision(target, min)
		
		    local oldCollision = target:GetCollisionGroup() or COLLISION_GROUP_PLAYER
		    target:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR) -- Players can walk through target
		
		    if (min and (tonumber(min) > 0)) then 
		
		        timer.Simple(min, function() --after 'min' seconds
		            timer.Create(target:SteamID64().."_checkBounds_cycle", 0.5, 0, function() -- check every half second
		                local penetrating = ( self:GetPhysicsObject() and self:GetPhysicsObject():IsPenetrating() ) or false --if we are penetrating an object
		                local tooNearPlayer = false --or inside a player's hitbox
		                for _, ply in pairs(player.GetAll()) do
		                    if target:GetPos():DistToSqr(ply:GetPos()) <= (80*80) then
		                        tooNearPlayer = true
		                    end
		                end
		                if not (penetrating and tooNearPlayer) then --if both false then 
		                    target:SetCollisionGroup(oldCollision) -- Stop no-colliding by returning the original collision group (or default player collision)
		                    timer.Destroy(target:SteamID64().."_checkBounds_cycle")
		                end
		            end)
		        end)
		    end
		end
		ActivateNoCollision(Entity( 1 ), 10)
		```
		**Output:**
		
		You can walk through the player for 10 seconds
    **/
    
    public function SetCollisionGroup(group:COLLISION_GROUP):Void;
    
    
    /**
        When this flag is set the entity will only transmit to the player when its parent is transmitted. This is useful for things like viewmodel attachments since without this flag they will transmit to everyone (and cause the viewmodels to transmit to everyone too).
		
		**Note:** In the case of scripted entities, this will override ENTITY:UpdateTransmitState
		
		Name | Description
		--- | ---
		`onoff` | Will set the TransmitWithParent flag on or off
    **/
    
    public function SetTransmitWithParent(onoff:Bool):Void;
    
    #if client
    /**
        Draws the entity or model. 
		
		If called inside ENTITY:Draw or ENTITY:DrawTranslucent, it only draws the entity's model itself. If called outside of those hooks, it will call both of said hooks depending on Entity:GetRenderGroup, drawing the entire entity again.
		
		**Note:** When drawing an entity more than once per frame in different positions, you should call Entity:SetupBones before each draw; Otherwise, the entity will retain its first drawn position.
		
		**Note:** This is a rendering function that requires a 3D rendering context. This means that it will only work in hooks with a 3D rendering context.
		
		**Bug:** BUG Calling this on entities with EF_BONEMERGE and EF_NODRAW applied causes a crash. Issue Tracker: #1558
		
		**Bug:** BUG Using this with a map model (game.GetWorld():GetModel()) crashes the game. Issue Tracker: #2688
		
		___
		### Lua Examples
		#### Example 1
		Manually draws a single ClientsideModel on the specified bone, on the given offset for every player affected by this hook.This is useful in case you want to reuse a single model without having to create one for each player.
		
		```lua 
		local modelexample = ClientsideModel( "models/thrusters/jetpack.mdl" )
		modelexample:SetNoDraw( true )
		
		local offsetvec = Vector( 3, -5.6, 0 )
		local offsetang = Angle( 180, 90, -90 )
		
		hook.Add( "PostPlayerDraw" , "manual_model_draw_example" , function( ply )
		    local boneid = ply:LookupBone( "ValveBiped.Bip01_Spine2" )
		    
		    if not boneid then
		        return
		    end
		    
		    local matrix = ply:GetBoneMatrix( boneid )
		    
		    if not matrix then 
		        return 
		    end
		    
		    local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )
		    
		    modelexample:SetPos( newpos )
		    modelexample:SetAngles( newang )
		    modelexample:SetupBones()
		    modelexample:DrawModel()
		    
		end)
		```
    **/
    
    public function DrawModel():Void;
    #end
    
    /**
        Returns a table containing the number of frames, flags, name, and FPS of an entity's animation ID.
		
		**Note:** Animation ID is not the same as sequence ID.
		
		Name | Description
		--- | ---
		`animIndex` | The animation ID to look up
		
		
		`**Returns:** Information about the animation, or nil if the index is out of bounds
		
		___
		### Lua Examples
		#### Example 1
		A function that finds an entity sequence's corresponding animation and returns the animation info.
		
		```lua 
		function GetAnimInfoSequence( ent, seq )
		
		    if( !IsValid( ent ) ) then return nil end
		
		    local seqname = ent:GetSequenceName( seq )
		    
		    if( seqname == "Unknown" ) then return nil end
		
		    local info = nil
		    local done = ent:GetAnimInfo(0).label    -- this is how we know when to stop
		    local i = 1
		
		    -- We don't want to increment too high or we will run into errors or possibly crashes
		    while(i < 1600) do    -- arbitrary failsafe
		    
		        info = ent:GetAnimInfo(i)
		        
		        if(string.find(info.label, "@"..seqname) or string.find(info.label, "a_"..seqname)) then
		            return info
		        end
		        
		        -- the first animation info is repeated when there are no animations left in the model
		        if(info.label == done) then break end
		        
		        i = i + 1
		        
		    end
		
		    return nil
		
		end
		```
    **/
    
    public function GetAnimInfo(animIndex:Float):AnyTable;
    
    
    /**
        Sets the gravity multiplier of the entity.
		
		**Bug:** BUG This function is not predicted. Issue Tracker: #3648
		
		Name | Description
		--- | ---
		`gravityMultiplier` | Value which specifies the gravity multiplier.
    **/
    
    public function SetGravity(gravityMultiplier:Float):Void;
    
    
    /**
        Enables or disables trigger bounds. 
		
		This will give the entity a "trigger box" that extends around its bounding box by boundSize units in X/Y and (boundSize / 2) in +Z (-Z remains the same). The trigger box is world aligned and will work regardless of the object's solidity and collision group. 
		
		 Valve use trigger boxes for all pickup items. Their bloat size is 24, a surprisingly large figure.
		
		**Note:** The trigger boxes can be made visible as a light blue box by using the ent_bbox console command while looking at the entity. Alternatively a classname or entity index can be used as the first argument. This requires developer to be set to 1.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable the bounds.
		`boundSize` | The distance/size of the trigger bounds.
    **/
    
    public function UseTriggerBounds(enable:Bool, ?boundSize:Float):Void;
    
    
    /**
        Returns true if the target is in line of sight. This will only work on CBaseCombatCharacter entities.
		
		Name | Description
		--- | ---
		`target` | The target to test. You can also supply an Entity instead of a Vector
		
		
		`**Returns:** Returns true if the line of sight is clear
    **/
    
    public function IsLineOfSightClear(target:Vector):Bool;
    
    #if server
    /**
        Sets the bone position. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
		
		Name | Description
		--- | ---
		`boneid` | Bone ID
		`pos` | Position to set
    **/
    
    public function SetRagdollPos(boneid:Float, pos:Vector):Void;
    #end
    
    /**
        Returns the entity which the ragdoll came from. The opposite of Player:GetRagdollEntity.
		
		`**Returns:** The entity who owns the ragdoll.
		
		___
		### Lua Examples
		#### Example 1
		Loop through all player ragdolls and print their owners.
		
		```lua 
		for e, ent in pairs( ents.GetAll() ) do
		    if( IsValid( ent:GetRagdollOwner() ) ) then
		        print( ent:GetRagdollOwner() )
		    end
		end
		```
		**Output:**
		
		While a player is dead and their ragdoll is spawned this returns: Player [1][PlayerName]
    **/
    
    public function GetRagdollOwner():Entity;
    
    
    /**
        Fires the muzzle flash effect of the weapon the entity is carrying. This only creates a light effect and is often called alongside Weapon:SendWeaponAnim
    **/
    
    public function MuzzleFlash():Void;
    
    #if client
    /**
        Returns the entity's render angles, set by Entity:SetRenderAngles in a drawing hook.
		
		`**Returns:** The entitys render angles
    **/
    
    public function GetRenderAngles():Angle;
    #end
    #if client
    /**
        Gets the physics bone count of the entity's model. This is only applicable to ragdoll models and only to "anim" type Scripted Entities.
		
		`**Returns:** How many physics bones exist on the model.
    **/
    
    public function GetModelPhysBoneCount():Float;
    #end
    #if server
    /**
        Returns whether the entity is inside a wall or outside of the map.
		
		**Note:** Internally this function uses util.IsInWorld, that means that this function only checks Entity:GetPos of the entity. If an entity is only partially inside a wall, or has a weird GetPos offset, this function may not give reliable output.
		
		`**Returns:** Is the entity in world
    **/
    
    public function IsInWorld():Bool;
    #end
    #if client
    /**
        Spawns a clientside ragdoll for the entity, positioning it in place of the original entity, and makes the entity invisible. It doesn't preserve flex values (face posing) as CSRagdolls don't support flex. 
		
		It does not work on players. Use Player:CreateRagdoll instead. 
		
		 The original entity is not removed, and neither are any ragdolls previously generated with this function. 
		
		 To make the entity re-appear, run Entity:SetNoDraw( false )
		
		`**Returns:** The created ragdoll.
		
		___
		### Lua Examples
		#### Example 1
		Spawns a ragdoll for all NPCs.
		
		```lua 
		for k,npc in pairs( ents.FindByClass( "npc_*" ) ) do
		    npc.RagDoll = npc:BecomeRagdollOnClient()
		end
		```
    **/
    
    public function BecomeRagdollOnClient():CSEnt;
    #end
    
    /**
        ***Deprecated:** You should use Entity: GetNWInt instead.
		
		Retrieves a networked integer value at specified index on the entity that is set by Entity:SetNetworkedInt.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. ( If it isn't set )
		
		
		`**Returns:** The retrieved value
    **/
    @:deprecated("You should use Entity: GetNWInt instead.")
    public function GetNetworkedInt(key:String, ?fallback:Float):Float;
    
    
    /**
        Overrides a single material on the model of this entity. 
		
		To set a Lua material created with CreateMaterial, just prepend a "!" to the material name.
		
		**Bug:** BUG The server's value takes priority on the client. Issue Tracker: #3362
		
		Name | Description
		--- | ---
		`index` | Index of the material to override, acceptable values are from 0 to 31. Indexes are by Entity:GetMaterials, but you have to subtract 1 from them. If called with no arguments, all sub materials will be reset.
		`material` | The material to override the default one with. Set to nil to revert to default material.
    **/
    
    public function SetSubMaterial(?index:Float, ?material:String):Void;
    
    #if server
    /**
        Returns whether the entity is lag compensated or not.
		
		`**Returns:** Whether the entity is lag compensated or not.
    **/
    
    public function IsLagCompensated():Bool;
    #end
    #if client
    /**
        Sets the render bounds for the entity in world space coordinates. For relative coordinates see Entity:SetRenderBounds.
		
		Name | Description
		--- | ---
		`mins` | The minimum corner of the bounds, relative to origin of the world/map.
		`maxs` | The maximum corner of the bounds, relative to origin of the world/map.
		`add` | If defined, adds this vector to maxs and subtracts this vector from mins.
    **/
    
    public function SetRenderBoundsWS(mins:Vector, maxs:Vector, ?add:Vector):Void;
    #end
    #if client
    /**
        This forces an entity to use the bone transformation behaviour from versions prior to 2014-07-08. This behaviour affects Entity:EnableMatrix and Entity:SetModelScale and is incorrect, therefore this function be used exclusively as a quick fix for old scripts that rely on it.
		
		Name | Description
		--- | ---
		`enabled` | Whether the entity should use the old bone transformation behaviour or not.
    **/
    
    public function SetLegacyTransform(enabled:Bool):Void;
    #end
    
    /**
        An interface for accessing internal key values on entities. This function returns variables created with DEFINE_KEYFIELD in C++ entities. 
		
		See Entity:GetSaveTable for a more detailed explanation.
		
		Name | Description
		--- | ---
		`VariableName` | Name of variable corresponding to an entity save value.
		
		
		`**Returns:** The internal variable value
    **/
    
    public function GetInternalVariable(VariableName:String):Dynamic;
    
    
    /**
        Removes a PhysObject from the entity's motion controller so that ENTITY:PhysicsSimulate will no longer be called for given PhysObject. 
		
		You must first create a motion controller with Entity:StartMotionController.
		
		**Note:** Only works on a scripted Entity of anim type
		
		Name | Description
		--- | ---
		`physObj` | The PhysObj to remove from the motion controller.
    **/
    
    public function RemoveFromMotionController(physObj:PhysObj):Void;
    
    
    /**
        Returns whether this entity has the specified spawnflags bits set.
		
		Name | Description
		--- | ---
		`spawnFlags` | The spawnflag bits to check, see SF_ Enums.
		
		
		`**Returns:** Whether the entity has that spawnflag set or not.
		
		___
		### Lua Examples
		#### Example 1
		As seen in sandbox's PhysgunPickup hook.
		
		```lua 
		function GM:PhysgunPickup( ply, ent )
		
		    -- Don't move physboxes if the mapper logic says no
		    if ( ent:GetClass() == "func_physbox" && ent:HasSpawnFlags( SF_PHYSBOX_MOTIONDISABLED ) ) then return false end
		
		    return true
		    
		end
		```
    **/
    
    public function HasSpawnFlags(spawnFlags:SF):Bool;
    
    
    /**
        Retrieves a value from entity's Entity:GetTable. Set by Entity:SetVar.
		
		Name | Description
		--- | ---
		`key` | Key of the value to retrieve
		`default` | A default value to fallback to if we couldn't retrieve the value from entity
		
		
		`**Returns:** Retrieved value
		
		___
		### Lua Examples
		#### Example 1
		The 2 lines of code are functionally identical.
		
		```lua 
		print( Entity( 1 ):GetVar( "Test" ) )
		
		print( Entity( 1 ).Test )
		```
    **/
    
    public function GetVar(key:Dynamic, ?_default:Dynamic):Dynamic;
    
    
    /**
        Sets whether an entity's shadow should be drawn.
		
		Name | Description
		--- | ---
		`shouldDraw` | True to enable, false to disable shadow drawing.
    **/
    
    public function DrawShadow(shouldDraw:Bool):Void;
    
    
    /**
        Returns the highest corner of an entity's bounding box as a local vector.
		
		`**Returns:** The local position of the highest corner of the entity's oriented bounding box.
    **/
    
    public function OBBMaxs():Vector;
    
    
    /**
        Returns the ID of the flex based on given name.
		
		Name | Description
		--- | ---
		`name` | The name of the flex to get the ID of. Case sensitive.
		
		
		`**Returns:** The ID of flex nil if no flex with given name was found
    **/
    
    public function GetFlexIDByName(name:String):Float;
    
    #if server
    /**
        Removes and stops all gestures.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
    **/
    
    public function RemoveAllGestures():Void;
    #end
    
    /**
        Checks if the entity plays a sound when picked up by a player.
		
		**Bug:** BUG This will return nil if Entity:SetShouldPlayPickupSound has not been called. Pull Request: #1488
		
		`**Returns:** True if it plays the pickup sound, false otherwise.
    **/
    
    public function GetShouldPlayPickupSound():Bool;
    
    
    /**
        Removes an engine effect applied to an entity.
		
		Name | Description
		--- | ---
		`effect` | The effect to remove, see EF_ Enums.
    **/
    
    public function RemoveEffects(effect:EF):Void;
    
    
    /**
        Destroys the current physics object of an entity.
    **/
    
    public function PhysicsDestroy():Void;
    
    
    /**
        Gets the entity's scale manipulation of the given bone. Normal scale is Vector( 1, 1, 1 )
		
		Name | Description
		--- | ---
		`boneID` | The bone's ID
		
		
		`**Returns:** The entity's scale manipulation of the given bone
    **/
    
    public function GetManipulateBoneScale(boneID:Float):Vector;
    
    
    /**
        Gets the bounds (min and max corners) of a hit box.
		
		Name | Description
		--- | ---
		`hitbox` | The number of the hit box.
		`group` | The group of the hit box. This should be 0 in most cases.
		
		
		Name | Description
		--- | ---
		`a` | Hit box mins. Will be nil if the hit box index was out of range.
		`b` | Hit box maxs. Will be nil if the hit box index was out of range.
		
		
		___
		### Lua Examples
		#### Example 1
		Displays the mins and maxs for the client's first hitbox in the first group, which is generally the head.
		
		```lua 
		local mins, maxs = LocalPlayer():GetHitBoxBounds(0, 0)
		print(mins, maxs)
		```
		**Output:**
		
		-1.250000 -6.500000 -3.190000 8.250000 3.500000 3.310000
    **/
    
    public function GetHitBoxBounds(hitbox:Float, group:Float):EntityGetHitBoxBoundsReturn;
    
    
    /**
        Returns a table of information about an entity's sequence.
		
		Name | Description
		--- | ---
		`sequenceId` | The sequence id of the entity.
		
		
		`**Returns:** Table of information about the entity's sequence, or nil is ID is out of range. See SequenceInfo structure
		
		___
		### Lua Examples
		#### Example 1
		Draw each player's current sequence bounding box with sequence name, activity number, and activity name above their head.
		
		```lua 
		function GM:PostPlayerDraw( ply )
		
		    seqinfo = ply:GetSequenceInfo( ply:GetSequence() )
		    seqinfo.player = ply
		    
		    render.DrawWireframeBox( ply:GetPos(), ply:GetAngles(), seqinfo.bbmin, seqinfo.bbmax, color_white, true )
		    
		end
		
		function GM:HUDPaint()
		
		    local seqinfo, textpos = nil, nil
		
		    for p, ply in pairs(player.GetAll()) do
		    
		        seqinfo = ply:GetSequenceInfo(ply:GetSequence())
		        textpos = ( ply:GetPos() + Vector( 0, 0, seqinfo.bbmax.z + 10 ) ):ToScreen()
		    
		        if ( textpos.visible ) then
		            draw.SimpleText( seqinfo.label, "GModNotify", textpos.x, textpos.y, color_white, TEXT_ALIGN_CENTER )
		            draw.SimpleText( seqinfo.activity..": "..seqinfo.activityname, "GModNotify", textpos.x, textpos.y+20, color_white, TEXT_ALIGN_CENTER )
		        end
		    
		    end
		
		end
		```
    **/
    
    public function GetSequenceInfo(sequenceId:Float):SequenceInfo;
    
    
    /**
        Removes a function previously added via Entity:CallOnRemove.
		
		Name | Description
		--- | ---
		`identifier` | Identifier of the function within CallOnRemove
		
		
		___
		### Lua Examples
		#### Example 1
		Removes the call to stop an engine's sounds when the entity is removed
		
		```lua 
		Entity:RemoveCallOnRemove("StopEngineSound")
		```
    **/
    
    public function RemoveCallOnRemove(identifier:String):Void;
    
    
    /**
        Returns whether the entity is persistent or not. 
		
		See Entity:SetPersistent for more information on persistence.
		
		`**Returns:** True if the entity is set to be persistent.
    **/
    
    public function GetPersistent():Bool;
    
    #if server
    /**
        Sets the player who gets credit if this entity kills something with physics damage within the time limit.
		
		**Note:** This can only be called on props.
		
		Name | Description
		--- | ---
		`ent` | Player who gets the kills. Setting this to a non-player entity will not work.
		`timeLimit` | Time in seconds until the entity forgets its physics attacker and prevents it from getting the kill credit.
    **/
    
    public function SetPhysicsAttacker(ent:Player, ?timeLimit:Float):Void;
    #end
    #if server
    /**
        Sets whether an entity can be unfrozen, meaning that it cannot be unfrozen using the physgun.
		
		Name | Description
		--- | ---
		`freezable` | True to make the entity unfreezable, false otherwise.
    **/
    
    public function SetUnFreezable(?freezable:Bool):Void;
    #end
    
    /**
        Sets the parent of this entity, making it move with its parent.
		
		**Warning:** This can cause undefined physics behaviour when used on entities that don't support parenting. See the Valve developer wiki for more information.
		
		**Note:** This does not work on the world.
		
		**Note:** You must call Entity:SetMoveType( MOVETYPE_NONE ) on the child for this argument to have any effect!
		
		Name | Description
		--- | ---
		`parent` | The entity to parent to. Setting this to nil will clear the parent.
		`attachmentId` | The attachment id to use when parenting, defaults to -1 or whatever the parent had set previously. NOTE You must call Entity:SetMoveType( MOVETYPE_NONE ) on the child for this argument to have any effect!
    **/
    
    public function SetParent(?parent:Entity, ?attachmentId:Float):Void;
    
    
    /**
        Return activity id out of sequence id. Opposite of Entity:SelectWeightedSequence.
		
		Name | Description
		--- | ---
		`seq` | The sequence ID
		
		
		`**Returns:** The activity ID, ie ACT_ Enums
    **/
    
    public function GetSequenceActivity(seq:Float):ACT;
    
    
    /**
        Flags an entity as using custom lua defined collisions. Fixes entities having spongy player collisions or not hitting traces, such as after Entity:PhysicsFromMesh
		
		Name | Description
		--- | ---
		`useCustom` | True to flag this entity
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a mesh table, and assigns it as the entity's collisions
		
		```lua 
		function ENT:ProceduralPlatform()
		    local VERTICES = {},
		    for x = 1, 32, 1, do
		        for y = 1, 32, do
		            table.insert( VERTICES, { pos = ( self:GetPos() + Vector( 0, 0, 1 ) ) } );
		            table.insert( VERTICES, { pos = ( self:GetPos() + Vector( 0, y, 1 ) ) } );
		            table.insert( VERTICES, { pos = ( self:GetPos() + Vector( x, y, 1 ) ) } );
		
		            table.insert( VERTICES, { pos = ( self:GetPos() + Vector( 0, 0, 1 ) ) } );
		            table.insert( VERTICES, { pos = ( self:GetPos() + Vector( x, y, 1 ) ) } );
		            table.insert( VERTICES, { pos = ( self:GetPos() + Vector( x, 0, 1 ) ) } );
		        end
		    end
		    self:PhysicsFromMesh( VERTICES );
		    self:GetPhysicsObject():EnableMotion( false );
		    self:EnableCustomCollisions( true );
		end
		```
    **/
    
    public function EnableCustomCollisions(useCustom:Bool):Void;
    
    
    /**
        Makes an entity follow another entity's bone. 
		
		Internally this function calls Entity:SetParent( parent, boneid ) and Entity:AddEffects( EF_FOLLOWBONE ).
		
		**Warning:** This function will not work if the target bone's parent bone is invalid or if the bone is not used by VERTEX LOD0
		
		**Note:** If the entity vibrates, you probably need to run Entity:SetPredictable( false ) clientside.
		
		Name | Description
		--- | ---
		`parent` | The entity to follow the bone of. If unset, removes the FollowBone effect.
		`boneid` | The bone to follow
    **/
    
    public function FollowBone(?parent:Entity, boneid:Float):Void;
    
    
    /**
        Gets the gravity multiplier of the entity.
		
		`**Returns:** gravityMultiplier
    **/
    
    public function GetGravity():Float;
    
    
    /**
        Returns a bit flag of all engine flags of the entity.
		
		`**Returns:** Engine flags, see EFL_ Enums
    **/
    
    public function GetEFlags():EFL;
    
    
    /**
        ***Deprecated:** You should use Entity: SetNWString instead.
		
		Sets a networked string value at specified index on the entity. 
		
		The value then can be accessed with Entity:GetNetworkedString both from client and server.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
    **/
    @:deprecated("You should use Entity: SetNWString instead.")
    public function SetNetworkedString(key:String, ?value:String):Void;
    
    #if client
    /**
        Can be used to apply a custom VMatrix to the entity, mostly used for scaling the model by a Vector. 
		
		To disable it, use Entity:DisableMatrix. 
		
		 If your old scales are wrong due to a recent update, use Entity:SetLegacyTransform as a quick fix.
		
		**Note:** The matrix can also be modified to apply a custom rotation and offset via the VMatrix:SetAngles and VMatrix:SetTranslation functions.
		
		**Bug:** BUG This does not scale procedural bones. Issue Tracker: #3502
		
		**Bug:** BUG This disables inverse kinematics of an entity. Issue Tracker: #3502
		
		Name | Description
		--- | ---
		`matrixType` | The name of the matrix type. The only implemented matrix type is "RenderMultiply".
		`matrix` | The matrix to apply before drawing the entity.
		
		
		___
		### Lua Examples
		#### Example 1
		To scale a prop's height by 4x
		
		```lua 
		local scale = Vector(1,1,4)
		
		local mat = Matrix()
		mat:Scale(scale)
		prop:EnableMatrix("RenderMultiply", mat)
		```
    **/
    
    public function EnableMatrix(matrixType:String, matrix:VMatrix):Void;
    #end
    
    /**
        Returns length of currently played sequence.
		
		**Bug:** BUG This will return incorrect results for weapons and viewmodels clientside in thirdperson. Issue Tracker: #2783
		
		Name | Description
		--- | ---
		`seqid` | A sequence ID to return the length specific sequence of instead of the entity's main/currently playing sequence.
		
		
		`**Returns:** The length of the sequence
		
		___
		### Lua Examples
		#### Example 1
		Example usage for the argument. Retrieve length of animation on specific gesture slot.
		
		```lua 
		local ply = Entity( 1 )
		local seq = ply:SelectWeightedSequence( ACT_GMOD_TAUNT_CHEER )
		local len = ply:SequenceDuration( seq )
		print( ply, seq, len )
		```
		**Output:**
		
		Player [1][Rubat] 303 2.7499999180436
    **/
    
    public function SequenceDuration(?seqid:Float):Float;
    
    
    /**
        Returns the activity name for the given sequence id.
		
		Name | Description
		--- | ---
		`sequenceId` | The sequence id.
		
		
		`**Returns:** The ACT_ Enums as a string, returns "Not Found!" with an invalid sequence and "No model!" when no model is set.
    **/
    
    public function GetSequenceActivityName(sequenceId:Float):ACT;
    
    #if client
    /**
        Sets whether an entity should be predictable or not. When an entity is set as predictable, its DT vars can be changed during predicted hooks. This is useful for entities which can be controlled by player input. 
		
		Any datatable value that mismatches from the server will be overridden and a prediction error will be spewed. 
		
		 Weapons are predictable by default, and the drive system uses this function to make the controlled prop predictable as well. 
		
		 Visit Predicted Hooks for a list of all predicted hooks, and the Prediction page. For further technical information on the subject, visit valve's wiki.
		
		**Note:** This function resets the datatable variables everytime it's called, it should ideally be called when a player starts using the entity and when he stops
		
		**Note:** Entities set as predictable with this function will be unmarked when the user lags and receives a full packet update, to handle such case visit GM:NotifyShouldTransmit
		
		Name | Description
		--- | ---
		`setPredictable` | whether to make this entity predictable or not.
    **/
    
    public function SetPredictable(setPredictable:Bool):Void;
    #end
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Sets the specified angle on the entity's datatable.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 31.
		`ang` | The angle to write on the entity's datatable.
    **/
    @:deprecated("INTERNAL")
    public function SetDTAngle(key:Float, ang:Angle):Void;
    
    #if server
    /**
        Sets the maximum health for entity. Note, that you can still set entity's health above this amount with Entity:SetHealth.
		
		Name | Description
		--- | ---
		`maxhealth` | What the max health should be
    **/
    
    public function SetMaxHealth(maxhealth:Float):Void;
    #end
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Get a vector stored in the datatable of the entity.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 63. Specifies what key to grab from datatable.
		
		
		`**Returns:** Requested vector.
    **/
    @:deprecated("INTERNAL")
    public function GetDTVector(key:Float):Vector;
    
    
    /**
        Gets the bone the hit box is attached to.
		
		Name | Description
		--- | ---
		`hitbox` | The number of the hit box.
		`group` | The number of the hit box group. This should be 0 in most cases. Numbering for these groups start from 0. The total group count can be found with Entity: GetHitBoxGroupCount.
		
		
		`**Returns:** The number of the bone. Will be nil if the hit box index was out of range.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local ply = LocalPlayer()
		local numHitBoxGroups = ply:GetHitBoxGroupCount()
		
		for group=0, numHitBoxGroups - 1 do
		  local numHitBoxes = ply:GetHitBoxCount( group )
		    
		  for hitbox=0, numHitBoxes - 1 do
		    local bone = ply:GetHitBoxBone(hitbox, group)
		
		    print( "Hit box group " .. group .. ", hitbox " .. hitbox .. " is attached to bone " .. ply:GetBoneName(bone) )
		  end
		end
		```
		**Output:**
		
		Hit box group 0, hit box 0 is attached to bone ValveBiped.Bip01_Head1, etc.
    **/
    
    public function GetHitBoxBone(hitbox:Float, group:Float):Float;
    
    
    /**
        Returns the render mode of the entity.
		
		`**Returns:** The render Mode. See RENDERMODE_ Enums
    **/
    
    public function GetRenderMode():RENDERMODE;
    
    
    /**
        Sends sequence animation to the view model. It is recommended to use this for view model animations, instead of Entity:ResetSequence. 
		
		This function is only usable on view models.
		
		**Bug:** BUG Sequences 0-6 will not be looped regardless if they're marked as a looped animation or not. Issue Tracker: #3229
		
		Name | Description
		--- | ---
		`seq` | The sequence ID returned by Entity: LookupSequence or Entity: SelectWeightedSequence.
		
		
		___
		### Lua Examples
		#### Example 1
		Converting an ACT_VM_* enumeration to a sequence usable by the function.
		
		```lua 
		local VModel = self.Owner:GetViewModel( )
		local EnumToSeq = VModel:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
		
		VModel:SendViewModelMatchingSequence( EnumToSeq )
		```
		**Output:**
		
		Sends the primary attack enumeration sequence to the view model and plays it.
    **/
    
    public function SendViewModelMatchingSequence(seq:Float):Void;
    
    #if server
    /**
        Returns whether the target/given entity is visible from the this entity. 
		
		This is meant to be used only with NPCs. 
		
		 Differences from a simple trace include:
		
		Name | Description
		--- | ---
		`target` | Entity to check for visibility to.
		
		
		`**Returns:** If the entities can see each other.
    **/
    
    public function Visible(target:Entity):Bool;
    #end
    
    /**
        Returns an angle based on the ones inputted that you can use to align an object.
		
		**Note:** This function doesn't change the angle of the entity on its own (see example).
		
		Name | Description
		--- | ---
		`from` | The angle you want to align from
		`to` | The angle you want to align to
		
		
		`**Returns:** The resulting aligned angle
		
		___
		### Lua Examples
		#### Example 1
		This example will make ent1 face up from ent2.
		
		```lua 
		ent1:SetAngles(ent1:AlignAngles(ent1:GetForward():Angle(), ent2:GetUp():Angle()))
		```
		**Output:**
		
		Sets ent1's angle to one where ent1 faces up from ent2.
    **/
    
    public function AlignAngles(from:Angle, to:Angle):Angle;
    
    #if server
    /**
        Returns the two entities physobjects involved in a constraint ent, or no value if the entity is not a constraint.
		
		Name | Description
		--- | ---
		`a` | phys1
		`b` | phys2
		
		
		___
		### Lua Examples
		#### Example 1
		From gmsave/constraints.lua
		
		```lua 
		function gmsave.ConstraintSave( ent )
		 local t = {}
		 t.EntOne, t.EntTwo = ent:GetConstrainedEntities()
		 local PhysA, PhysB = ent:GetConstrainedPhysObjects()
		 
		 t.BoneOne = GetPhysicsObjectNum( t.EntOne, PhysA )
		 t.BoneTwo = GetPhysicsObjectNum( t.EntTwo, PhysB )
		 t.EntOne = gmsave.EntityEncode( t.EntOne )
		 t.EntTwo = gmsave.EntityEncode( t.EntTwo )
		 return t
		end
		```
    **/
    
    public function GetConstrainedPhysObjects():EntityGetConstrainedPhysObjectsReturn;
    #end
    #if server
    /**
        Check if the given position or entity is within this entity's PVS.
		
		**Note:** The function won't take in to account AddOriginToPVS and the like.
		
		Name | Description
		--- | ---
		`testPoint` | Entity or Vector to test against. If an entity is given, this function will test using its bounding box.
		
		
		`**Returns:** True if the testPoint is within our PVS.
    **/
    
    public function TestPVS(testPoint:Dynamic):Bool;
    #end
    
    /**
        ***Deprecated:** You should use Entity: GetNWString instead.
		
		Retrieves a networked string value at specified index on the entity that is set by Entity:SetNetworkedString.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. ( If it isn't set )
		
		
		`**Returns:** The retrieved value
    **/
    @:deprecated("You should use Entity: GetNWString instead.")
    public function GetNetworkedString(key:String, ?fallback:String):String;
    
    
    /**
        Removes specified flag(s) from the entity
		
		Name | Description
		--- | ---
		`flag` | The flag(s) to remove, see FL_ Enums
    **/
    
    public function RemoveFlags(flag:FL):Void;
    
    
    /**
        Moves the entity to the specified position.
		
		**Warning:** Entities with Entity:GetSolid of SOLID_BBOX will have their angles reset!
		
		**Note:** If the new position doesn't take effect right away, you can use Entity:SetupBones to force it to do so. This issue is especially common when trying to render the same entity twice or more in a single frame at different positions.
		
		**Bug:** BUG This will fail inside of predicted functions called during player movement processing. This includes WEAPON:PrimaryAttack and WEAPON:Think. Issue Tracker: #2447
		
		Name | Description
		--- | ---
		`position` | The position to move the entity to.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the player's position to (0, 0, 0)
		
		```lua 
		Entity( 1 ):SetPos( Vector( 0, 0, 0 ) )
		```
		**Output:**
		
		The player is now located at Vector(0, 0, 0)
    **/
    
    public function SetPos(position:Vector):Void;
    
    
    /**
        Initializes the entity and starts its networking. If called on a player, it will respawn them. 
		
		This calls ENTITY:Initialize on Lua-defined entities.
    **/
    
    public function Spawn():Void;
    
    
    /**
        Sets the health of the entity.
		
		**Note:** You may want to take Entity:GetMaxHealth into account when calculating what to set health to, in case a gamemode has a different max health than 100.
		
		Name | Description
		--- | ---
		`newHealth` | New health value.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the entity's health to their maximum health.
		
		```lua 
		Entity( 1 ):SetHealth( Entity( 1 ):GetMaxHealth() )
		```
		**Output:**
		
		The entity's health is now full.
		
		#### Example 2
		Deducts 50 points of health from the entity.
		
		```lua 
		Entity( 1 ):SetHealth( Entity( 1 ):Health() - 50 )
		```
		**Output:**
		
		The entity now has 50 less health.
    **/
    
    public function SetHealth(newHealth:Float):Void;
    
    
    /**
        Returns the count of possible values for this bodygroup. 
		
		This is not the maximum value, since the bodygroups start with 0, not 1.
		
		Name | Description
		--- | ---
		`bodygroup` | The ID of bodygroup to retrieve count of.
		
		
		`**Returns:** Count of values of passed bodygroup.
    **/
    
    public function GetBodygroupCount(bodygroup:Float):Float;
    
    #if server
    /**
        Adds a gesture animation to the entity and plays it. See Entity:AddGestureSequence and Entity:AddLayeredSequence for functions that takes sequences instead of ACT_ Enums.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`activity` | The activity to play as the gesture. See ACT_ Enums.
		`autokill` | 
		
		
		`**Returns:** Layer ID of the started gesture, used to manipulate the played gesture by other functions.
    **/
    
    public function AddGesture(activity:ACT, ?autokill:Bool):Float;
    #end
    
    /**
        Sets the current Hitbox set for the entity.
		
		Name | Description
		--- | ---
		`id` | The new hitbox set to set. Can be a name as a string, or the ID as a number. If the operation failed, the function will silently fail.
    **/
    
    public function SetHitboxSet(id:Float):Void;
    
    
    /**
        Sets a function to be called when the NWVar changes.
		
		Name | Description
		--- | ---
		`key` | The key of the NWVar to add callback for.
		`callback` | The function to be called when the NWVar changes. It has 4 arguments: Entity ent - The entity string name - Name of the NWVar that has changed any oldval - The old value any newval - The new value
		
		
		___
		### Lua Examples
		#### Example 1
		Prints all changes to a NWVar called "Key" of Player 1.
		
		```lua 
		Entity( 1 ):SetNWVarProxy( "Key", print )
		Entity( 1 ):SetNWString( "Key", "Value" )
		Entity( 1 ):SetNWString( "Key", "Table" )
		```
    **/
    
    public function SetNWVarProxy(key:Dynamic, callback:Function):Void;
    
    #if server
    /**
        Tests whether the entity passes the entity filter. 
		
		This will call ENTITY:PassesFilter on scripted entities of the type "filter".
		
		**Note:** This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )
		
		Name | Description
		--- | ---
		`caller` | The initiator of the test. For example the trigger this filter entity is used in.
		`ent` | The entity to test against the entity filter.
		
		
		`**Returns:** Whether the entity info passes the entity filter.
    **/
    
    public function PassesFilter(caller:Entity, ent:Entity):Bool;
    #end
    
    /**
        Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNWEntity.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. (If it isn't set)
		
		
		`**Returns:** The value associated with the key
    **/
    
    public function GetNWEntity(key:String, ?fallback:Dynamic):Dynamic;
    
    #if server
    /**
        Sets the layer weight. This influences how strongly the animation should be overriding the normal animations of the entity.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`weight` | The new layer weight.
    **/
    
    public function SetLayerWeight(layerID:Float, weight:Float):Void;
    #end
    
    /**
        Sets a networked float (number) value on the entity. 
		
		The value can then be accessed with Entity:GetNWFloat both from client and server. 
		
		 Unlike Entity:SetNWInt, floats don't have to be whole numbers.
		
		**Note:** Running this function clientside will only set it for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
		
		
		___
		### Lua Examples
		#### Example 1
		This will set the networked float 'test' on all clients to 0.5.
		
		```lua 
		for k,v in pairs( player.GetAll() ) do
		    v:SetNWFloat( 'test', 0.5 )
		end
		```
    **/
    
    public function SetNWFloat(key:String, value:Float):Void;
    
    #if server
    /**
        Sets the use type of an entity, affecting how often ENTITY:Use will be called for Lua entities.
		
		Name | Description
		--- | ---
		`useType` | The use type to apply to the entity. Uses _USE Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes the ENTITY:Use hook only get called once at every use.
		
		```lua 
		Entity:SetUseType( SIMPLE_USE )
		```
    **/
    
    public function SetUseType(useType:USETYPE):Void;
    #end
    #if client
    /**
        Initializes the class names of an entity's phoneme mappings (mouth movement data). This is called by default with argument "phonemes" when a flex-based entity (such as an NPC) is created.
		
		**Note:** TF2 phonemes can be accessed by using a path such as "player/scout/phonemes/phonemes" , check TF2's "tf2_misc_dir.vpk" with GCFScape for other paths, however it seems that TF2 sounds don't contain phoneme definitions anymore after being converted to mp3 and only rely on VCD animations, this needs to be further investigated
		
		Name | Description
		--- | ---
		`fileRoot` | The file prefix of the phoneme mappings (relative to "garrysmod/expressions/").
		
		
		___
		### Lua Examples
		#### Example 1
		Defines a function that can enable or disable phoneme mappings on an entity.
		
		```lua 
		-- Turn phoneme mappings on or off
		function EnablePhonemes(ent, on)
		
		    if(!IsValid(ent)) then return end
		    
		    if(!on) then
		        -- Disable mouth movement
		        ent:SetupPhonemeMappings("")
		    else
		        -- Enable mouth movement
		        ent:SetupPhonemeMappings("phonemes")
		    end
		
		end
		```
    **/
    
    public function SetupPhonemeMappings(fileRoot:String):Void;
    #end
    
    /**
        Sets whether the entity should use a spawn effect when it is created on the client. 
		
		See Entity:GetSpawnEffect for more information on how the effect is applied.
		
		**Note:** This function will only have an effect when the entity spawns. After that it will do nothing even is set to true.
		
		Name | Description
		--- | ---
		`spawnEffect` | Sets if we should show a spawn effect.
		
		
		___
		### Lua Examples
		#### Example 1
		Simplified code taken from sandbox's commands.lua
		
		```lua 
		local function MakeRagdoll( Player, Pos, Ang, Model, PhysicsObjects, Data )
		
		    local Ent = ents.Create( "prop_ragdoll" )
		    duplicator.DoGeneric( Ent, Data )
		    Ent:Spawn()
		    
		    duplicator.DoGenericPhysics( Ent, Player, Data )
		    Ent:Activate()
		
		    Ent:SetSpawnEffect( true )
		    return Ent    
		end
		```
		**Output:**
		
		Spawns the ragdoll and then sets the spawnEffect flag to true.
    **/
    
    public function SetSpawnEffect(spawnEffect:Bool):Void;
    
    
    /**
        Returns the ground speed of the entity's sequence.
		
		**Note:** In most cases it's better to use NextBot:BodyMoveXY instead.
		
		Name | Description
		--- | ---
		`sequenceId` | The sequence ID.
		
		
		`**Returns:** The ground speed of this sequence.
		
		___
		### Lua Examples
		#### Example 1
		Move the NextBot based on the ground speed of its walking animation (within its coroutine).NOTE In most cases it's better to use NextBot:BodyMoveXY instead.
		
		```lua 
		local sequence = self:LookupSequence( "walk_all" )
		
		if ( sequence ) then
		    self:StartActivity( ACT_WALK )
		    self:SetSequence( sequence )
		    self.loco:SetDesiredSpeed( self:GetSequenceGroundSpeed( sequence ) )
		end
		```
    **/
    
    public function GetSequenceGroundSpeed(sequenceId:Float):Float;
    
    
    /**
        Returns the attachment index of the given attachment name.
		
		Name | Description
		--- | ---
		`attachmentName` | The name of the attachment.
		
		
		`**Returns:** The attachment index, or 0 if the attachment does not exist and -1 if the model is invalid.
    **/
    
    public function LookupAttachment(attachmentName:String):Float;
    
    #if client
    /**
        Used to specify a plane, past which an object will be visually clipped.
		
		Name | Description
		--- | ---
		`planeNormal` | The normal of the plane. Anything behind the normal will be clipped.
		`planePosition` | The position of the plane.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a blue barrel at Vector(0, 0, 0), freezes it, and will visually clip the barrel's lower half.
		
		```lua 
		local ent = ents.Create( "prop_physics" )
		ent:SetModel( "models/props_borealis/bluebarrel001.mdl" )
		ent:SetPos( Vector(0, 0, 0) )
		ent:Spawn()
		ent:GetPhysicsObject():EnableMotion(false)
		
		local normal = ent:GetUp()
		local position = normal:Dot( ent:GetPos() )
		ent:SetRenderClipPlaneEnabled( true )
		ent:SetRenderClipPlane( normal, position )
		```
    **/
    
    public function SetRenderClipPlane(planeNormal:Vector, planePosition:Float):Void;
    #end
    
    /**
        In the case of a scripted entity, this will cause the next ENTITY:Think event to be run at the given time. 
		
		Does not work clientside! Use Entity:SetNextClientThink instead.
		
		**Bug:** BUG This does not work with SWEPs or Nextbots. Issue Tracker: #3269
		
		Name | Description
		--- | ---
		`timestamp` | The relative to CurTime timestamp, at which the next think should occur.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints 'Hello, World!' in console and sleeps for a second.
		
		```lua 
		function ENT:Think()
		    print("Hello, World!")
		
		    self:NextThink( CurTime() + 1 )
		    return true -- Note: You need to return true to override the default next think time
		end
		```
		**Output:**
		
		Hello, World! every second the entity exists in the world.
    **/
    
    public function NextThink(timestamp:Float):Void;
    
    #if server
    /**
        Sets the priority of given layer.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`priority` | The new priority of the layer.
    **/
    
    public function SetLayerPriority(layerID:Float, priority:Float):Void;
    #end
    
    /**
        Gets the name of specific bodygroup for given entity.
		
		Name | Description
		--- | ---
		`id` | The id of bodygroup to get the name of.
		
		
		`**Returns:** The name of the bodygroup
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( player.GetByID(1):GetEyeTrace().Entity:GetBodygroupName(1) )
		```
		**Output:**
		
		"Weapon" in console, if player 1 is aiming at airboat.
    **/
    
    public function GetBodygroupName(id:Float):String;
    
    #if client
    /**
        Returns true if the entity is being looked at by the local player and is within 256 units of distance.
		
		**Note:** This function is only available in entities that are based off of sandbox's base_gmodentity
		
		**Note:** This function uses Distance instead of DistToSqr so it may not be suitable in situations where it's called often
		
		`**Returns:** Is the entity being looked at by the local player and within 256 units.
    **/
    
    public function BeingLookedAtByLocalPlayer():Bool;
    #end
    
    /**
        Creates a network variable on the entity and adds Set/Get functions for it. This function should only be called in ENTITY:SetupDataTables.
		
		Name | Description
		--- | ---
		`type` | Supported choices: "String" "Bool" "Float" "Int" (32-bit signed integer) "Vector" "Angle" "Entity"
		`slot` | Each network var has to have a unique slot. The slot is per type - so you can have an int in slot 0, a bool in slot 0 and a float in slot 0 etc. but you can't have two ints in slot 0 instead you would do a int in slot 0 and another int in slot 1. The max slots right now are 32 - so you should pick a number between 0 and 31. An exception to this is strings which has a max slots of 4.
		`name` | The name will affect how you access it. If you call it "Foo" you would add two new functions on your entity - SetFoo and GetFoo. So be careful that what you call it won't collide with any existing functions (don't call it "Pos" for example).
		`extended` | A table of extended information. KeyName If the table contains a "KeyName" key the value can be set using Entity:SetKeyValue. This is useful if you're making an entity that you want to be loaded in a map. The sky entity uses this. Edit The edit key lets you mark this variable as editable. See Editable Entities for more information.
		
		
		___
		### Lua Examples
		#### Example 1
		Setting up data tables
		
		```lua 
		function ENT:SetupDataTables()
		
		    self:NetworkVar( "Float", 0, "Amount" )
		    self:NetworkVar( "Vector", 0, "StartPos" )
		    self:NetworkVar( "Vector", 1, "EndPos" )
		
		end
		
		-- Code...
		
		-- Setting values on the entity
		self:SetStartPos( Vector( 1, 0, 0 ) )
		self:SetAmount( 100 )
		
		-- Code...
		
		-- Getting values
		local startpos = self:GetStartPos()
		```
    **/
    
    public function NetworkVar(type:String, slot:Float, name:String, ?extended:AnyTable):Void;
    
    #if server
    /**
        Returns the blood color of this entity. This can be set with Entity:SetBloodColor.
		
		`**Returns:** Color from BLOOD_COLOR_ Enums
    **/
    
    public function GetBloodColor():BLOOD_COLOR;
    #end
    
    /**
        Returns info about given plane of non-nodraw brush model surfaces of the entity's model. Works on worldspawn as well.
		
		**Warning:** This only works on entities with brush models.
		
		Name | Description
		--- | ---
		`id` | The index of the plane to get info of. Starts from 0.
		
		
		Name | Description
		--- | ---
		`a` | The origin of the plane. This will be either the first vertex's position (if available) or the plane's normal multiplied by the plane's distance.
		`b` | The normal of the plane.
		`c` | The "distance" of the plane. The distance is the dot product of the plane's normal and the point it was initialized with.
    **/
    
    public function GetBrushPlane(id:Float):EntityGetBrushPlaneReturn;
    
    
    /**
        ***INTERNAL** 
		
		This is called internally by the Entity:NetworkVar system, you can use this in cases where using NetworkVar is not possible. 
		
		Sets the specified bool on the entity's datatable.
		
		Name | Description
		--- | ---
		`key` | Goes from 0 to 31.
		`bool` | The boolean to write on the entity's metatable.
    **/
    @:deprecated("INTERNAL")
    public function SetDTBool(key:Float, bool:Bool):Void;
    
    #if server
    /**
        This allows the entity to be lag compensated during Player:LagCompensation.
		
		**Note:** Players are lag compensated by default and there's no need to call this function for them. It's best to not enable lag compensation on parented entities, as the system does not handle it that well ( they will be moved back but then the entity will lag behind ). Parented entities move back with the parent if it's lag compensated, so if you are making some kind of armor piece you shouldn't do anything.
		
		Name | Description
		--- | ---
		`enable` | Whether the entity should be lag compensated or not.
    **/
    
    public function SetLagCompensated(enable:Bool):Void;
    #end
    
    /**
        Returns the entity's velocity.
		
		**Note:** Actually binds to CBaseEntity::GetLocalVelocity() which retrieves the velocity of the entity due to its movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision.
		
		`**Returns:** The velocity of the entity.
    **/
    
    public function GetAbsVelocity():Vector;
    
    #if server
    /**
        Move an entity down until it collides with something.
		
		**Warning:** The entity needs to already have something below it within 256 units.
		
		___
		### Lua Examples
		#### Example 1
		Move all props on the server down until they collide with something
		
		```lua 
		for _, ent in pairs( ents.FindByClass( "prop_physics" ) ) do
		    ent:DropToFloor( )
		end
		```
		
		#### Example 2
		Drops players to the ground when they spawn
		
		```lua 
		hook.Add( "PlayerSpawn", "DropGround", function( ply )
		    ply:DropToFloor()
		end )
		```
    **/
    
    public function DropToFloor():Void;
    #end
    
    /**
        Removes specified engine flag
		
		Name | Description
		--- | ---
		`flag` | The flag to remove, see EFL_ Enums
    **/
    
    public function RemoveEFlags(flag:EFL):Void;
    
    
    /**
        Returns a bit flag of all engine effect flags of the entity.
		
		`**Returns:** Engine effect flags, see EF_ Enums
    **/
    
    public function GetEffects():EF;
    
    #if server
    /**
        Whenever the entity is removed, entityToRemove will be removed also.
		
		Name | Description
		--- | ---
		`entityToRemove` | The entity to be removed
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a second chair in spawned jeeps that is removed when the jeep is removed
		
		```lua 
		hook.Add("PlayerSpawnedVehicle", "VehicleUpgrade", function(ply,vehicle)
		    if vehicle:GetClass() == "prop_vehicle_jeep" then
		        local seat = ents.Create( 'prop_vehicle_prisoner_pod' )
		        seat:SetModel( "models/nova/jeep_seat.mdl" )
		        seat:SetPos( vehicle:LocalToWorld(Vector(21,-32,18)) )
		        seat:SetAngles( vehicle:LocalToWorldAngles(Angle(0,-3.5,0)) )
		        seat:Spawn()
		        seat:SetKeyValue( "limitview", 0 )
		        table.Merge( seat, { HandleAnimation = function(_,ply) return ply:SelectWeightedSequence( ACT_HL2MP_SIT ) end } )
		        gamemode.Call( "PlayerSpawnedVehicle", ply, seat )
		        vehicle.PassengerSeat = seat
		        vehicle:DeleteOnRemove(seat) //<--
		        constraint.Weld(seat, vehicle)
		    end
		end)
		```
    **/
    
    public function DeleteOnRemove(entityToRemove:Entity):Void;
    #end
    
    /**
        Returns two vectors representing the minimum and maximum extent of the entity's bounding box.
		
		Name | Description
		--- | ---
		`a` | The minimum vector for the entity's bounding box.
		`b` | The maximum vector for the entity's bounding box.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints Entity(1)'s maximum bounding box vector.
		
		```lua 
		local min,max = Entity(1):WorldSpaceAABB()
		print(max)
		```
		**Output:**
		
		-496.828125 11730.426758 5189.393066
    **/
    
    public function WorldSpaceAABB():EntityWorldSpaceAABBReturn;
    
    
    /**
        Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNWAngle.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. (If it isn't set)
		
		
		`**Returns:** The value associated with the key
    **/
    
    public function GetNWAngle(key:String, ?fallback:Dynamic):Dynamic;
    
    #if client
    /**
        Enables or disable the inverse kinematic usage of this entity.
		
		Name | Description
		--- | ---
		`useIK` | The state of the IK.
    **/
    
    public function SetIK(?useIK:Bool):Void;
    #end
    
    /**
        Returns pose parameter range
		
		Name | Description
		--- | ---
		`id` | Pose parameter ID to look up
		
		
		Name | Description
		--- | ---
		`a` | The minimum value
		`b` | The maximum value
    **/
    
    public function GetPoseParameterRange(id:Float):EntityGetPoseParameterRangeReturn;
    
    
    /**
        Sets a networked number at the specified index on the entity.
		
		Name | Description
		--- | ---
		`index` | The index that the value is stored in.
		`number` | The value to network.
		
		
		___
		### Lua Examples
		#### Example 1
		This will set the networked number 'score' on all clients to 3.
		
		```lua 
		for k, v in pairs( player.GetAll() ) do
		    v:SetNetworkedInt( 'score', 3 )
		end
		```
    **/
    
    public function SetNetworkedNumber(index:Dynamic, number:Float):Void;
    
    
    /**
        Returns the object the entity is standing on.
		
		`**Returns:** The ground entity.
    **/
    
    public function GetGroundEntity():Entity;
    
    
    /**
        Sets the model and associated weapon to this viewmodel entity. 
		
		This is used internally when the player switches weapon.
		
		**Warning:** This will silently fail if the entity is not a viewmodel.
		
		**Note:** View models are not drawn without a weapons associated to them.
		
		Name | Description
		--- | ---
		`viewModel` | The model string to give to this viewmodel. Example: "models/weapons/c_smg1.mdl"
		`weapon` | The weapon entity to associate this viewmodel to.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the model of the second viewmodel to the smg and associates it with the player's current weapon.
		
		```lua 
		Entity( 1 ):GetViewModel( 1 ):SetWeaponModel( "models/weapons/c_smg1.mdl", Entity( 1 ):GetActiveWeapon() )
		```
		
		#### Example 2
		Initializes the extra viewmodel in Deploy and hides it again on Holster, also plays the attack animation on left and right click.
		
		```lua 
		SWEP.ViewModel = "models/weapons/v_pistol.mdl"
		SWEP.UseHands = false
		SWEP.ViewModelFlip = false    --the default viewmodel won't be flipped
		SWEP.ViewModelFlip1 = true    --the second viewmodel will
		
		
		function SWEP:Deploy()
		    --get the second viewmodel
		    local viewmodel1 = self.Owner:GetViewModel( 1 )
		    if ( IsValid( viewmodel1 ) ) then
		        --associate its weapon to us
		        viewmodel1:SetWeaponModel( self.ViewModel , self )
		    end
		    
		    self:SendViewModelAnim( ACT_VM_DEPLOY , 1 )
		    
		    return true
		end
		
		function SWEP:Holster()
		    local viewmodel1 = self.Owner:GetViewModel( 1 )
		    if ( IsValid( viewmodel1 ) ) then
		        --set its weapon to nil, this way the viewmodel won't show up again
		        viewmodel1:SetWeaponModel( self.ViewModel , nil )
		    end
		    
		    return true
		end
		
		--since self:SendWeaponAnim always sends the animation to the first viewmodel, we need this as a replacement
		function SWEP:SendViewModelAnim( act , index , rate )
		    
		    if ( not game.SinglePlayer() and not IsFirstTimePredicted() ) then
		        return
		    end
		    
		    local vm = self.Owner:GetViewModel( index )
		    
		    if ( not IsValid( vm ) ) then
		        return
		    end
		    
		    local seq = vm:SelectWeightedSequence( act )
		    
		    if ( seq == -1 ) then
		        return
		    end
		    
		    vm:SendViewModelMatchingSequence( seq )
		    vm:SetPlaybackRate( rate or 1 )
		end
		
		function SWEP:PrimaryAttack()
		    
		    self:SendViewModelAnim( ACT_VM_PRIMARYATTACK , 0 )--target the first viewmodel
		    self:SetNextPrimaryFire( CurTime() + 0.25 )
		    
		end
		
		function SWEP:SecondaryAttack()
		    
		    self:SendViewModelAnim( ACT_VM_PRIMARYATTACK , 1 )--target the second
		    self:SetNextSecondaryFire( CurTime() + 0.25 )
		    
		end
		```
    **/
    
    public function SetWeaponModel(viewModel:String, ?weapon:Weapon):Void;
    
    #if server
    /**
        Makes the entity/weapon respawn. 
		
		Only usable on HL2 pickups and any weapons. Seems to be buggy with weapons. Very unreliable.
    **/
    
    public function Respawn():Void;
    #end
    
    /**
        Returns the color the entity is set to.
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		`**Returns:** The color of the entity as a Color structure.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		for key, ply in pairs( player.GetAll( ) ) do -- Loop through all players on the server
		 local col = ply:GetColor( ); -- Gets the players color and assigns it to local variable col
		 
		 print( "Printing " .. ply:Nick() .. "'s color!" ); -- Say we are printing the players name's color
		 PrintTable( col ); -- Pass col into PrintTable to print to contents of col
		end
		```
		**Output:**
		
		Loop through all players, and print their color.
    **/
    
    public function GetColor():Color;
    
    
    /**
        Returns the number of hit box groups that an entity has.
		
		`**Returns:** number of hit box groups
		
		___
		### Lua Examples
		#### Example 1
		Prints how many hit box groups the client has
		
		```lua 
		local numHitBoxGroups = LocalPlayer():GetHitBoxGroupCount()
		print(numHitBoxGroups)
		```
    **/
    
    public function GetHitBoxGroupCount():Float;
    
    
    /**
        Reset entity sequence info such as playback rate, ground speed, last event check, etc.
    **/
    
    public function ResetSequenceInfo():Void;
    
    #if server
    /**
        Tests whether the damage passes the entity filter. 
		
		This will call ENTITY:PassesDamageFilter on scripted entities of the type "filter".
		
		**Note:** This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )
		
		Name | Description
		--- | ---
		`dmg` | The damage info to test
		
		
		`**Returns:** Whether the damage info passes the entity filter.
    **/
    
    public function PassesDamageFilter(dmg:CTakeDamageInfo):Bool;
    #end
    
    /**
        Sets if entity should create a server ragdoll on death or a client one.
		
		Name | Description
		--- | ---
		`serverragdoll` | Set true if ragdoll should be created on server, false if on client
    **/
    
    public function SetShouldServerRagdoll(serverragdoll:Bool):Void;
    
    
    /**
        Sets entity's render FX.
		
		Name | Description
		--- | ---
		`renderFX` | The new render FX to set, see kRenderFx_ Enums
    **/
    
    public function SetRenderFX(renderFX:KRenderFx):Void;
    
    
    /**
        Returns all the networked variables in an entity.
		
		`**Returns:** Key-Value table of all networked variables.
		
		___
		### Lua Examples
		#### Example 1
		Prints all NWVars that exist for Player 1.
		
		```lua 
		PrintTable( Entity(1):GetNWVarTable() )
		```
		**Output:**
		
		UserGroup	=	owner
    **/
    
    public function GetNWVarTable():AnyTable;
    
    #if server
    /**
        Returns a table containing all key values the entity has.
		
		**Note:** This only includes engine defined key values. "targetname" is not an actual key value in-engine, use Entity:GetName for that instead. For custom key values, use GM:EntityKeyValue or ENTITY:KeyValue to capture and store them.
		
		`**Returns:** A table of key values.
    **/
    
    public function GetKeyValues():AnyTable;
    #end
    
    /**
        Returns an entity's collision bounding box. In most cases, this will return the same bounding box as Entity:GetModelBounds unless the entity does not have a physics mesh or it has a PhysObj different from the default.
		
		**Bug:** BUG This can be out-of-sync between the client and server for weapons. Issue Tracker: #223
		
		Name | Description
		--- | ---
		`a` | The minimum vector of the collision bounds
		`b` | The maximum vector of the collision bounds
    **/
    
    public function GetCollisionBounds():EntityGetCollisionBoundsReturn;
    
    
    /**
        Declares that the collision rules of the entity have changed, and subsequent calls for GM:ShouldCollide with this entity may return a different value than they did previously.
		
		**Warning:** This function must not be called inside of GM:ShouldCollide. Instead, it must be called in advance when the condition is known to change.
		
		**Warning:** Failure to use this function correctly will result in a crash of the physics engine.
    **/
    
    public function CollisionRulesChanged():Void;
    
    #if server
    /**
        Applies the damage specified by the damage info to the entity.
		
		**Warning:** Calling this function on the victim entity in ENTITY:OnTakeDamage can cause infinite loops.
		
		Name | Description
		--- | ---
		`damageInfo` | The damage to apply.
		
		
		___
		### Lua Examples
		#### Example 1
		Dissolve the target into oblivion.
		
		```lua 
		function DissolveIt( ent )
		    local d = DamageInfo()
		    d:SetDamage( ent:Health() )
		    d:SetAttacker( ent )
		    d:SetDamageType( DMG_DISSOLVE )
		
		    ent:TakeDamageInfo( d )
		end
		
		DissolveIt( Entity( 1 ) )
		```
    **/
    
    public function TakeDamageInfo(damageInfo:CTakeDamageInfo):Void;
    #end
    
    /**
        Returns all flags of given entity.
		
		`**Returns:** Flags of given entity as a bitflag, see FL_ Enums
    **/
    
    public function GetFlags():FL;
    
    
    /**
        This function takes the boneID and returns the length of it in an unrounded decimal
		
		Name | Description
		--- | ---
		`boneID` | The ID of the bone you want the length of. You may want to get the length of the next bone ( boneID + 1 ) for decent results
		
		
		`**Returns:** The length of the bone
		
		___
		### Lua Examples
		#### Example 1
		Returns first bones length of first player on the server
		
		```lua 
		print( player.GetByID( 1 ):BoneLength( 1 ) )
		```
		**Output:**
		
		Returns 0
    **/
    
    public function BoneLength(boneID:Float):Float;
    
    
    /**
        Sets the ground the entity is standing on.
		
		Name | Description
		--- | ---
		`ground` | The ground entity.
		
		
		___
		### Lua Examples
		#### Example 1
		Gives all players the ability to (sort of) walk on water.
		
		```lua 
		-- shared.lua tick
		function GM:Tick()
		    
		    local trace = {}
		    local world = Entity( 0 )
		    
		    for p, ply in pairs( player.GetAll() ) do
		    
		        trace = util.TraceLine( {
		            start = ply:GetPos() + Vector( 0, 0, 72),
		            endpos = ply:GetPos() + Vector( 0, 0, -3 ),
		            mask = MASK_WATER,
		            filter = function( ent ) return true end
		        } )
		        
		        if( trace.Hit ) then
		            ply:SetGravity( 0.0001 )
		            ply:SetGroundEntity( world )
		        else
		            ply:SetGravity( 1.0 )
		        end
		        
		    end
		    
		end
		```
    **/
    
    public function SetGroundEntity(ground:Entity):Void;
    
    #if client
    /**
        Removes the shadow for the entity. 
		
		The shadow will be recreated as soon as the entity wakes. 
		
		 Doesn't affect shadows from flashlight/lamps/env_projectedtexture.
    **/
    
    public function DestroyShadow():Void;
    #end
    
    /**
        Scales the model of the entity, if the entity is a Player or an NPC the hitboxes will be scaled as well. 
		
		For some entities, calling Entity:Activate after this will scale the collision bounds and PhysObj as well; be wary as there's no optimization being done internally and highly complex collision models might crash the server. 
		
		 This is the same system used in TF2 for the Mann Vs Machine robots. 
		
		 To resize the entity along any axis, use Entity:EnableMatrix instead. 
		
		 If your old scales are wrong due to a recent update, use Entity:SetLegacyTransform as a quick fix.
		
		**Bug:** BUG The hull does not scale properly with this function. Issue Tracker: #2193
		
		**Bug:** BUG This does not scale procedural bones and disables IK. Issue Tracker: #3502
		
		Name | Description
		--- | ---
		`scale` | A float to scale the model by. 0 will not draw anything. < 0 will draw the model inverted.
		`deltaTime` | Transition time of the scale change, set to 0 to modify the scale right away.
		
		
		___
		### Lua Examples
		#### Example 1
		From the "Biggify" option of right clicking an npc
		
		```lua 
		ent:SetModelScale( ent:GetModelScale() * 1.25, 1 )
		```
    **/
    
    public function SetModelScale(scale:Float, ?deltaTime:Float):Void;
    
    
    /**
        Returns the boneID of the bone the given PhysObj is attached to. 
		
		See Entity:TranslateBoneToPhysBone for reverse function.
		
		Name | Description
		--- | ---
		`physNum` | The PhysObj number on the entity
		
		
		`**Returns:** The boneID of the bone the PhysObj is attached to.
		
		___
		### Lua Examples
		#### Example 1
		Does a trace, gets the physics bone from the trace, converts the physics bone number into the bone number and prints the result
		
		```lua 
		local tr = LocalPlayer():GetEyeTrace()
		local bone = tr.Entity:TranslatePhysBoneToBone( tr.PhysicsBone )
		print( bone )
		```
		**Output:**
		
		The bone number of what the client is looking at
    **/
    
    public function TranslatePhysBoneToBone(physNum:Float):Float;
    
    
    /**
        ***Deprecated:** You should use Entity: SetNWBool instead.
		
		Sets a networked boolean value at specified index on the entity. 
		
		The value then can be accessed with Entity:GetNetworkedBool both from client and server.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on.
		
		Name | Description
		--- | ---
		`key` | The key to associate the value with
		`value` | The value to set
    **/
    @:deprecated("You should use Entity: SetNWBool instead.")
    public function SetNetworkedBool(key:String, ?value:Bool):Void;
    
    
    /**
        Sets local position relative to the parented position. This is for use with Entity:SetParent to offset position.
		
		Name | Description
		--- | ---
		`pos` | The local position
    **/
    
    public function SetLocalPos(pos:Vector):Void;
    
    
    /**
        Removes all decals from the entities surface.
		
		___
		### Lua Examples
		#### Example 1
		Removes all decals from all props in world.
		
		```lua 
		for k, v in pairs( ents.FindByClass( "prop_physics" )) do
		    v:RemoveAllDecals()
		end
		```
    **/
    
    public function RemoveAllDecals():Void;
    
    
    /**
        Returns the bitwise spawn flags used by the entity.
		
		`**Returns:** The spawn flags of the entity, see SF_Enums.
		
		___
		### Lua Examples
		#### Example 1
		An alternative to Entity:HasSpawnFlags
		
		```lua 
		local sf = ent:GetSpawnFlags()
		
		if( bit.band( sf, SF_PHYSPROP_PREVENT_PICKUP ) > 0 ) then
		    print( "This prop cannot be picked up." )
		end
		```
    **/
    
    public function GetSpawnFlags():Float;
    
    
    /**
        Returns the amount of hitbox sets in the entity.
		
		`**Returns:** The amount of hitbox sets in the entity.
    **/
    
    public function GetHitboxSetCount():Float;
    
    
    /**
        Sets the flex scale of the entity.
		
		**Bug:** BUG This does not work on ClientsideModels or ClientsideRagdolls. Issue Tracker: #1779
		
		Name | Description
		--- | ---
		`scale` | The new flex scale to set to
    **/
    
    public function SetFlexScale(scale:Float):Void;
    
    
    /**
        Sets an entities' bodygroup.
		
		Name | Description
		--- | ---
		`bodygroup` | The id of the bodygroup you're setting. Starts from 0.
		`value` | The value you're setting the bodygroup to. Starts from 0.
    **/
    
    public function SetBodygroup(bodygroup:Float, value:Float):Void;
    
    #if server
    /**
        Sets the layer playback rate. See also Entity:SetLayerDuration.
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`rate` | The new playback rate.
    **/
    
    public function SetLayerPlaybackRate(layerID:Float, rate:Float):Void;
    #end
    #if server
    /**
        Applies forces to our physics object in response to damage.
		
		Name | Description
		--- | ---
		`dmginfo` | The damageinfo to apply. Only CTakeDamageInfo: GetDamageForce and CTakeDamageInfo: GetDamagePosition are used.
    **/
    
    public function TakePhysicsDamage(dmginfo:CTakeDamageInfo):Void;
    #end
    
    /**
        Alter the model name returned by Entity:GetModel. Does not affect the entity's actual model.
		
		Name | Description
		--- | ---
		`modelname` | The new model name.
    **/
    
    public function SetModelName(modelname:String):Void;
    
    
    /**
        Returns the time the entity was created on, relative to CurTime.
		
		`**Returns:** The time the entity was created on.
    **/
    
    public function GetCreationTime():Float;
    
    
    /**
        Returns sequence ID corresponding to given activity ID. 
		
		Opposite of Entity:GetSequenceActivity. 
		
		 Similar to Entity:LookupSequence. 
		
		 See also Entity:SelectWeightedSequenceSeeded.
		
		Name | Description
		--- | ---
		`act` | The activity ID, see ACT_ Enums.
		
		
		`**Returns:** The sequence ID
		
		___
		### Lua Examples
		#### Example 1
		Use this hook to check if the model has a certain ACT_* enumeration, and if it does, play it.
		
		```lua 
		local VModel = self.Owner:GetViewModel()
		
		if ( self:Clip1() == 0 and VModel:SelectWeightedSequence( ACT_VM_RELOAD_EMPTY ) ) then
		
		    local SEQ = self:LookupSequence( ACT_VM_RELOAD_EMPTY )
		
		    if ( SEQ == -1 ) then
		
		        print( "reload" )
		
		        local EnumToSeq = VModel:SelectWeightedSequence( ACT_VM_RELOAD )
		
		        --    Play the normal reload animation
		        VModel:SendViewModelMatchingSequence( EnumToSeq )
		
		    else
		
		        print( "reload empty" )
		
		        local EnumToSeq = VModel:SelectWeightedSequence( ACT_VM_RELOAD_EMPTY )
		
		        -- Play the empty reload animation
		        VModel:SendViewModelMatchingSequence( EnumToSeq )
		        
		    end
		
		end
		```
		**Output:**
		
		Will play the ACT_VM_RELOAD_EMPTY enumeration if the model has it. If not, it will play the normal reload enum.
    **/
    
    public function SelectWeightedSequence(act:ACT):Float;
    
    #if server
    /**
        
		
		**Note:** This function only works on BaseAnimatingOverlay entites!
		
		Name | Description
		--- | ---
		`layerID` | The Layer ID
		`blendIn` | 
    **/
    
    public function SetLayerBlendIn(layerID:Float, blendIn:Float):Void;
    #end
    
    /**
        Returns the entity's model render bounds. By default this will return the same bounds as Entity:GetModelBounds.
		
		Name | Description
		--- | ---
		`a` | The minimum vector of the bounds
		`b` | The maximum vector of the bounds
    **/
    
    public function GetModelRenderBounds():EntityGetModelRenderBoundsReturn;
    
    
    /**
        Adds solid flag(s) to the entity.
		
		Name | Description
		--- | ---
		`flags` | The flag(s) to apply, see FSOLID_ Enums.
    **/
    
    public function AddSolidFlags(flags:FSOLID):Void;
    
    #if server
    /**
        Returns true if supplied vector is visible from the entity's line of sight. 
		
		This is achieved similarly to a trace.
		
		Name | Description
		--- | ---
		`pos` | The position to check for visibility
		
		
		`**Returns:** Within line of sight
    **/
    
    public function VisibleVec(pos:Vector):Bool;
    #end
    
    /**
        Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNWVector.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. (If it isn't set)
		
		
		`**Returns:** The value associated with the key
    **/
    
    public function GetNWVector(key:String, ?fallback:Dynamic):Dynamic;
    
    #if client
    /**
        Returns whether this entity is predictable or not. 
		
		See Entity:SetPredictable for more information
		
		`**Returns:** Whether this entity is predictable or not.
    **/
    
    public function GetPredictable():Bool;
    #end
    
    /**
        Causes the entity to break into its current models gibs, if it has any. 
		
		You must call Entity:PrecacheGibs on the entity before using this function, or it will not create any gibs. 
		
		 The gibs will be spawned on the server and be synchronized with all clients. 
		
		 Note, that this function will not remove or hide the entity it is called on.
		
		**Warning:** Large numbers of serverside gibs will cause lag. You can avoid this cost by spawning the gibs on the client using Entity:GibBreakClient
		
		**Note:** Despite existing on client, it doesn't actually do anything on client.
		
		Name | Description
		--- | ---
		`force` | The force to apply to the created gibs
    **/
    
    public function GibBreakServer(force:Vector):Void;
    
    
    /**
        Add a callback function to a specific event. This is used instead of hooks to avoid calling empty functions unnecessarily. 
		
		This also allows you to use certain hooks in engine entities (non-scripted entities).
		
		**Warning:** This method does not check if the function has already been added to this object before, so if you add the same callback twice, it will be run twice! Make sure to add your callback only once.
		
		Name | Description
		--- | ---
		`hook` | The hook name to hook onto. See Entity Callbacks
		`func` | The function to call
		
		
		`**Returns:** The callback ID that was just added, which can later be used in Entity:RemoveCallback. Returns nothing if the passed callback function was invalid or when asking for a non-existent hook.
		
		___
		### Lua Examples
		#### Example 1
		Adds a callback to an entity which is called every time the entity angles change.
		
		```lua 
		myentity:AddCallback( "OnAngleChange", function( entity, newangle )
		    -- Do stuff
		end )
		```
		
		#### Example 2
		Creates watermelon prop which creates sparks on collision point whenever touches something.
		
		```lua 
		local melon = ents.Create( "prop_physics" ) -- Spawn prop
		if ( !IsValid( melon ) ) then return end -- Safety first
		melon:SetModel( "models/props_junk/watermelon01.mdl" ) -- Set watermelon model
		melon:SetPos( Entity(1):GetEyeTrace().HitPos ) -- Set pos where is player looking
		melon:Spawn() -- Instantiate prop
		
		local function PhysCallback( ent, data ) -- Function that will be called whenever collision happends
		    local effect = EffectData() -- Create effect data
		    effect:SetOrigin( data.HitPos ) -- Set origin where collision point is
		    util.Effect( "cball_bounce", effect ) -- Spawn small sparky effect
		end
		melon:AddCallback( "PhysicsCollide", PhysCallback ) -- Add Callback
		```
    **/
    
    public function AddCallback(hook:String, func:Function):Float;
    
    
    /**
        Advances the cycle of an animated entity. 
		
		Animations that loop will automatically reset the cycle so you don't have to - ones that do not will stop animating once you reach the end of their sequence.
		
		Name | Description
		--- | ---
		`interval` | How many seconds to advance the cycle. Set to 0 to let the engine calculate this for you based on CurTime.
		
		
		___
		### Lua Examples
		#### Example 1
		From DModelPanel
		
		```lua 
		function PANEL:RunAnimation()
		    self.Entity:FrameAdvance( (RealTime()-self.LastPaint) * self.m_fAnimSpeed )    
		end
		```
		**Output:**
		
		Animates the entity
    **/
    
    public function FrameAdvance(interval:Float):Void;
    
    
    /**
        Returns the material override for the given index. 
		
		Returns "" if no material override exists. Use Entity:GetMaterials to list it's default materials.
		
		**Bug:** BUG The server's value takes priority on the client. Issue Tracker: #3362
		
		Name | Description
		--- | ---
		`index` | The index of the sub material. Acceptable values are from 0 to 31.
		
		
		`**Returns:** The material that overrides this index, if any.
    **/
    
    public function GetSubMaterial(index:Float):String;
    
    
    /**
        Returns the classname of a entity. This is often the name of the Lua file or folder containing the files for the entity
		
		`**Returns:** The entity's classname
		
		___
		### Lua Examples
		#### Example 1
		Prints the classname of the weapon that the player is holding.
		
		```lua 
		print( LocalPlayer( ):GetActiveWeapon( ):GetClass( ) )
		```
		**Output:**
		
		Prints the classname of the weapon that the player is holding. (ie weapon_crowbar)
    **/
    
    public function GetClass():String;
    
    
    /**
        Returns solid type of an entity.
		
		`**Returns:** The solid type. See the SOLID_ Enums.
    **/
    
    public function GetSolid():SOLID;
    
    #if server
    /**
        Returns the entity's ground speed velocity, which is based on the entity's walk/run speed and/or the ground speed of their sequence ( Entity:GetSequenceGroundSpeed ). Will return an empty Vector if the entity isn't moving on the ground.
		
		`**Returns:** The ground speed velocity.
    **/
    
    public function GetGroundSpeedVelocity():Vector;
    #end
    
    /**
        Adds engine flags.
		
		Name | Description
		--- | ---
		`flag` | Engine flag to add, see EFL_ Enums
    **/
    
    public function AddEFlags(flag:EFL):Void;
    
    
    /**
        Returns whether the entity is a valid entity or not. 
		
		An entity is valid if:
		
		**Warning:** NULL entities can still be assigned with key/value pairs, but they will be instantly negated. See example 3
		
		`**Returns:** true if the entity is valid, false otherwise
		
		___
		### Lua Examples
		#### Example 1
		Shows how to use the global IsValid function instead of using this method directly.
		
		```lua 
		if ( entity && entity:IsValid() ) then
		    -- Do stuff
		end
		
		-- The above can be replaced with the following for the same effect (and cleaner code)
		
		if ( IsValid( entity ) ) then
		    -- Do stuff
		end
		```
		
		#### Example 2
		
		
		```lua 
		print( LocalPlayer():IsValid() )
		```
		**Output:**
		
		Outputs 'true' to the console if the player is in-game.
		
		#### Example 3
		
		
		```lua 
		local newPlayer = net.ReadEntity() --server found a new player on the server and sent it to us after 
		print( "1/4" )              -- it determined it was valid (newPlayer is NULL in this realm)
		
		if not isnumber(newPlayer.ImportantGameData) then --If it doesn't have a specific field, assign a value to it
		    print( "2/4" )
		    newPlayer.ImportantGameData = 42 
		end
		print( "3/4" )
		
		print( newPlayer.ImportantGameData * 69 ) --Attempting to do arithmetics on the new field
		print( "4/4" )
		```
		**Output:**
		
		1/4 ... 3/4 A lua error telling us 'ImportantGameData' is a nil value and thus can't perform math on it But this shouldn't be possible, because we just created a value there. No red flags are present up until this point; all code up until this will run fine. Make sure to add an IsValid() check when the seemingly impossible happens.
    **/
    
    public function IsValid():Bool;
    
    #if server
    /**
        ***INTERNAL** 
		
		Dispatches blocked events to this entity's blocked handler. This function is only useful when interacting with entities like func_movelinear.
		
		Name | Description
		--- | ---
		`entity` | The entity that is blocking us
    **/
    @:deprecated("INTERNAL")
    public function Blocked(entity:Entity):Void;
    #end
    #if client
    /**
        Forces the entity to reconfigure its bones. You might need to call this after changing your model's scales or when manually drawing the entity multiple times at different positions.
		
		**Note:** This calls the BuildBonePositions callback added via Entity:AddCallback, so avoid calling this function inside it to prevent an infinite loop.
    **/
    
    public function SetupBones():Void;
    #end
    
    /**
        ***Deprecated:** You should use Entity: GetNWVector instead.
		
		Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNetworkedVector.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. ( If it isn't set )
		
		
		`**Returns:** The retrieved value
    **/
    @:deprecated("You should use Entity: GetNWVector instead.")
    public function GetNetworkedVector(key:String, ?fallback:Vector):Vector;
    
    #if server
    /**
        ***Deprecated:** You should use Entity: GetHitBoxBone instead.
    **/
    @:deprecated("You should use Entity: GetHitBoxBone instead.")
    public function GetHitboxBone():Void;
    #end
    
    /**
        Initializes the physics mesh of the entity with a convex mesh defined by a table of points. The resulting mesh is the convex hull of all the input points. If successful, the previous physics object will be removed. 
		
		This is the standard way of creating moving physics objects with a custom convex shape. For more complex, concave shapes, see Entity:PhysicsInitMultiConvex.
		
		**Bug:** BUG This will crash if given all Vector(0,0,0)s. Issue Tracker: #3301
		
		**Bug:** BUG Clientside physics objects are broken and do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
		
		Name | Description
		--- | ---
		`points` | A table of eight Vectors, in local coordinates, to be used in the computation of the convex mesh. Order does not matter.
		
		
		`**Returns:** Returns true on success, nil otherwise.
		
		___
		### Lua Examples
		#### Example 1
		Creates a "box" physics mesh for the entity.
		
		```lua 
		function ENT:Initialize()
		    if ( CLIENT ) then return end -- We only want to run this code serverside
		
		    local x0 = -20 -- Define the min corner of the box
		    local y0 = -10
		    local z0 = -5
		
		    local x1 = 20 -- Define the max corner of the box
		    local y1 = 10
		    local z1 = 5
		
		    self:PhysicsInitConvex( {
		        Vector( x0, y0, z0 ),
		        Vector( x0, y0, z1 ),
		        Vector( x0, y1, z0 ),
		        Vector( x0, y1, z1 ),
		        Vector( x1, y0, z0 ),
		        Vector( x1, y0, z1 ),
		        Vector( x1, y1, z0 ),
		        Vector( x1, y1, z1 )
		    } )
		
		    -- Set up solidity and movetype
		    self:SetMoveType( MOVETYPE_VPHYSICS )
		    self:SetSolid( SOLID_VPHYSICS )
		
		    -- Enable custom collisions on the entity
		    self:EnableCustomCollisions( true )
		end
		```
    **/
    
    public function PhysicsInitConvex(points:AnyTable):Bool;
    
    
    /**
        Gets how many hit boxes are in a given hit box group
		
		Name | Description
		--- | ---
		`group` | The number of the hit box group
		
		
		`**Returns:** The number of hit boxes.
		
		___
		### Lua Examples
		#### Example 1
		Will print out how many hit boxes the client has in each of their hit box groups
		
		```lua 
		local numHitBoxGroups = LocalPlayer():GetHitBoxGroupCount()
		
		for i=0, numHitBoxGroups - 1 do
		  local numHitBoxes = LocalPlayer():GetHitBoxCount( i )
		  print("Hit box group " .. i .. " has " .. numHitBoxes .. " hit boxes!")
		end
		```
		**Output:**
		
		"Hit box group 0 has 17 hit boxes!"
    **/
    
    public function GetHitBoxCount(group:Float):Float;
    
    #if server
    /**
        Sets the entity to be used as the light origin position for this entity.
		
		Name | Description
		--- | ---
		`lightOrigin` | The lighting entity.
    **/
    
    public function SetLightingOriginEntity(lightOrigin:Entity):Void;
    #end
    #if server
    /**
        Returns an entity's sequence move distance (the change in position over the course of the entire sequence).
		
		Name | Description
		--- | ---
		`sequenceId` | The sequence index.
		
		
		`**Returns:** The move distance of the sequence.
		
		___
		### Lua Examples
		#### Example 1
		Experiment which demonstrates that dividing the sequence move distance by Entity:SequenceDuration results in a value extremely close to Entity:GetSequenceGroundSpeed.
		
		```lua 
		local ply, seq, move_dist, seq_dur, ground_speed = nil, nil, nil, nil, nil
		
		function GM:Think()
		
		    -- Player 1
		    ply = Entity(1)
		    
		    -- Current sequence
		    seq = ply:GetSequence()
		    
		    -- The move distance
		    move_dist = ply:GetSequenceMoveDist(seq)
		    
		    if(move_dist == 0) then return end    -- If it doesn't move, don't bother
		    
		    -- The sequence duration
		    seq_dur = ply:SequenceDuration(seq)
		    
		    -- Actual sequence ground speed
		    ground_speed = ply:GetSequenceGroundSpeed(seq)
		    
		    -- Compare the calculated value to the actual value
		    print(tostring(ground_speed-(move_dist/seq_dur)))
		
		end
		```
		**Output:**
		
		A sample of some of the calculated vs. actual value differences during a sprint forward followed by an abrupt stop. -3.3345255872064e-006
		3.3614563506035e-006
		0
		1.557984873557e-006
    **/
    
    public function GetSequenceMoveDist(sequenceId:Float):Float;
    #end
    
    /**
        Returns the entity's physics object, if the entity has physics.
		
		**Note:** Entities don't have clientside physics objects by default, so this will return [NULL PHYSOBJ] on the client in most cases.
		
		`**Returns:** The entity's physics object.
		
		___
		### Lua Examples
		#### Example 1
		Gets the mass of an entity.
		
		```lua 
		local phys = ent:GetPhysicsObject()
		if ( IsValid( phys ) ) then -- Always check with IsValid! The ent might not have physics!
		    return phys:GetMass()
		else
		    return 0
		end
		```
    **/
    
    public function GetPhysicsObject():PhysObj;
    
    
    /**
        Returns the upward vector of the entity, as a normalized direction vector
		
		`**Returns:** upDir
    **/
    
    public function GetUp():Vector;
    
    #if server
    /**
        Sets the entity on fire.
		
		Name | Description
		--- | ---
		`length` | How long to keep the entity ignited. Not supplying this argument will not ignite the entity at all.
		`radius` | The radius of the ignition, will ignite everything around the entity that is in this radius.
		
		
		___
		### Lua Examples
		#### Example 1
		Ignite all props on the map for 30 seconds.
		
		```lua 
		for k, v in pairs(ents.FindByClass("prop_physics")) do
		   v:Ignite(30)
		end
		```
    **/
    
    public function Ignite(length:Float, ?radius:Float):Void;
    #end
    
    /**
        ***Deprecated:** You should use Entity: GetNWBool instead.
		
		Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNetworkedBool.
		
		Name | Description
		--- | ---
		`key` | The key that is associated with the value
		`fallback` | The value to return if we failed to retrieve the value. ( If it isn't set )
		
		
		`**Returns:** The retrieved value
    **/
    @:deprecated("You should use Entity: GetNWBool instead.")
    public function GetNetworkedBool(key:String, ?fallback:Bool):Bool;
    
    
    /**
        Sets the color of an entity.
		
		Name | Description
		--- | ---
		`color` | The color to set. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Loop through all players, make them black
		
		```lua 
		local colBlack = Color( 0, 0, 0, 255 ) -- Creates a black color
		for key, ply in pairs(player.GetAll()) do -- Loop through all players on the server
		    ply:SetColor(colBlack) -- Sets the players color to colBlack
		end
		```
		
		#### Example 2
		Creates a wooden crate at 0,0,0 and turns it a transparent green
		
		```lua 
		local ent = ents.Create("prop_physics")
		ent:SetPos(Vector(0,0,0))
		ent:SetModel("models/props_junk/wood_crate001a.mdl")
		ent:Spawn()
		
		ent:SetColor( Color( 0, 255, 0, 230 ) ) 
		ent:SetRenderMode( RENDERMODE_TRANSALPHA ) -- You need to set the render mode on some entities in order for the color to change
		```
    **/
    
    public function SetColor(?color:Color):Void;
    
    
    /**
        Returns the health of the entity.
		
		`**Returns:** health
		
		___
		### Lua Examples
		#### Example 1
		Prints if the entity's health is at full or more.
		
		```lua 
		print( Entity( 1 ):Health() >= Entity( 1 ):GetMaxHealth() )
		```
		**Output:**
		
		"true" entity's health is greater than or equal to their max health, or "false" otherwise.
    **/
    
    public function Health():Float;
    
    #if server
    /**
        Sets the function to build the ragdoll. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
    **/
    
    public function RagdollStopControlling():Void;
    #end
    
    /**
        Calls and returns WEAPON:TranslateActivity on the weapon the entity ( player or NPC ) carries. 
		
		Despite existing on client, it doesn't actually do anything on client.
		
		Name | Description
		--- | ---
		`act` | The activity to translate
		
		
		`**Returns:** The translated activity
    **/
    
    public function Weapon_TranslateActivity(act:Float):Float;
    
    
    /**
        Returns flex name.
		
		Name | Description
		--- | ---
		`id` | The flex id to look up name of
		
		
		`**Returns:** The flex name
    **/
    
    public function GetFlexName(id:Float):String;
    
    
    /**
        Returns the pose parameter value
		
		**Warning:** This value will be from 0 - 1 on the client and from minimum range to maximum range on the server! You'll have to remap this value clientside to Entity:GetPoseParameterRange's returns if you want get the actual pose parameter value. See Entity:SetPoseParameter's example.
		
		Name | Description
		--- | ---
		`name` | Pose parameter name to look up
		
		
		`**Returns:** Value of given pose parameter. WARNING This value will be from 0 - 1 on the client and from minimum range to maximum range on the server! You'll have to remap this value clientside to Entity:GetPoseParameterRange's returns if you want get the actual pose parameter value. See Entity:SetPoseParameter's example.
    **/
    
    public function GetPoseParameter(name:String):Float;
    
    
}


@:multiReturn extern class EntityWorldSpaceAABBReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class EntityLookupSequenceReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class EntityGetSequenceMovementReturn {
var a:Bool;
var b:Vector;
var c:Angle;

}
@:multiReturn extern class EntityGetRotatedAABBReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class EntityGetRenderBoundsReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class EntityGetPoseParameterRangeReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class EntityGetModelRenderBoundsReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class EntityGetModelBoundsReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class EntityGetHitboxSetReturn {
var a:Float;
var b:String;

}
@:multiReturn extern class EntityGetHitBoxBoundsReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class EntityGetFlexBoundsReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class EntityGetConstrainedPhysObjectsReturn {
var a:PhysObj;
var b:PhysObj;

}
@:multiReturn extern class EntityGetConstrainedEntitiesReturn {
var a:Entity;
var b:Entity;

}
@:multiReturn extern class EntityGetCollisionBoundsReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class EntityGetBrushPlaneReturn {
var a:Vector;
var b:Vector;
var c:Float;

}
@:multiReturn extern class EntityGetBonePositionReturn {
var a:Vector;
var b:Angle;

}

