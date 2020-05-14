package gmod.structs;
/**
    The structure used by [VehicleParamsstructure](https://wiki.garrysmod.com/page/Structures/VehicleParams).
**/
typedef VehicleParamsAxle = {
    /**
        
    **/
    var suspension_springDampingCompression : Float;
    /**
        Material index of braking material of the wheels. Upon braking, the wheels will be set to this material.
    **/
    var wheels_brakeMaterialIndex : Float;
    /**
        
    **/
    var raytraceOffset : Vector;
    /**
        
    **/
    var offset : Vector;
    /**
        
    **/
    var wheels_frictionScale : Float;
    /**
        
    **/
    var raytraceCenterOffset : Vector;
    /**
        
    **/
    var torqueFactor : Float;
    /**
        Material index of the wheels by default.
    **/
    var wheels_materialIndex : Float;
    /**
        
    **/
    var suspension_stabilizerConstant : Float;
    /**
        
    **/
    var wheels_inertia : Float;
    /**
        
    **/
    var wheels_damping : Float;
    /**
        
    **/
    var suspension_springDamping : Float;
    /**
        Mass of each wheel.
    **/
    var wheels_mass : Float;
    /**
        
    **/
    var suspension_springConstant : Float;
    /**
        Radius of the wheels.
    **/
    var wheels_radius : Float;
    /**
        
    **/
    var suspension_maxBodyForce : Float;
    /**
        
    **/
    var wheels_springAdditionalLength : Float;
    /**
        Material index of skid material of the wheels. Upon skidding ( pressing Space and sliding the vehicle ), the wheels will be set to this material.
    **/
    var wheels_skidMaterialIndex : Float;
    /**
        
    **/
    var wheels_rotdamping : Float;
    /**
        
    **/
    var wheelOffset : Vector;
    /**
        
    **/
    var brakeFactor : Float;
    
}
