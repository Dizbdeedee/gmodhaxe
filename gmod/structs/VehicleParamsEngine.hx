package gmod.structs;
/**
    The structure used by [VehicleParamsstructure](https://wiki.garrysmod.com/page/Structures/VehicleParams).
**/
typedef VehicleParamsEngine = {
    /**
        
    **/
    var boostForce : Float;
    /**
        
    **/
    var torqueBoost : Bool;
    /**
        Duration of the boost in seconds
    **/
    var boostDuration : Float;
    /**
        Maximum RPM of the vehicle. Despite this being a maximum value, the vehicle can exceed it.
		
		**Warning:** Attempts to exceed the max RPM will force the active gear ratio to be that of the 1st gear, which will provide even more torque. This is the opposite of a rev limiter. This value is only used for the calculation of the effectively applied torque.
    **/
    var maxRPM : Float;
    /**
        
    **/
    var throttleTime : Float;
    /**
        Maximum forward going speed of the vehicle without boosting
		
		**Warning:** The Vehicle:SetVehicleParams function takes this in miles per hour, but Vehicle:GetVehicleParams returns this in hammer units per second! 1 MPH is roughly 17.6 HU/s.
    **/
    var maxSpeed : Float;
    /**
        Maximum reverse speed of the vehicle
		
		**Warning:** The Vehicle:SetVehicleParams function takes this in miles per hour, but Vehicle:GetVehicleParams returns this in hammer units per second! 1 MPH is roughly 17.6 HU/s.
    **/
    var maxRevSpeed : Float;
    /**
        The HP amount of the vehicle 
		
		This value is used to calculate the effectively applied torque, along with ratios and maxRPM.
    **/
    var horsepower : Float;
    /**
        Amount of RPM to automatically shift one gear up
    **/
    var shiftUpRPM : Float;
    /**
        Amount of RPM to automatically shift one gear down
    **/
    var shiftDownRPM : Float;
    /**
        Amount of gears this vehicle has
    **/
    var gearCount : Float;
    /**
        If true, the gearbox shifts gears, if false the gearbox stays stuck to the 1st gear (gear number 0).
    **/
    var isAutoTransmission : Bool;
    /**
        A table of numbers, of gear rations. Table length is equal to "gearCount" member of this table.
    **/
    var gearRatio : AnyTable;
    /**
        Maximum speed while boosting
		
		**Warning:** The Vehicle:SetVehicleParams function takes this in miles per hour, but Vehicle:GetVehicleParams returns this in hammer units per second! 1 MPH is roughly 17.6 HU/s.
    **/
    var boostMaxSpeed : Float;
    /**
        
    **/
    var autobrakeSpeedGain : Float;
    /**
        This acts as the final ratio of the gearbox. 
		
		It's like a master coefficient of the gearbox.
    **/
    var axleRatio : Float;
    /**
        Amount of seconds between being able to use the boost ( by pressing Shift key by default )
    **/
    var boostDelay : Float;
    /**
        
    **/
    var autobrakeSpeedFactor : Float;
    
}
