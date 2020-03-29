package gmod.libs;
#if server

/**
    The constraint library allows you to control the constraint system built into the physics engine (rope, weld, ballsockets, etc).
**/
@:native("_G.constraint")extern class ConstraintLib {
    
    /**
        Attempts to remove all constraints associated with an entity
		
		Name | Description
		--- | ---
		`ent` | The entity to remove constraints from
		
		
		Name | Description
		--- | ---
		`a` | Whether any constraints were removed
		`b` | Number of constraints removed
		
		
		___
		### Lua Examples
		#### Example 1
		From stools/remover.lua
		
		```lua 
		-- Reload removes all constraints on the targetted entity
		function TOOL:Reload( trace )
		    if ( !IsValid( trace.Entity ) or trace.Entity:IsPlayer() ) then return false end
		    return constraint.RemoveAll( trace.Entity )
		end
		```
    **/
    
    public static function RemoveAll(ent:Entity):ConstraintLibRemoveAllReturn;
    
    
    /**
        Make this entity forget any constraints it knows about. Note that this will not actually remove the constraints.
		
		Name | Description
		--- | ---
		`ent` | The entity that will forget its constraints.
    **/
    
    public static function ForgetConstraints(ent:Entity):Void;
    
    
    /**
        Creates a weld constraint
		
		Name | Description
		--- | ---
		`ent1` | The first entity
		`ent2` | The second entity
		`bone1` | The bonenumber of the first entity (0 for monoboned entities) PhysObj number for ragdolls, see: Entity: TranslateBoneToPhysBone.
		`bone2` | The bonenumber of the second entity
		`forcelimit` | The amount of force appliable to the constraint before it will break (0 is never)
		`nocollide` | Should ent1 be nocollided to ent2 via this constraint
		`deleteent1onbreak` | If true, when ent2 is removed, ent1 will also be removed
		
		
		`**Returns:** constraint
		
		___
		### Lua Examples
		#### Example 1
		Adapted from stools/thruster.lua
		
		```lua 
		function TOOL:LeftClick( trace )
		 -- Boilerplate stool code to extract ClientConVars to variables 
		 local thruster = MakeThruster( ply, model, Ang, trace.HitPos, key, key_bk, force, toggle, effect, damageable, soundname )
		 local weld = constraint.Weld( thruster, trace.Entity, 0, trace.PhysicsBone, 0, collision == 0, true )
		 -- If you remove the entity thrusters are welded to, the thruster is removed as well
		end
		```
    **/
    
    public static function Weld(ent1:Entity, ent2:Entity, bone1:Float, bone2:Float, forcelimit:Float, nocollide:Bool, deleteent1onbreak:Bool):Entity;
    
    
    /**
        Returns true if the entity has constraints attached to it
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		
		
		`**Returns:** Whether the entity has any constraints or not.
    **/
    
    public static function HasConstraints(ent:Entity):Bool;
    
    
    /**
        Creates a motor constraint.
		
		Name | Description
		--- | ---
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls)
		`Bone2` | Bone of second entity (0 for non-ragdolls)
		`LPos1` | 
		`LPos2` | 
		`friction` | 
		`torque` | 
		`forcetime` | 
		`nocollide` | Whether the entities should be no-collided.
		`toggle` | Whether the constraint is on toggle.
		`pl` | The player that will be used to call numpad. OnDown and numpad. OnUp.
		`forcelimit` | Amount of force until it breaks (0 = unbreakable)
		`numpadkey_fwd` | The key binding for "forward", corresponding to an KEY_ Enums
		`numpadkey_bwd` | The key binding for "backwards", corresponding to an KEY_ Enums
		`direction` | 
		`LocalAxis` | 
		
		
		Name | Description
		--- | ---
		`a` | Constraint. Will return false if the constraint could not be created.
		`b` | axis. Will return nil if the constraint could not be created.
    **/
    
    public static function Motor(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, friction:Float, torque:Float, forcetime:Float, nocollide:Float, toggle:Float, pl:Player, forcelimit:Float, numpadkey_fwd:KEY, numpadkey_bwd:KEY, direction:Float, LocalAxis:Vector):ConstraintLibMotorReturn;
    
    
    /**
        Returns the constraint of a specified type between two entities, if it exists
		
		Name | Description
		--- | ---
		`ent1` | The first entity to check
		`ent2` | The second entity to check
		`type` | The constraint type to look for (eg. "Weld", "Elastic", "NoCollide")
		`bone1` | The bone number for the first entity (0 for monoboned entities)
		`bone2` | The bone number for the second entity
		
		
		`**Returns:** constraint
    **/
    
    public static function Find(ent1:Entity, ent2:Entity, type:String, bone1:Float, bone2:Float):Entity;
    
    
    /**
        Returns the other entity involved in the first constraint of a specific type directly connected to the entity
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		`type` | The type of constraint (eg. "Weld", "Elastic", "NoCollide")
		
		
		`**Returns:** The other entity.
    **/
    
    public static function FindConstraintEntity(ent:Entity, type:String):Entity;
    
    
    /**
        Returns a table of all entities recursively constrained to an entitiy.
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		`ResultTable` | Table used to return result. Optional.
		
		
		`**Returns:** A table containing all of the constrained entities. This includes all entities constrained to entities constrained to the supplied entity, etc.
		
		___
		### Lua Examples
		#### Example 1
		Adapted from stools/remover.lua
		
		```lua 
		-- Remove this entity and everything constrained
		function TOOL:RightClick( trace )
		    if ( !IsValid( trace.Entity ) or trace.Entity:IsPlayer() ) then return false end
		    -- Loop through all the entities in the system
		    for _, Entity in pairs( constraint.GetAllConstrainedEntities( trace.Entity ) ) do
		        DoRemoveEntity( Entity )
		    end
		    return true
		end
		```
    **/
    
    public static function GetAllConstrainedEntities(ent:Entity, ?ResultTable:AnyTable):AnyTable;
    
    
    /**
        Creates an elastic constraint.
		
		Name | Description
		--- | ---
		`Ent1` | First entity.
		`Ent2` | Second entity
		`Bone1` | Bone of first entity (0 for non-ragdolls)
		`Bone2` | Bone of second entity (0 for non-ragdolls)
		`LPos1` | Position of first end of the rope. Local to Ent1.
		`LPos2` | Position of second end of the rope. Local to Ent2.
		`constant` | 
		`damping` | 
		`rdamping` | 
		`material` | The material of the rope.
		`width` | Width of rope.
		`stretchonly` | 
		
		
		Name | Description
		--- | ---
		`a` | Constraint. Will return false if the constraint could not be created.
		`b` | rope. Will return nil if the constraint could not be created.
    **/
    
    public static function Elastic(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, constant:Float, damping:Float, rdamping:Float, material:String, width:Float, stretchonly:Bool):ConstraintLibElasticReturn;
    
    
    /**
        Stores information about constraints in an entity's table.
		
		Name | Description
		--- | ---
		`ent1` | The entity to store the information on.
		`constrt` | The constraint to store in the entity's table.
		`ent2` | Optional. If different from ent1, the info will also be stored in the table for this entity.
		`ent3` | Optional. Same as ent2.
		`ent4` | Optional. Same as ent2.
    **/
    
    public static function AddConstraintTable(ent1:Entity, constrt:Entity, ?ent2:Entity, ?ent3:Entity, ?ent4:Entity):Void;
    
    
    /**
        Creates a Winch constraint.
		
		Name | Description
		--- | ---
		`pl` | The player that will be used to call numpad. OnDown and numpad. OnUp.
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls),
		`Bone2` | Bone of second entity (0 for non-ragdolls).
		`LPos1` | 
		`LPos2` | 
		`width` | The width of the rope.
		`fwd_bind` | The key binding for "forward", corresponding to an KEY_ Enums
		`bwd_bind` | The key binding for "backwards", corresponding to an KEY_ Enums
		`fwd_speed` | Forward speed.
		`bwd_speed` | Backwards speed.
		`material` | The material of the rope.
		`toggle` | Whether the winch should be on toggle.
		
		
		Name | Description
		--- | ---
		`a` | Constraint. Can return nil. Will return false if the constraint could not be created.
		`b` | rope. Will return nil if the constraint could not be created.
		`c` | controller. Can return nil.
    **/
    
    public static function Winch(pl:Player, Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, width:Float, fwd_bind:KEY, bwd_bind:KEY, fwd_speed:Float, bwd_speed:Float, material:String, toggle:Bool):ConstraintLibWinchReturn;
    
    
    /**
        Creates a muscle constraint.
		
		Name | Description
		--- | ---
		`pl` | The player that will be used to call numpad. OnDown.
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls)
		`Bone2` | Bone of second entity (0 for non-ragdolls)
		`LPos1` | 
		`LPos2` | 
		`Length1` | 
		`Length2` | 
		`width` | Width of the rope.
		`key` | The key binding, corresponding to an KEY_ Enums
		`fixed` | Whether the constraint is fixed.
		`period` | 
		`amplitude` | 
		`starton` | 
		`material` | Material of the rope.
		
		
		Name | Description
		--- | ---
		`a` | Constraint. Will return false if the constraint could not be created.
		`b` | rope. Will return nil if the constraint could not be created.
		`c` | controller. Will return nil if the constraint could not be created.
		`d` | slider. Will return nil if the fixed argument is not 1 or if the constraint could not be created.
    **/
    
    public static function Muscle(pl:Player, Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, Length1:Float, Length2:Float, width:Float, key:KEY, fixed:Float, period:Float, amplitude:Float, starton:Bool, material:String):ConstraintLibMuscleReturn;
    
    
    /**
        Creates an invisible, non-moveable anchor point in the world to which things can be attached.
		
		Name | Description
		--- | ---
		`pos` | The position to spawn the anchor at
		
		
		Name | Description
		--- | ---
		`a` | anchor
		`b` | physicsObject,
		`c` | bone
		`d` | LPos
    **/
    
    public static function CreateStaticAnchorPoint(pos:Vector):ConstraintLibCreateStaticAnchorPointReturn;
    
    
    /**
        Creates a slider constraint.
		
		Name | Description
		--- | ---
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls),
		`Bone2` | Bone of second entity (0 for non-ragdolls).
		`LPos1` | 
		`LPos2` | 
		`width` | The width of the rope.
		`material` | The material of the rope.
		
		
		Name | Description
		--- | ---
		`a` | Constraint. Will return false if the constraint could not be created.
		`b` | rope. Will return nil if the constraint could not be created.
    **/
    
    public static function Slider(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, width:Float, material:String):ConstraintLibSliderReturn;
    
    
    /**
        Creates an no-collide "constraint". Disables collision between two entities.
		
		**Note:** Does not work with players.
		
		Name | Description
		--- | ---
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls).
		`Bone2` | Bone of second entity (0 for non-ragdolls).
		
		
		`**Returns:** Constraint. Will return false if the constraint could not be created.
    **/
    
    public static function NoCollide(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float):Entity;
    
    
    /**
        Returns a table of all constraints directly connected to the entity
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		
		
		`**Returns:** A list of all constraints connected to the entity.
    **/
    
    public static function GetTable(ent:Entity):AnyTable;
    
    
    /**
        Creates a keep upright constraint.
		
		**Note:** This function only works on prop_physics or prop_ragdoll.
		
		Name | Description
		--- | ---
		`ent` | The entity to keep upright
		`ang` | The angle defined as "upright"
		`bone` | The bone of the entity to constrain (0 for boneless)
		`angularLimit` | Basically, the strength of the constraint
		
		
		`**Returns:** The created constraint, if any or false if the constraint failed to set
		
		___
		### Lua Examples
		#### Example 1
		From properties/keep_upright.lua (the right click menu)
		
		```lua 
		constraint.Keepupright( ent, Phys:GetAngles(), 0, 999999 )
		```
    **/
    
    public static function Keepupright(ent:Entity, ang:Angle, bone:Float, angularLimit:Float):Entity;
    
    
    /**
        Stores info about the constraints on the entity's table. The only difference between this and constraint.AddConstraintTable is that the constraint does not get deleted when the entity is removed.
		
		Name | Description
		--- | ---
		`ent1` | The entity to store the information on.
		`constrt` | The constraint to store in the entity's table.
		`ent2` | Optional. If different from ent1, the info will also be stored in the table for this entity.
		`ent3` | Optional. Same as ent2.
		`ent4` | Optional. Same as ent2.
    **/
    
    public static function AddConstraintTableNoDelete(ent1:Entity, constrt:Entity, ?ent2:Entity, ?ent3:Entity, ?ent4:Entity):Void;
    
    
    /**
        Creates a ballsocket joint.
		
		Name | Description
		--- | ---
		`Ent1` | First entity
		`Ent2` | Second entity
		`Bone1` | Bone of first entity (0 for non-ragdolls)
		`Bone2` | Bone of second entity (0 for non-ragdolls)
		`LocalPos` | Centerposition of the joint, relative to the second entity.
		`forcelimit` | Amount of force until it breaks (0 = unbreakable)
		`torquelimit` | Amount of torque (rotation speed) until it breaks (0 = unbreakable)
		`nocollide` | Whether the entities should be nocollided
		
		
		`**Returns:** Constraint. Will return false if the constraint could not be created.
    **/
    
    public static function Ballsocket(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LocalPos:Vector, forcelimit:Float, torquelimit:Float, nocollide:Float):Entity;
    
    
    /**
        Attempts to remove all constraints of a specified type associated with an entity
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		`type` | The constraint type to remove (eg. "Weld", "Elastic", "NoCollide")
		
		
		Name | Description
		--- | ---
		`a` | Whether we removed any constraints or not
		`b` | The amount of constraints removed
		
		
		___
		### Lua Examples
		#### Example 1
		From stools/axis.lua
		
		```lua 
		function TOOL:Reload( trace )
		 if (!trace.Entity:IsValid() or trace.Entity:IsPlayer() ) then return false end
		 local bool = constraint.RemoveConstraints( trace.Entity, "Axis" )
		 return bool
		end
		```
    **/
    
    public static function RemoveConstraints(ent:Entity, type:String):ConstraintLibRemoveConstraintsReturn;
    
    
    /**
        Creates a rope without any constraint
		
		Name | Description
		--- | ---
		`pos` | 
		`width` | 
		`material` | 
		`Constraint` | 
		`Ent1` | 
		`LPos1` | 
		`Bone1` | 
		`Ent2` | 
		`LPos2` | 
		`Bone2` | 
		`kv` | 
		
		
		`**Returns:** rope
    **/
    
    public static function CreateKeyframeRope(pos:Vector, width:Float, material:String, Constraint:Entity, Ent1:Entity, LPos1:Vector, Bone1:Float, Ent2:Entity, LPos2:Vector, Bone2:Float, kv:AnyTable):Entity;
    
    
    /**
        Creates a pulley constraint.
		
		Name | Description
		--- | ---
		`Ent1` | 
		`Ent4` | 
		`Bone1` | 
		`Bone4` | 
		`LPos1` | 
		`LPos4` | 
		`WPos2` | 
		`WPos3` | 
		`forcelimit` | Amount of force until it breaks (0 = unbreakable)
		`rigid` | Whether the constraint is rigid.
		`width` | Width of the rope.
		`material` | Material of the rope.
		
		
		`**Returns:** Constraint. Will return false if the constraint could not be created.
    **/
    
    public static function Pulley(Ent1:Entity, Ent4:Entity, Bone1:Float, Bone4:Float, LPos1:Vector, LPos4:Vector, WPos2:Vector, WPos3:Vector, forcelimit:Float, rigid:Bool, width:Float, material:String):Entity;
    
    
    /**
        Creates an advanced ballsocket (ragdoll) constraint. 
		
		Uses a https://developer.valvesoftware.com/wiki/Phys_ragdollconstraint
		
		Name | Description
		--- | ---
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls)
		`Bone2` | Bone of second entity (0 for non-ragdolls)
		`LPos1` | Position on the first entity, in its local space coordinates.
		`LPos2` | Position on the second entity, in its local space coordinates.
		`forcelimit` | Amount of force until it breaks (0 = unbreakable)
		`torquelimit` | Amount of torque (rotation speed) until it breaks (0 = unbreakable)
		`xmin` | Minimum angle in rotations around the X axis local to the constraint.
		`ymin` | Minimum angle in rotations around the Y axis local to the constraint.
		`zmin` | Minimum angle in rotations around the Z axis local to the constraint.
		`xmax` | Maximum angle in rotations around the X axis local to the constraint.
		`ymax` | Maximum angle in rotations around the Y axis local to the constraint.
		`zmax` | Maximum angle in rotations around the Z axis local to the constraint.
		`xfric` | Rotational friction in the X axis local to the constraint.
		`yfric` | Rotational friction in the Y axis local to the constraint.
		`zfric` | Rotational friction in the Z axis local to the constraint.
		`onlyrotation` | Only limit rotation, free movement.
		`nocollide` | Whether the entities should be no-collided.
		
		
		`**Returns:** A phys_ragdollconstraint entity. Will return false if the constraint could not be created.
    **/
    
    public static function AdvBallsocket(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, forcelimit:Float, torquelimit:Float, xmin:Float, ymin:Float, zmin:Float, xmax:Float, ymax:Float, zmax:Float, xfric:Float, yfric:Float, zfric:Float, onlyrotation:Float, nocollide:Float):Entity;
    
    
    /**
        Creates a rope constraint - with rope!
		
		Name | Description
		--- | ---
		`Ent1` | First entity
		`Ent2` | Second entity
		`Bone1` | Bone of first entity (0 for non-ragdolls)
		`Bone2` | Bone of second entity (0 for non-ragdolls)
		`LPos1` | Position of first end of the rope. Local to Ent1.
		`LPos2` | Position of second end of the rope. Local to Ent2.
		`length` | Length of the rope.
		`addlength` | Amount to add to the length of the rope. Works as it does in the Rope tool.
		`forcelimit` | Amount of force until it breaks (0 = unbreakable).
		`width` | Width of the rope.
		`material` | Material of the rope.
		`rigid` | Whether the constraint is rigid.
		
		
		Name | Description
		--- | ---
		`a` | Constraint. Will be a keyframe_rope if you roping to the same bone on the same entity. Will return false if the constraint could not be created.
		`b` | rope. Will return nil if "Constraint" is a keyframe_rope or if the constraint could not be created.
    **/
    
    public static function Rope(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, length:Float, addlength:Float, forcelimit:Float, width:Float, material:String, rigid:Bool):ConstraintLibRopeReturn;
    
    
    /**
        Basic checks to make sure that the specified entity and bone are valid. Returns false if we should not be constraining the entity.
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		`bone` | The bone of the entity to check (use 0 for mono boned ents)
		
		
		`**Returns:** shouldConstrain
		
		___
		### Lua Examples
		#### Example 1
		From modules/constraint.lua
		
		```lua 
		function Weld( Ent1, Ent2, Bone1, Bone2, forcelimit, nocollide, deleteonbreak )
		 if ( !CanConstrain( Ent1, Bone1 ) ) then return false end
		 if ( !CanConstrain( Ent2, Bone2 ) ) then return false end
		```
    **/
    
    public static function CanConstrain(ent:Entity, bone:Float):Bool;
    
    
    /**
        Returns the first constraint of a specific type directly connected to the entity found
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		`type` | The type of constraint (eg. "Weld", "Elastic", "NoCollide")
		
		
		`**Returns:** The constraint table, set with constraint. AddConstraintTable
    **/
    
    public static function FindConstraint(ent:Entity, type:String):AnyTable;
    
    
    /**
        Creates a Hydraulic constraint.
		
		Name | Description
		--- | ---
		`pl` | The player that will be used to call numpad. OnDown.
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls),
		`Bone2` | Bone of second entity (0 for non-ragdolls).
		`LPos1` | 
		`LPos2` | 
		`Length1` | 
		`Length2` | 
		`width` | The width of the rope.
		`key` | The key binding, corresponding to an KEY_ Enums
		`fixed` | Whether the hydraulic is fixed.
		`speed` | 
		`material` | The material of the rope.
		
		
		Name | Description
		--- | ---
		`a` | Constraint. Will return false if the constraint could not be created.
		`b` | rope. Will return nil if the constraint could not be created.
		`c` | controller. Can return nil depending on how the constraint was created. Will return nil if the constraint could not be created.
		`d` | slider. Can return nil depending on how the constraint was created. Will return nil if the constraint could not be created.
    **/
    
    public static function Hydraulic(pl:Player, Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, Length1:Float, Length2:Float, width:Float, key:KEY, fixed:Float, speed:Float, material:String):ConstraintLibHydraulicReturn;
    
    
    /**
        Returns a table of all constraints of a specific type directly connected to the entity
		
		Name | Description
		--- | ---
		`ent` | The entity to check
		`type` | The type of constraint (eg. "Weld", "Elastic", "NoCollide")
		
		
		`**Returns:** All the constraints of this entity.
    **/
    
    public static function FindConstraints(ent:Entity, type:String):AnyTable;
    
    
    /**
        Creates an axis constraint.
		
		Name | Description
		--- | ---
		`Ent1` | First entity.
		`Ent2` | Second entity.
		`Bone1` | Bone of first entity (0 for non-ragdolls)
		`Bone2` | Bone of second entity (0 for non-ragdolls)
		`LPos1` | Position on the first entity, in its local space coordinates.
		`LPos2` | Position on the second entity, in its local space coordinates.
		`forcelimit` | Amount of force until it breaks (0 = unbreakable)
		`torquelimit` | Amount of torque (rotational force) until it breaks (0 = unbreakable)
		`friction` | Constraint friction.
		`nocollide` | Whether the entities should be no-collided.
		`LocalAxis` | If you include the LocalAxis then LPos2 will not be used in the final constraint. However, LPos2 is still a required argument.
		`DontAddTable` | Whether or not to add the constraint info on the entity table. See constraint. AddConstraintTable.
		
		
		`**Returns:** Constraint. Will return false if the constraint could not be created.
    **/
    
    public static function Axis(Ent1:Entity, Ent2:Entity, Bone1:Float, Bone2:Float, LPos1:Vector, LPos2:Vector, forcelimit:Float, torquelimit:Float, friction:Float, nocollide:Float, LocalAxis:Vector, DontAddTable:Bool):Entity;
    
    

}


@:multiReturn extern class ConstraintLibWinchReturn {
var a:Entity;
var b:Entity;
var c:Entity;

}
@:multiReturn extern class ConstraintLibSliderReturn {
var a:Entity;
var b:Entity;

}
@:multiReturn extern class ConstraintLibRopeReturn {
var a:Entity;
var b:Entity;

}
@:multiReturn extern class ConstraintLibRemoveConstraintsReturn {
var a:Bool;
var b:Float;

}
@:multiReturn extern class ConstraintLibRemoveAllReturn {
var a:Bool;
var b:Float;

}
@:multiReturn extern class ConstraintLibMuscleReturn {
var a:Entity;
var b:Entity;
var c:Entity;
var d:Entity;

}
@:multiReturn extern class ConstraintLibMotorReturn {
var a:Entity;
var b:Entity;

}
@:multiReturn extern class ConstraintLibHydraulicReturn {
var a:Entity;
var b:Entity;
var c:Entity;
var d:Entity;

}
@:multiReturn extern class ConstraintLibElasticReturn {
var a:Entity;
var b:Entity;

}
@:multiReturn extern class ConstraintLibCreateStaticAnchorPointReturn {
var a:Entity;
var b:PhysObj;
var c:Float;
var d:Vector;

}

#end