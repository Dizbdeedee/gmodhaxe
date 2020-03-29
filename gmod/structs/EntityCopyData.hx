package gmod.structs;
/**
    Data structure used by the [duplicatorlibrary](https://wiki.garrysmod.com/page/Category:duplicator) to store and load entity data. It is created by duplicator.CopyEntTable and can be loaded by duplicator.CreateEntityFromTable. 
	
	It also shows up in several other contexts:
	
	**Note:** In addition to all fields listed here, any field saved on the entity will be saved as-is to this table. For example, if you set ent.FavoriteFood = "Steak" before duplicating it, this structure will also contain the field FavoriteFood with the value "Steak".
**/
typedef EntityCopyData = {
    /**
        The entity's active skin, see Entity:GetSkin.
    **/
    var Skin : Float;
    /**
        The entity's model scale, see Entity:GetModelScale. This will only be present if the model scale isn't 1.
    **/
    var ModelScale : Float;
    /**
        The entity's MapCreationID, only exists for entities that were created by the map. See Entity:MapCreationID.
    **/
    var MapCreationID : Float;
    /**
        The entity's collision group, see Entity:GetCollisionGroup. Uses the COLLISION_GROUP_ Enums.
    **/
    var ColGroup : COLLISION_GROUP;
    /**
        Deprecated, always 0. See Entity:GetWorkshopID.
    **/
    var WorkshopID : Float;
    /**
        The entity's collision bound minimums, see Entity:GetCollisionBounds.
    **/
    var Mins : Vector;
    /**
        The entity's model, see Entity:GetModel.
    **/
    var Model : String;
    /**
        The entity's body groups, see Entity:GetBodygroup. The key is the bodygroup ID and the value is the assigned bodygroup number. Only body groups with a non-default (> 0) value are listed, and if none exist, this field will be nil.
    **/
    var BodyG : AnyTable;
    /**
        Bone manipulation data, see Entity:HasBoneManipulations. The key is the bone index and the value is a BoneManipulationData structure. Only bones that have been manipulated with non-default values are listed, and if none exist, this field will be nil.
    **/
    var BoneManip : BoneManipulationData;
    /**
        The entity's Flex Scale, see Entity:GetFlexScale.
    **/
    var FlexScale : Float;
    /**
        The entity's Network Vars, see ENTITY:SetupDataTables and Networking Entities.
    **/
    var DT : AnyTable;
    /**
        Data about the entity's PhysObjs, see Entity:GetPhysicsObjectNum. The key is the physics object index (starts from 0), and the value is a PhysicsObjectSave structure. Unlike other tables in this structure, if there are no physics objects for this entity this will be an empty table.
    **/
    var PhysicsObjects : PhysicsObjectSave;
    /**
        The entity's angle, relative to the duplication angle.
    **/
    var Angle : Angle;
    /**
        The entity's position, relative to the duplication origin point.
    **/
    var Pos : Vector;
    /**
        The entity's name, see Entity:GetName.
    **/
    var Name : String;
    /**
        The entity's class name, see Entity:GetClass.
    **/
    var Class : String;
    /**
        The entity's collision bound maximums, see Entity:GetCollisionBounds.
    **/
    var Maxs : Vector;
    /**
        Each flex bone's flex weight, see Entity:GetFlexWeight. The key is the flex's index and the value is the weight. Only flexes with a non-default (nonzero) weight are listed, and if none exist, this field will be nil.
    **/
    var Flex : AnyTable;
    
}
