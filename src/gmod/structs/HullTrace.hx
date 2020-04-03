package gmod.structs;
/**
    Table used by [util](https://wiki.garrysmod.com/page/Category:util). [TraceHull](https://wiki.garrysmod.com/page/util/TraceHull).
**/
typedef HullTrace = {
    /**
        The collision group COLLISION_GROUP_ Enums. This determines what the trace should hit in regards to the entity's collision group. 
		
		Default: COLLISION_GROUP_NONE
    **/
    var ?collisiongroup : COLLISION_GROUP;
    /**
        Should the trace ignore world or not. 
		
		Default: false
    **/
    var ?ignoreworld : Bool;
    /**
        The start position of the trace
    **/
    var start : Vector;
    /**
        Things the trace should not hit. Can also be a table of entities or a function with one argument:
    **/
    var ?filter : Entity;
    /**
        If set, the trace result will be written to the supplied table instead of returning a new table 
		
		Default: nil
    **/
    var ?output : AnyTable;
    /**
        The end position of the trace
    **/
    var endpos : Vector;
    /**
        The trace mask MASK_ Enums. This determines what the trace should hit and what it shouldn't hit. 
		
		Default: MASK_SOLID
    **/
    var ?mask : MASK;
    /**
        The 3D vector local to the start/endpos with the lowest (often negative) values. This will represent the corner with the lower bounds of the box.
    **/
    var mins : Vector;
    /**
        The 3D vector local to the start/endpos with the highest values. This will represent the corner with the upper bounds of the box.
    **/
    var maxs : Vector;
    
}
