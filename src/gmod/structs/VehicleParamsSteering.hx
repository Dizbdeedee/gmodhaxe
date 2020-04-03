package gmod.structs;
/**
    The structure used by [VehicleParamsstructure](https://wiki.garrysmod.com/page/Structures/VehicleParams).
**/
typedef VehicleParamsSteering = {
    /**
        
    **/
    var speedSlow : Float;
    /**
        
    **/
    var turnThrottleReduceFast : Float;
    /**
        
    **/
    var steeringRestRateSlow : Float;
    /**
        
    **/
    var boostSteeringRestRateFactor : Float;
    /**
        In Hammer Units
    **/
    var powerSlideAccel : Float;
    /**
        Disabled in Garry's Mod. In Half-Life 2: Episode 2 this dictates whether the vehicle should leave wheel dust effects when driving around
    **/
    var dustCloud : Bool;
    /**
        
    **/
    var steeringRateSlow : Float;
    /**
        
    **/
    var boostSteeringRateFactor : Float;
    /**
        The maximum angle at which the vehicle can turn while moving at max speed and not boosting
    **/
    var degreesFast : Float;
    /**
        The maximum angle at which the vehicle can turn while moving slowest
    **/
    var degreesSlow : Float;
    /**
        
    **/
    var steeringRestRateFast : Float;
    /**
        
    **/
    var steeringExponent : Float;
    /**
        
    **/
    var speedFast : Float;
    /**
        
    **/
    var throttleSteeringRestRateFactor : Float;
    /**
        
    **/
    var turnThrottleReduceSlow : Float;
    /**
        Whether the vehicle is allowed to skid/drift
    **/
    var isSkidAllowed : Bool;
    /**
        The maximum angle at which the vehicle can turn while boosting
    **/
    var degreesBoost : Float;
    /**
        
    **/
    var brakeSteeringRateFactor : Float;
    /**
        
    **/
    var steeringRateFast : Float;
    
}
