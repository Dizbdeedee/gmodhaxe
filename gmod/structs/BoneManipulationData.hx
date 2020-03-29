package gmod.structs;
/**
    Structure used for storing/restoring bone manipulations. Data is stored from Entity:GetManipulateBoneScale, Entity:GetManipulateBoneAngles, and Entity:GetManipulateBonePosition. Data is restored using Entity:ManipulateBoneScale, Entity:ManipulateBoneAngles, and Entity:ManipulateBonePosition. 
	
	The function duplicator.DoBoneManipulator and EntityCopyData structure use a table containing a BoneManipulationData structure for each bone (that has manipulations applied) with the bone ID as the struct index in the table. 
	
	 Fields s, a, and p are set if they don't equal Vector( 1, 1, 1 ), Angle( 0, 0, 0 ), and Vector( 0, 0, 0 ) respectively.
**/
typedef BoneManipulationData = {
    /**
        The entity's position manipulation of the given bone 
		
		Default: nil
    **/
    var ?p : Vector;
    /**
        The entity's angle manipulation of the bone 
		
		Default: nil
    **/
    var ?a : Angle;
    /**
        The entity's scale manipulation of the bone 
		
		Default: nil
    **/
    var ?s : Vector;
    
}
