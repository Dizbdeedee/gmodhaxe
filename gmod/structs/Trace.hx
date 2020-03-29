package gmod.structs;
/**
    Table structure used for [util](https://wiki.garrysmod.com/page/Category:util). [TraceLine](https://wiki.garrysmod.com/page/util/TraceLine).
**/
typedef Trace = {
    /**
        The collision group COLLISION_GROUP_ Enums. This determines what the trace should hit in regards to the entity's collision group. 
		
		Default: COLLISION_GROUP_NONE
    **/
    var ?collisiongroup : COLLISION_GROUP;
    /**
        Should the trace ignore world or not 
		
		Default: false
    **/
    var ?ignoreworld : Bool;
    /**
        The start position of the trace 
		
		Default: Vector(0, 0, 0)
    **/
    var ?start : Vector;
    /**
        Things the trace should not hit. Can also be a table of entities or a function with one argument:
		
		**Warning:** Using a function here is super slow - try to avoid it.
    **/
    var ?filter : Entity;
    /**
        If set, the trace result will be written to the supplied table instead of returning a new table 
		
		Default: nil
    **/
    var ?output : AnyTable;
    /**
        The end position of the trace 
		
		Default: Vector(0, 0, 0)
    **/
    var ?endpos : Vector;
    /**
        The trace mask MASK_ Enums. This determines what the trace should hit and what it shouldn't hit. A mask is a combination of CONTENTS_ Enums - you can use these for more advanced masks. 
		
		Default: MASK_SOLID
    **/
    var ?mask : MASK;
    
}
