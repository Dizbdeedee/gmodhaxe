package gmod.gclass;


/**
    This is the object returned by Entity:GetPhysicsObject and Entity:GetPhysicsObjectNum. 
	
	It represents a physics object.
**/
extern class PhysObj {
    
    /**
        Sets whether the physobject should be able to move or not. 
		
		This is the exact method the Physics Gun uses to freeze props. If a motion-disabled physics object is grabbed with the physics gun, the object will be able to move again. To disallow this, use GM:PhysgunPickup.
		
		Name | Description
		--- | ---
		`enable` | True to enable, false to disable.
    **/
    
    public function EnableMotion(enable:Bool):Void;
    
    
    /**
        Calculates the force and torque on the center of mass for an offset force impulse. The outputs can be directly passed to PhysObj:ApplyForceCenter and PhysObj:ApplyTorqueCenter, respectively.
		
		Name | Description
		--- | ---
		`force` | The initial force
		`pos` | The location of the force in world coordinates
		
		
		Name | Description
		--- | ---
		`a` | The calculated force on the physics object's center of mass
		`b` | The calculated torque on the physics object's center of mass
    **/
    
    public function CalculateForceOffset(force:Vector, pos:Vector):PhysObjCalculateForceOffsetReturn;
    
    
    /**
        Returns the linear and angular damping of the physics object.
		
		Name | Description
		--- | ---
		`a` | The linear damping
		`b` | The angular damping
    **/
    
    public function GetDamping():PhysObjGetDampingReturn;
    
    
    /**
        Returns the absolute directional velocity of the physobject.
		
		`**Returns:** velocity
    **/
    
    public function GetVelocity():Vector;
    
    
    /**
        Returns the mins and max of the physics object.
		
		Name | Description
		--- | ---
		`a` | Mins
		`b` | Maxs
    **/
    
    public function GetAABB():PhysObjGetAABBReturn;
    
    
    /**
        Returns the position and angle of the physics object as a 3x4 matrix (VMatrix is 4x4 so the fourth row goes unused). The first three columns store the angle as a rotation matrix, and the fourth column stores the position vector.
		
		`**Returns:** The position and angle matrix.
    **/
    
    public function GetPositionMatrix():VMatrix;
    
    
    /**
        Sets the linear and angular damping of the physics object.
		
		Name | Description
		--- | ---
		`linearDamping` | Linear damping.
		`angularDamping` | Angular damping.
    **/
    
    public function SetDamping(linearDamping:Float, angularDamping:Float):Void;
    
    
    /**
        Call this when the collision filter conditions change due to this object's state (e.g. changing solid type or collision group)
    **/
    
    public function RecheckCollisionFilter():Void;
    
    
    /**
        Returns if the physics object can move itself (by velocity, acceleration)
		
		`**Returns:** motionEnabled
    **/
    
    public function IsMotionEnabled():Bool;
    
    
    /**
        Sets the velocity of the physics object for the next iteration.
		
		Name | Description
		--- | ---
		`velocity` | The new velocity of the physics object.
    **/
    
    public function SetVelocity(velocity:Vector):Void;
    
    
    /**
        Rotate a vector from the world frame to the local frame of the physics object.
		
		**Note:** This function only rotates the vector, without any translation operation.
		
		Name | Description
		--- | ---
		`WorldVec` | A vector in the world frame
		
		
		`**Returns:** The corresponding vector relative to the PhysObj
    **/
    
    public function WorldToLocalVector(WorldVec:Vector):Vector;
    
    
    /**
        Returns the parent entity of the physics object.
		
		`**Returns:** parent
    **/
    
    public function GetEntity():Entity;
    
    
    /**
        Returns the rotation damping of the physics object.
		
		`**Returns:** The rotation damping
    **/
    
    public function GetRotDamping():Float;
    
    
    /**
        Returns the angles of the physics object.
		
		`**Returns:** The angles of the physics object.
    **/
    
    public function GetAngles():Angle;
    
    
    /**
        Modifies how much drag (air resistance) affects the object.
		
		Name | Description
		--- | ---
		`drag` | The drag coefficient It can be positive or negative.
    **/
    
    public function SetDragCoefficient(drag:Float):Void;
    
    
    /**
        Returns the name of the physics object.
		
		`**Returns:** The name of the physics object.
    **/
    
    public function GetName():String;
    
    
    /**
        Returns the position of the PhysObj shadow. See PhysObj:UpdateShadow.
		
		`**Returns:** The position of the PhysObj shadow.
    **/
    
    public function GetShadowPos():Vector;
    
    
    /**
        Sets whether the physics object should collide with anything or not, including world.
		
		**Warning:** This function currently has major problems with player collisions, and as such should be avoided at all costs. A better alternative to this function would be using Entity:SetCollisionGroup( COLLISION_GROUP_WORLD ).
		
		Name | Description
		--- | ---
		`enable` | True to enable, false to disable.
    **/
    
    public function EnableCollisions(enable:Bool):Void;
    
    
    /**
        Sets whether the PhysObject should be affected by gravity
		
		Name | Description
		--- | ---
		`enable` | True to enable, false to disable.
    **/
    
    public function EnableGravity(enable:Bool):Void;
    
    
    /**
        Sets the material of the physobject.
		
		**Note:** Impact sounds will only change if this is called on client
		
		Name | Description
		--- | ---
		`materialName` | The name of the phys material to use. From this list: Valve Developer
		
		
		___
		### Lua Examples
		#### Example 1
		Randomize the physical properties of an entity
		
		```lua 
		local tbl = {
		    "gmod_ice", -- Makes the entity slide around
		    "gmod_bouncy", -- Makes the entity bouncy
		    "gmod_silent", -- Makes the entity not play sounds on impact
		    "flesh" -- Makes the entity play flesh sounds on impact
		}
		
		local phys = SomeEntity:GetPhysicsObject()
		
		if ( IsValid( phys ) ) then
		
		    phys:SetMaterial( table.Random( tbl ) )
		
		end
		```
    **/
    
    public function SetMaterial(materialName:String):Void;
    
    
    /**
        Adds the specified velocity to the current.
		
		Name | Description
		--- | ---
		`angularVelocity` | Additional velocity.
    **/
    
    public function AddAngleVelocity(angularVelocity:Vector):Void;
    
    
    /**
        Returns whenever the physics object is penetrating another physics object. 
		
		This is internally implemented as
		
		`**Returns:** Whether the physics object is penetrating another object.
    **/
    
    public function IsPenetrating():Bool;
    
    
    /**
        Returns whenever the entity is able to move.
		
		`**Returns:** movable
    **/
    
    public function IsMoveable():Bool;
    
    #if server
    /**
        Returns the stress of the entity.
		
		`**Returns:** exertedStress
    **/
    
    public function GetStress():Float;
    #end
    
    /**
        Returns the position of the physics object.
		
		`**Returns:** The position
    **/
    
    public function GetPos():Vector;
    
    
    /**
        Returns the physical material of the physics object.
		
		`**Returns:** The physical material
    **/
    
    public function GetMaterial():String;
    
    
    /**
        Sets the mass of the physics object.
		
		Name | Description
		--- | ---
		`mass` | The mass in kilograms.
    **/
    
    public function SetMass(mass:Float):Void;
    
    
    /**
        Allows you to move a PhysObj to a point and angle in 3D space.
		
		Name | Description
		--- | ---
		`shadowparams` | The parameters for the shadow. See example code to see how its used.
		
		
		___
		### Lua Examples
		#### Example 1
		Move a PhysObj to vector 0 0 0 with angles 0 0 0.
		
		```lua 
		function ENT:Initialize()
		 
		    self:StartMotionController()
		    self.ShadowParams = {}
		 
		end
		function ENT:PhysicsSimulate( phys, deltatime )
		 
		    phys:Wake()
		 
		    self.ShadowParams.secondstoarrive = 1 // How long it takes to move to pos and rotate accordingly - only if it could move as fast as it want - damping and max speed/angular will make this invalid (Cannot be 0! Will give errors if you do)
		    self.ShadowParams.pos = Vector( 0, 0, 0 ) // Where you want to move to
		    self.ShadowParams.angle = Angle( 0, 0, 0 ) // Angle you want to move to
		    self.ShadowParams.maxangular = 5000 //What should be the maximal angular force applied
		    self.ShadowParams.maxangulardamp = 10000 // At which force/speed should it start damping the rotation
		    self.ShadowParams.maxspeed = 1000000 // Maximal linear force applied
		    self.ShadowParams.maxspeeddamp = 10000// Maximal linear force/speed before  damping
		    self.ShadowParams.dampfactor = 0.8 // The percentage it should damp the linear/angular force if it reaches it's max amount
		    self.ShadowParams.teleportdistance = 200 // If it's further away than this it'll teleport (Set to 0 to not teleport)
		    self.ShadowParams.deltatime = deltatime // The deltatime it should use - just use the PhysicsSimulate one
		 
		    phys:ComputeShadowControl(self.ShadowParams)
		 
		end
		```
    **/
    
    public function ComputeShadowControl(shadowparams:AnyTable):Void;
    
    
    /**
        Mapping a vector in local frame of the physics object to world frame.
		
		**Note:** this function does translation and rotation, with translation done first.
		
		Name | Description
		--- | ---
		`LocalVec` | A vector in the physics object's local frame
		
		
		`**Returns:** The corresponding vector in world frame
    **/
    
    public function LocalToWorld(LocalVec:Vector):Vector;
    
    
    /**
        Removes one of more specified flags.
		
		Name | Description
		--- | ---
		`flags` | Bitflag, see FVPHYSICS_ Enums.
    **/
    
    public function ClearGameFlag(flags:FVPHYSICS):Void;
    
    
    /**
        Returns whether the physics object is "sleeping". 
		
		See PhysObj:Sleep for more information.
		
		`**Returns:** Whether the physics object is sleeping.
    **/
    
    public function IsAsleep():Bool;
    
    
    /**
        Applies the specified force on the physics object at the specified position
		
		Name | Description
		--- | ---
		`force` | The force to be applied.
		`position` | The position in world coordinates where the force is applied to the physics object.
		
		
		___
		### Lua Examples
		#### Example 1
		Pull what the player is looking at towards him.
		
		```lua 
		local tr = Entity(1):GetEyeTrace()
		if IsValid(tr.Entity) then
		    local phys = tr.Entity:GetPhysicsObjectNum(tr.PhysicsBone)
		    
		    local pushvec = tr.Normal * -100000
		    local pushpos = tr.HitPos
		    
		    phys:ApplyForceOffset(pushvec, pushpos)
		end
		```
    **/
    
    public function ApplyForceOffset(force:Vector, position:Vector):Void;
    
    
    /**
        Returns the surface area of the physics object in source-units².
		
		`**Returns:** The surface area
    **/
    
    public function GetSurfaceArea():Float;
    
    
    /**
        Returns 1 divided by the physics object's mass.
		
		`**Returns:** The inverted mass.
    **/
    
    public function GetInvMass():Float;
    
    
    /**
        Converts a vector to a relative to the physics object coordinate system.
		
		Name | Description
		--- | ---
		`vec` | The vector in world space coordinates.
		
		
		`**Returns:** The vector local to PhysObj: GetPos.
    **/
    
    public function WorldToLocal(vec:Vector):Vector;
    
    
    /**
        Returns 1 divided by the inertia.
		
		`**Returns:** The inverted inertia
    **/
    
    public function GetInvInertia():Float;
    
    
    /**
        Sets the amount of drag to apply to a physics object when attempting to rotate.
		
		Name | Description
		--- | ---
		`coefficient` | Drag coefficient. The bigger this value is, the slower the angles will change.
    **/
    
    public function SetAngleDragCoefficient(coefficient:Float):Void;
    
    
    /**
        Returns the center of mass of the physics object as a local vector.
		
		`**Returns:** The center of mass of the physics object.
    **/
    
    public function GetMassCenter():Vector;
    
    
    /**
        Applies specified torque to the physics object.
		
		Name | Description
		--- | ---
		`torque` | The torque to be applied in kg * degrees / s.
    **/
    
    public function ApplyTorqueCenter(torque:Vector):Void;
    
    
    /**
        Applies the specified force to the physics object. (in Newtons)
		
		**Note:** This will not work on players, use Entity:SetVelocity instead.
		
		**Note:** -9.80665 (meters / second^2)  Is the approximate acceleration of objects on Earth due to gravity. (It is negative because gravity pushes things downwards.)
		
		Name | Description
		--- | ---
		`force` | The force to be applied.
		
		
		___
		### Lua Examples
		#### Example 1
		An entity that Simulates it's own gravity by applying a force downward on the entity based on the force equation.(Force = mass * acceleration)Since, by default, entities already have gravity. The default gravity must be turned off by adding "phys:EnableGravity(false)" in the entities Initialize function so that the default gravity doesn't interfere with our custom gravity.NOTE: We can get the mass of the entity by using the GetMass() function.NOTE -9.80665 (meters / second^2)  Is the approximate acceleration of objects on Earth due to gravity. (It is negative because gravity pushes things downwards.)
		
		```lua 
		function ENT:Initialize()
		    self:SetModel("models/hunter/blocks/cube1x1x1.mdl")
		    self:PhysicsInit(SOLID_VPHYSICS)
		    self:SetSolid(SOLID_VPHYSICS)
		    self:SetMoveType(MOVETYPE_VPHYSICS)
		
		    if phys:IsValid() then
		        phys:EnableGravity(false) -- This is required. Since we are creating our own gravity.
		        phys:Wake()
		    end
		end
		
		function ENT:PhysicsUpdate(phys)
		    local phys = self:GetPhysicsObject()
		    phys:ApplyForceCenter(Vector(0,0,phys:GetMass()*-9.80665))
		end
		```
    **/
    
    public function ApplyForceCenter(force:Vector):Void;
    
    
    /**
        Calculates the linear and angular velocities on the center of mass for an offset force impulse. The outputs can be directly passed to PhysObj:AddVelocity and PhysObj:AddAngleVelocity, respectively.
		
		Name | Description
		--- | ---
		`force` | The initial force
		`pos` | The location of the force in world coordinates
		
		
		Name | Description
		--- | ---
		`a` | The calculated linear velocity from the force on the physics object's center of mass
		`b` | The calculated angular velocity from the force on the physics object's center of mass
    **/
    
    public function CalculateVelocityOffset(force:Vector, pos:Vector):PhysObjCalculateVelocityOffsetReturn;
    
    
    /**
        Returns the speed damping of the physics object.
		
		`**Returns:** speedDamping
    **/
    
    public function GetSpeedDamping():Float;
    
    
    /**
        Prints debug info about the state of the physics object to the console.
		
		___
		### Lua Examples
		#### Example 1
		Outputs physics info about the entity the player is looking at to the console.
		
		```lua 
		Entity(1):GetEyeTrace().Entity:GetPhysicsObject():OutputDebugInfo()
		```
		**Output:**
		
		----------------- Object: models/props_borealis/bluebarrel001.mdl Mass: 60.0 (inv 0.017) Inertia: 8.69, 8.69, 2.46 (inv 0.115, 0.115, 0.406) Velocity: 0.00, 0.00, -0.00 Ang Velocity: 0.00, 0.00, -0.00 Damping 0.00 linear, 0.00 angular Linear Drag: 0.02, 0.01, 0.01 (factor 1.00) Angular Drag: 0.01, 0.02, 0.01 (factor 1.00) attached to 5 controllers 4) sys:friction 3) sys:friction 2) sys:friction 1) vphysics:drag 0) sys:gravity State: Asleep, Collision Enabled, Motion Enabled, Flags 1127 (game 0000, index 0) Material: plastic_barrel : density(500.0), thickness(0.25), friction(0.80), elasticity(0.01) CollisionModel: Compact Surface: 1 convex pieces no outer hull
    **/
    
    public function OutputDebugInfo():Void;
    
    
    /**
        Returns whenever the specified flag(s) is/are set.
		
		Name | Description
		--- | ---
		`flags` | Bitflag, see FVPHYSICS_ Enums.
		
		
		`**Returns:** If flag was set or not
    **/
    
    public function HasGameFlag(flags:FVPHYSICS):Bool;
    
    
    /**
        Sets the angles of the physobject.
		
		Name | Description
		--- | ---
		`angles` | The new angles of the physobject.
    **/
    
    public function SetAngles(angles:Angle):Void;
    
    
    /**
        Rotate a vector from the local frame of the physics object to world frame.
		
		**Note:** This function only rotates the vector, without any translation operation.
		
		Name | Description
		--- | ---
		`LocalVec` | A vector in the physics object's local frame
		
		
		`**Returns:** The corresponding vector in world frame
		
		___
		### Lua Examples
		#### Example 1
		Given the angle of the physics object is angle ( 0.045, 89.952, 89.99 ) ( This can be derived by PhysObj:GetAngles() ), convert the vector ( 1 ,2, 3 ) in this physics object's local frame into world frame.
		
		```lua 
		print( "Angle of the PhysObj: ", PhysObj:GetAngles() )
		print( "Vector in world frame: ", PhysObj:LocalToWorld( Vector( 1, 2, 3 ) ) )
		```
		**Output:**
		
		Angle of the PhysObj: 0.045 89.952 89.993; Vector in world frame: 3.000585 0.999039 1.999603;
    **/
    
    public function LocalToWorldVector(LocalVec:Vector):Vector;
    
    
    /**
        Returns whenever the entity is able to collide or not.
		
		`**Returns:** isCollisionEnabled
    **/
    
    public function IsCollisionEnabled():Bool;
    
    
    /**
        Gets the angular velocity of the object in degrees per second.
		
		`**Returns:** The angular velocity
    **/
    
    public function GetAngleVelocity():Vector;
    
    
    /**
        Returns whenever the entity is affected by drag.
		
		`**Returns:** dragEnabled
    **/
    
    public function IsDragEnabled():Bool;
    
    
    /**
        Adds the specified velocity to the current.
		
		Name | Description
		--- | ---
		`velocity` | Additional velocity.
    **/
    
    public function AddVelocity(velocity:Vector):Void;
    
    
    /**
        A convinience function for Angle:RotateAroundAxis.
		
		Name | Description
		--- | ---
		`dir` | Direction, around which we will rotate
		`ang` | Amount of rotation, in degrees
		
		
		`**Returns:** The resulting angle
		
		___
		### Lua Examples
		#### Example 1
		Shows that it is the same as Angle:RotateAroundAxis.
		
		```lua 
		local phys = Entity(1):GetEyeTrace().Entity:GetPhysicsObject() -- Our physics object
		
		print( phys:RotateAroundAxis( Vector( 1, 0, 0 ), 20 ) )
		
		local a = phys:GetAngles()
		a:RotateAroundAxis( Vector( 1, 0, 0 ), 20 )
		print( a )
		```
		**Output:**
		
		Two exactly the same angles -27.179 133.246 -23.236
		-27.179 133.246 -23.236
    **/
    
    public function RotateAroundAxis(dir:Vector, ang:Float):Angle;
    
    
    /**
        Returns the mass of the physics object.
		
		`**Returns:** The mass in kilograms.
    **/
    
    public function GetMass():Float;
    
    
    /**
        Wakes the physics object. 
		
		See PhysObj:Sleep for more information.
    **/
    
    public function Wake():Void;
    
    
    /**
        Makes the physics object "sleep". 
		
		The physics object will no longer be moving unless it is "woken up" by either a collision with another moving object, or by PhysObj:Wake. This is an optimization feature of the physics engine.
    **/
    
    public function Sleep():Void;
    
    
    /**
        Adds one or more bit flags.
		
		Name | Description
		--- | ---
		`flags` | Bitflag, see FVPHYSICS_ Enums.
    **/
    
    public function AddGameFlag(flags:FVPHYSICS):Void;
    
    
    /**
        Sets the buoyancy ratio of the physics object. (How well it floats in water)
		
		Name | Description
		--- | ---
		`buoyancy` | Buoyancy ratio, where 0 is not buoyant at all (like a rock), and 1 is very buoyant (like wood)
    **/
    
    public function SetBuoyancyRatio(buoyancy:Float):Void;
    
    
    /**
        Rotates the object so that it's angles are aligned to the ones inputted.
		
		Name | Description
		--- | ---
		`from` | 
		`to` | 
		
		
		`**Returns:** 
    **/
    
    public function AlignAngles(from:Angle, to:Angle):Angle;
    
    
    /**
        Unlike PhysObj:SetPos and PhysObj:SetAngles, this allows the movement of a physobj while leaving physics interactions intact. This is used internally by the motion controller of the Gravity Gun , the +use pickup and the Physics Gun, and entities such as the crane.
		
		**Note:** This is the ideal function to move a physics shadow created with Entity:PhysicsInitShadow or Entity:MakePhysicsObjectAShadow.
		
		Name | Description
		--- | ---
		`targetPosition` | The position we should move to.
		`targetAngles` | The angle we should rotate towards.
		`frameTime` | The frame time to use for this movement, can be generally filled with FrameTime or ENTITY:PhysicsSimulate with the deltaTime. Can be set to 0 when you need to update the physics object just once.
    **/
    
    public function UpdateShadow(targetPosition:Vector, targetAngles:Angle, frameTime:Float):Void;
    
    
    /**
        Sets the position of the physobject.
		
		Name | Description
		--- | ---
		`position` | The new position of the physobject.
		`teleport` | 
    **/
    
    public function SetPos(position:Vector, ?teleport:Bool):Void;
    
    
    /**
        Returns the world velocity of a point in world coordinates about the object.
		
		Name | Description
		--- | ---
		`point` | 
		
		
		`**Returns:** 
    **/
    
    public function GetVelocityAtPoint(point:Vector):Vector;
    
    
    /**
        Returns the angles of the PhysObj shadow. See PhysObj:UpdateShadow.
		
		`**Returns:** The angles of the PhysObj shadow.
    **/
    
    public function GetShadowAngles():Angle;
    
    
    /**
        Returns all convex physics meshes of the object. See Entity.PhysicsInitMultiConvex for more information.
		
		`**Returns:** Table of MeshVertex structures where each MeshVertex structure is an independent convex mesh and each three vertices represent a triangle. Returns nil if the physics object is a sphere.
    **/
    
    public function GetMeshConvexes():MeshVertex;
    
    
    /**
        Sets the velocity of the physics object.
		
		Name | Description
		--- | ---
		`velocity` | The new velocity of the physics object.
    **/
    
    public function SetVelocityInstantaneous(velocity:Vector):Void;
    
    
    /**
        Sets whenever the physics object should be affected by drag.
		
		Name | Description
		--- | ---
		`enable` | True to enable, false to disable.
    **/
    
    public function EnableDrag(enable:Bool):Void;
    
    
    /**
        Returns the directional inertia of the physics object.
		
		`**Returns:** directionalInertia
    **/
    
    public function GetInertia():Vector;
    
    
    /**
        Returns the volume in source units³.
		
		`**Returns:** volume
    **/
    
    public function GetVolume():Float;
    
    
    /**
        Returns whenever the entity is affected by gravity.
		
		`**Returns:** gravitated
    **/
    
    public function IsGravityEnabled():Bool;
    
    
    /**
        Sets the contents flag of the PhysObj.
		
		Name | Description
		--- | ---
		`contents` | The CONTENTS_ Enums.
    **/
    
    public function SetContents(contents:CONTENTS):Void;
    
    
    /**
        Returns if the physics object is valid/not NULL.
		
		`**Returns:** isValid
    **/
    
    public function IsValid():Bool;
    
    
    /**
        Sets the directional inertia.
		
		Name | Description
		--- | ---
		`directionalInertia` | The directional inertia of the object. A value of Vector(0,0,0) makes the physobject go invalid.
    **/
    
    public function SetInertia(directionalInertia:Vector):Void;
    
    
    /**
        Returns the kinetic energy of the physobject.
		
		`**Returns:** The kinetic energy
    **/
    
    public function GetEnergy():Float;
    
    
    /**
        Returns the physics mesh of the object which is used for physobj-on-physobj collision.
		
		`**Returns:** Table of MeshVertex structures where each three vertices represent a triangle. Returns nil if the physics object is a sphere.
    **/
    
    public function GetMesh():MeshVertex;
    
    
    /**
        Returns the contents flag of the PhysObj.
		
		`**Returns:** The CONTENTS_ Enums.
    **/
    
    public function GetContents():CONTENTS;
    
    
}


@:multiReturn extern class PhysObjGetDampingReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class PhysObjGetAABBReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class PhysObjCalculateVelocityOffsetReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class PhysObjCalculateForceOffsetReturn {
var a:Vector;
var b:Vector;

}

