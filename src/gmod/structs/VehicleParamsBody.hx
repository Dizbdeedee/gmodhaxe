package gmod.structs;
/**
    The structure used by [VehicleParamsstructure](https://wiki.garrysmod.com/page/Structures/VehicleParams).
**/
typedef VehicleParamsBody = {
    /**
        Mass center override
    **/
    var massCenterOverride : Vector;
    /**
        
    **/
    var counterTorqueFactor : Float;
    /**
        
    **/
    var keepUprightTorque : Float;
    /**
        Maximum angular velocity
    **/
    var maxAngularVelocity : Float;
    /**
        
    **/
    var tiltForce : Float;
    /**
        Mass override
    **/
    var massOverride : Float;
    /**
        Additional gravity to be applied to the vehicle
    **/
    var addGravity : Float;
    /**
        
    **/
    var tiltForceHeight : Float;
    
}
