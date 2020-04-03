package gmod.enums;
/**
    Used by Entity:BoneHasFlag.
**/
@:native("_G")
extern enum abstract BONE(Int) {
    /**
        
    **/
    var BONE_ALWAYS_PROCEDURAL;
    /**
        
    **/
    var BONE_PHYSICS_PROCEDURAL;
    /**
        A hitbox is attached to this bone
    **/
    var BONE_USED_BY_HITBOX;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD3;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD1;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD4;
    /**
        
    **/
    var BONE_SCREEN_ALIGN_CYLINDER;
    /**
        Is this bone used by anything?( If any BONE_USED_BY_* flags are true )
    **/
    var BONE_USED_BY_ANYTHING;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD0;
    /**
        
    **/
    var BONE_PHYSICALLY_SIMULATED;
    /**
        
    **/
    var BONE_USED_MASK;
    /**
        
    **/
    var BONE_USED_BY_BONE_MERGE;
    /**
        An attachment is attached to this bone
    **/
    var BONE_USED_BY_ATTACHMENT;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD5;
    /**
        
    **/
    var BONE_CALCULATE_MASK;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD6;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD2;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_MASK;
    /**
        
    **/
    var BONE_USED_BY_VERTEX_LOD7;
    /**
        
    **/
    var BONE_SCREEN_ALIGN_SPHERE;
    
}