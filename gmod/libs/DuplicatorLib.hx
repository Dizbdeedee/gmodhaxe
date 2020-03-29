package gmod.libs;


/**
    The duplicator library allows you to specify what should be saved when someone attempts to duplicate your custom entity with the duplicator tool. It can also be used by 3rd party duplicator tools to make use of the built in system.
**/
@:native("_G.duplicator")extern class DuplicatorLib {
    #if server
    /**
        "Given entity list and constraint list, create all entities and return their tables" 
		
		Calls duplicator.CreateEntityFromTable on each sub-table of EntityList. If an entity is actually created, it calls ENTITY:OnDuplicated with the entity's duplicator data, then duplicator.ApplyEntityModifiers, duplicator.ApplyBoneModifiers and finally ENTITY:PostEntityPaste is called. 
		
		 The constraints are then created with duplicator.CreateConstraintFromTable.
		
		Name | Description
		--- | ---
		`Player` | The player who wants to create something
		`EntityList` | A table of duplicator data to create the entities from
		`ConstraintList` | A table of duplicator data to create the constraints from
		
		
		Name | Description
		--- | ---
		`a` | List of created entities
		`b` | List of created constraints
		
		
		___
		### Lua Examples
		#### Example 1
		Code used for a TOOL to copy duplication data on right click and paste it with its original info on left click.
		
		```lua 
		function TOOL:LeftClick( trace )
		    if (SERVER) then
		        duplicator.Paste(self:GetOwner(),Dupe.Entities,Dupe.Constraints)
		        print("PASTED")
		    end
		    return true
		end
		 
		function TOOL:RightClick( trace )
		    if (SERVER and IsValid(trace.Entity)) then
		        Dupe = duplicator.Copy(trace.Entity)
		        print("COPIED")
		    end
		    return true
		end
		```
    **/
    
    public static function Paste(Player:Player, EntityList:AnyTable, ConstraintList:AnyTable):DuplicatorLibPasteReturn;
    #end
    #if server
    /**
        Stores an entity modifier into an entity for saving
		
		Name | Description
		--- | ---
		`entity` | The entity to store modifier in
		`name` | Unique modifier name as defined in duplicator. RegisterEntityModifier
		`data` | Modifier data
    **/
    
    public static function StoreEntityModifier(entity:Entity, name:String, data:AnyTable):Void;
    #end
    #if server
    /**
        ***INTERNAL** 
		
		Creates a constraint from a saved/copied constraint table.
		
		Name | Description
		--- | ---
		`constraint` | Saved/copied constraint table
		`entityList` | The list of entities that are to be constrained
		
		
		`**Returns:** The newly created constraint entity
    **/
    @:deprecated("INTERNAL")
    public static function CreateConstraintFromTable(constraint:AnyTable, entityList:AnyTable):Entity;
    #end
    #if server
    /**
        "Generic function for duplicating stuff" This is called when duplicator.CreateEntityFromTable can't find an entity factory to build with. It calls duplicator.DoGeneric and duplicator.DoGenericPhysics to apply standard duplicator stored things such as the model and position.
		
		Name | Description
		--- | ---
		`ply` | The player who wants to create something
		`data` | The duplication data to build the entity with
		
		
		`**Returns:** The newly created entity
    **/
    
    public static function GenericDuplicatorFunction(ply:Player, data:AnyTable):Entity;
    #end
    
    /**
        Register a function used for creating a duplicated constraint.
		
		Name | Description
		--- | ---
		`name` | The unique name of new constraint
		`callback` | Function to be called when this constraint is created
		`...` | Arguments passed to the callback function
		
		
		___
		### Lua Examples
		#### Example 1
		This is from lua/includes/modules/constraint.lua, it registers the Weld Constraint.
		
		```lua 
		duplicator.RegisterConstraint( "Weld", Weld, "Ent1", "Ent2", "Bone1", "Bone2", "forcelimit", "nocollide", "deleteonbreak" )
		```
    **/
    
    public static function RegisterConstraint(name:String, callback:Function, vargs:Dynamic):Void;
    
    #if server
    /**
        Returns a table with some entity data that can be used to create a new entity with duplicator.CreateEntityFromTable
		
		Name | Description
		--- | ---
		`ent` | The entity table to save
		
		
		`**Returns:** See EntityCopyData structure
    **/
    
    public static function CopyEntTable(ent:Entity):EntityCopyData;
    #end
    #if server
    /**
        "Applies generic every-day entity stuff for ent from table data." Depending on the values of Model, Angle, Pos, Skin, Flex, Bonemanip, ModelScale, ColGroup, Name, and BodyG (table of multiple values) in the data table, this calls Entity:SetModel, Entity:SetAngles, Entity:SetPos, Entity:SetSkin, duplicator.DoFlex, duplicator.DoBoneManipulator, Entity:SetModelScale, Entity:SetCollisionGroup, Entity:SetName, Entity:SetBodygroup on ent. If ent has a RestoreNetworkVars function, it is called with data.DT.
		
		Name | Description
		--- | ---
		`ent` | The entity to be applied upon
		`data` | The data to be applied onto the entity
    **/
    
    public static function DoGeneric(ent:Entity, data:AnyTable):Void;
    #end
    #if server
    /**
        ***INTERNAL** 
		
		Fills entStorageTable with all of the entities in a group connected with constraints. Fills constraintStorageTable with all of the constrains constraining the group.
		
		Name | Description
		--- | ---
		`ent` | The entity to start from
		`entStorageTable` | The table the entities will be inserted into
		`constraintStorageTable` | The table the constraints will be inserted into
		
		
		Name | Description
		--- | ---
		`a` | entStorageTable
		`b` | constraintStorageTable
    **/
    @:deprecated("INTERNAL")
    public static function GetAllConstrainedEntitiesAndConstraints(ent:Entity, entStorageTable:AnyTable, constraintStorageTable:AnyTable):DuplicatorLibGetAllConstrainedEntitiesAndConstraintsReturn;
    #end
    #if server
    /**
        "Create an entity from a table." This creates an entity using the data in EntTable. If an entity factory has been registered for the entity's Class, it will be called. Otherwise, duplicator.GenericDuplicatorFunction will be called instead.
		
		Name | Description
		--- | ---
		`ply` | The player who wants to create something
		`entTable` | The duplication data to build the entity with. See EntityCopyData structure
		
		
		`**Returns:** The newly created entity
    **/
    
    public static function CreateEntityFromTable(ply:Player, entTable:EntityCopyData):Entity;
    #end
    #if server
    /**
        Help to remove certain map created entities before creating the saved entities This is obviously so we don't get duplicate props everywhere. It should be called before calling Paste.
    **/
    
    public static function RemoveMapCreatedEntities():Void;
    #end
    #if server
    /**
        Calls every function registered with duplicator.RegisterBoneModifier on each bone the ent has.
		
		Name | Description
		--- | ---
		`ply` | The player whose entity this is
		`ent` | The entity in question
    **/
    
    public static function ApplyBoneModifiers(ply:Player, ent:Entity):Void;
    #end
    #if server
    /**
        "Work out the AABB size"
		
		Name | Description
		--- | ---
		`Ents` | A table of entity duplication datums.
    **/
    
    public static function WorkoutSize(Ents:AnyTable):Void;
    #end
    
    /**
        Returns the entity class factory registered with duplicator.RegisterEntityClass.
		
		Name | Description
		--- | ---
		`name` | The name of the entity class factory
		
		
		`**Returns:** Is compromised of the following members: function Func - The function that creates the entity table Args - Arguments to pass to the function
    **/
    
    public static function FindEntityClass(name:String):AnyTable;
    
    
    /**
        Returns whether the entity can be duplicated or not
		
		Name | Description
		--- | ---
		`classname` | An entity's classname
		
		
		`**Returns:** Returns true if the entity can be duplicated (nil otherwise)
    **/
    
    public static function IsAllowed(classname:String):Bool;
    
    #if server
    /**
        Restores the flex data using Entity:SetFlexWeight and Entity:SetFlexScale
		
		Name | Description
		--- | ---
		`ent` | The entity to restore the flexes on
		`flex` | The flexes to restore
		`scale` | The flex scale to apply. (Flex scale is unchanged if omitted)
    **/
    
    public static function DoFlex(ent:Entity, flex:AnyTable, ?scale:Float):Void;
    #end
    
    /**
        "When a copy is copied it will be translated according to these. If you set them - make sure to set them back to 0 0 0!"
		
		Name | Description
		--- | ---
		`v` | The angle to offset all pastes from
    **/
    
    public static function SetLocalAng(v:Angle):Void;
    
    
    /**
        This allows you to specify a specific function to be run when your SENT is pasted with the duplicator, instead of relying on the generic automatic functions.
		
		**Note:** Automatically calls duplicator.Allow for the entity class.
		
		Name | Description
		--- | ---
		`name` | The ClassName of the entity you wish to register a factory for
		`function` | The factory function you want to have called. It should have the arguments (Player, ...) where ... is whatever arguments you request to be passed.
		`args` | Strings of the names of arguments you want passed to function the from the EntityCopyData structure. As a special case, "Data" will pass the whole structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the datatable and then lets the duplicator do it's job
		
		```lua 
		duplicator.RegisterEntityClass("prop_physics", function(ply, data)
		    PrintTable(data)
		    duplicator.GenericDuplicatorFunction(ply, data)
		end, "Data")
		```
		**Output:**
		
		Skin = 0
		Mins = -14.357550 -14.390250 -25.934851
		Flex:
			ColGroup = 0
		Pos = -292.415070 -157.575043 -12262.056641
		PhysicsObjects:
			0:
				Frozen = false
				Pos = 13.750092 0.490356 -4.675781
				Angle = 0.057 87.808 -0.031
		Class = prop_physics
		FlexScale = 1
		Maxs = 14.438149 14.405550 25.995348
		Model = models/props_borealis/bluebarrel001.mdl
		Angle = 0.057 134.318 -0.031
    **/
    
    public static function RegisterEntityClass(name:String, _function:Function, args:EntityCopyData):Void;
    
    
    /**
        Allow this entity to be duplicated
		
		Name | Description
		--- | ---
		`classname` | An entity's classname
    **/
    
    public static function Allow(classname:String):Void;
    
    #if server
    /**
        Stores bone mod data for a registered bone modification function
		
		Name | Description
		--- | ---
		`ent` | The entity to add bone mod data to
		`boneID` | The bone ID. See Entity: GetPhysicsObjectNum
		`key` | The key for the bone modification
		`data` | The bone modification data that is passed to the bone modification function
    **/
    
    public static function StoreBoneModifier(ent:Entity, boneID:Float, key:Dynamic, data:AnyTable):Void;
    #end
    
    /**
        This allows you to register tweaks to entities. For instance, if you were making an "unbreakable" addon, you would use this to enable saving the "unbreakable" state of entities between duplications. 
		
		This function registers a piece of generic code that is run on all entities with this modifier. In order to have it actually run, use duplicator.StoreEntityModifier. 
		
		 This function does nothing when run clientside.
		
		Name | Description
		--- | ---
		`name` | An identifier for your modification. This is not limited, so be verbose. "Person's 'Unbreakable' mod" is far less likely to cause conflicts than "unbreakable"
		`func` | The function to be called for your modification. It should have the arguments (Player, Entity, Data), where data is what you pass to duplicator. StoreEntityModifier.
    **/
    
    public static function RegisterEntityModifier(name:String, func:Function):Void;
    
    #if server
    /**
        Calls every function registered with duplicator.RegisterEntityModifier on the entity.
		
		Name | Description
		--- | ---
		`ply` | The player whose entity this is
		`ent` | The entity in question
    **/
    
    public static function ApplyEntityModifiers(ply:Player, ent:Entity):Void;
    #end
    #if server
    /**
        "Restores the bone's data." Loops through Bones and calls Entity:ManipulateBoneScale, Entity:ManipulateBoneAngles and Entity:ManipulateBonePosition on ent with the table keys and the subtable values s, a and p respectively.
		
		Name | Description
		--- | ---
		`ent` | The entity to be bone manipulated
		`bones` | Table with a BoneManipulationData structure for every bone (that has manipulations applied) using the bone ID as the table index.
    **/
    
    public static function DoBoneManipulator(ent:Entity, bones:BoneManipulationData):Void;
    #end
    #if server
    /**
        Copies the entity, and all of its constraints and entities, then returns them in a table.
		
		Name | Description
		--- | ---
		`ent` | The entity to duplicate. The function will automatically copy all constrained entities.
		`tableToAdd` | A preexisting table to add entities and constraints in from. Uses the same table format as the table returned from this function.
		
		
		`**Returns:** A table containing duplication info which includes the following members: table Entities table Constraints Vector Mins Vector Maxs The values of Mins & Maxs from the table are returned from duplicator. WorkoutSize
    **/
    
    public static function Copy(ent:Entity, ?tableToAdd:AnyTable):AnyTable;
    #end
    
    /**
        Registers a function to be called on each of an entity's bones when duplicator.ApplyBoneModifiers is called.
		
		**Note:** This function is available to call on the client, but registered functions aren't used anywhere!
		
		Name | Description
		--- | ---
		`key` | The type of the key doesn't appear to matter, but it is preferable to use a string.
		`boneModifier` | Function called on each bone that an ent has. Called during duplicator.ApplyBoneModifiers. Function parameters are: Player ply Entity ent number boneID PhysObj bone table data The data table that is passed to boneModifier is set with duplicator. StoreBoneModifier
    **/
    
    public static function RegisterBoneModifier(key:Dynamic, boneModifier:Function):Void;
    
    #if server
    /**
        Copies the passed table of entities to save for later.
		
		Name | Description
		--- | ---
		`ents` | A table of entities to save/copy.
		
		
		`**Returns:** A table containing duplication info which includes the following members: table Entities table Constraints Vector Mins Vector Maxs
    **/
    
    public static function CopyEnts(ents:AnyTable):AnyTable;
    #end
    #if server
    /**
        Clears/removes the chosen entity modifier from the entity.
		
		Name | Description
		--- | ---
		`ent` | The entity the modification is stored on
		`key` | The key of the stored entity modifier
    **/
    
    public static function ClearEntityModifier(ent:Entity, key:Dynamic):Void;
    #end
    
    /**
        "When a copy is copied it will be translated according to these. If you set them - make sure to set them back to 0 0 0!"
		
		Name | Description
		--- | ---
		`v` | The position to offset all pastes from
    **/
    
    public static function SetLocalPos(v:Vector):Void;
    
    #if server
    /**
        "Applies bone data, generically." If data contains a PhysicsObjects table, it moves, re-angles and if relevent freezes all specified bones, first converting from local coordinates to world coordinates.
		
		Name | Description
		--- | ---
		`ent` | The entity to be applied upon
		`ply` | The player who owns the entity. Unused in function as of early 2013
		`data` | The data to be applied onto the entity
    **/
    
    public static function DoGenericPhysics(ent:Entity, ?ply:Player, data:AnyTable):Void;
    #end
    

}


@:multiReturn extern class DuplicatorLibPasteReturn {
var a:AnyTable;
var b:AnyTable;

}
@:multiReturn extern class DuplicatorLibGetAllConstrainedEntitiesAndConstraintsReturn {
var a:AnyTable;
var b:AnyTable;

}

