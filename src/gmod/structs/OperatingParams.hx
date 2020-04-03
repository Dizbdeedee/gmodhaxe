package gmod.structs;
/**
    The structure used by [Vehicle](https://wiki.garrysmod.com/page/Category:Vehicle): [GetOperatingParams](https://wiki.garrysmod.com/page/Vehicle/GetOperatingParams).
**/
typedef OperatingParams = {
    /**
        Is the vehicle boosting?
    **/
    var isTorqueBoosting : Bool;
    /**
        The current RPM of the vehicle
    **/
    var RPM : Float;
    /**
        Wheels on ground
    **/
    var wheelsInContact : Float;
    /**
        Steering angle
    **/
    var steeringAngle : Float;
    /**
        The current gear of the vehicle, starting from 0
    **/
    var gear : Float;
    /**
        The current speed, in inches per second
    **/
    var speed : Float;
    
}
