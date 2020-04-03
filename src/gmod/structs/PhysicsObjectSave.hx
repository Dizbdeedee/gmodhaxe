package gmod.structs;
/**
    Structure used in storing/restoring physics object attributes. duplicator.GenericDuplicatorFunction and duplicator.DoGenericPhysics use a table of PhysicsObjectSaves with the struct's index in the table being the physics object ID. 
	
	Pos and Angle are set by the following:
**/
typedef PhysicsObjectSave = {
    /**
        Whether the entity is moveable. Equal to (not PhysObj:IsMoveable)
    **/
    var Frozen : Bool;
    /**
        Whether the entity's gravity is affected by gravity or not. PhysObj:IsGravityEnabled
    **/
    var NoGrav : Bool;
    /**
        Whether the entity is dormant or not. PhysObj:IsAsleep
    **/
    var Sleep : Bool;
    /**
        The entity's world angles made local with WorldToLocal
    **/
    var Angle : Angle;
    /**
        The entity's world position made local with WorldToLocal
    **/
    var Pos : Vector;
    
}
