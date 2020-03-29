package gmod.enums;
/**
    Enumerations used by ENTITY:PhysicsSimulate.
**/
@:native("_G")
extern enum abstract SIM(Int) {
    /**
        Don't simulate physics
    **/
    var SIM_NOTHING;
    /**
        Vectors in local coordinate system
    **/
    var SIM_LOCAL_FORCE;
    /**
        Vectors in local coordinate system
    **/
    var SIM_LOCAL_ACCELERATION;
    /**
        Vectors in world coordinate system
    **/
    var SIM_GLOBAL_FORCE;
    /**
        Vectors in world coordinate system
    **/
    var SIM_GLOBAL_ACCELERATION;
    
}