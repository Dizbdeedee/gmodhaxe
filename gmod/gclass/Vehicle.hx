package gmod.gclass;


/**
    This is a list of all methods only available for vehicles. It is also possible to call Entity functions on vehicles.
**/
extern class Vehicle extends Entity {
    #if server
    /**
        Returns the current RPM of the vehicle. This value is fake and doesn't actually affect the vehicle movement.
		
		`**Returns:** The RPM.
    **/
    
    public function GetRPM():Float;
    #end
    
    /**
        Returns if vehicle has thirdperson mode enabled or not.
		
		`**Returns:** Returns true if third person mode enabled, false otherwise
    **/
    
    public function GetThirdPersonMode():Bool;
    
    #if server
    /**
        Sets whether the engine is enabled or disabled, i.e. can be started or not.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable the engine
    **/
    
    public function EnableEngine(enable:Bool):Void;
    #end
    #if server
    /**
        Returns some info about the vehicle.
		
		`**Returns:** The operating params. See OperatingParams structure.
		
		___
		### Lua Examples
		#### Example 1
		Example output on a default Half-Life 2 Jeep.
		
		```lua 
		PrintTable( Entity(1):GetVehicle():GetOperatingParams() )
		```
		**Output:**
		
		RPM = 19.902961730957 gear = 0 isTorqueBoosting = false speed = -0.67361652851105 steeringAngle = 0 wheelsInContact = 4
    **/
    
    public function GetOperatingParams():OperatingParams;
    #end
    #if server
    /**
        Returns the current throttle of the vehicle.
		
		`**Returns:** The current throttle of the vehicle
    **/
    
    public function GetThrottle():Float;
    #end
    #if server
    /**
        Returns the current speed of the vehicle in MPH.
		
		`**Returns:** The speed of the vehicle in MPH
    **/
    
    public function GetSpeed():Float;
    #end
    #if server
    /**
        Returns whether this vehicle's engine is underwater or not. ( Internally the attachment point "engine" or "vehicle_engine" is checked )
		
		`**Returns:** Whether this vehicle's engine is underwater or not.
    **/
    
    public function IsVehicleBodyInWater():Bool;
    #end
    #if server
    /**
        Returns the wheel count of the vehicle
		
		`**Returns:** The amount of wheels
    **/
    
    public function GetWheelCount():Float;
    #end
    #if client
    /**
        Returns information about the ammo of the vehicle
		
		Name | Description
		--- | ---
		`a` | Ammo type of the vehicle ammo
		`b` | Clip size
		`c` | Count
    **/
    
    public function GetAmmo():VehicleGetAmmoReturn;
    #end
    #if server
    /**
        Sets the vehicle parameters for given vehicle.
		
		**Note:** Not all variables from the VehicleParams structure can be set.
		
		**Bug:** BUG Because this method uses miles per hour but Vehicle:GetVehicleParams returns Hammer units per second, this method incorrectly modifies the vehicle engine's "boostMaxSpeed", "maxRevSpeed" and "maxSpeed" even when not explicitly set in a call to this method. Workaround: In order to retain the original values for these fields, call Vehicle:GetVehicleParams yourself, convert the mentioned fields from Hammer units per second to miles per hour (1 MPH ≈ 17.6 HU/s in this case) and add them to the table passed into the call to this setter. Avoid doing this repeatedly to avoid floating point inaccuracies over time (store the ready-calculated value for next time if possible). Issue Tracker: #2625
		
		Name | Description
		--- | ---
		`params` | The new new vehicle parameters. See VehicleParams structure
    **/
    
    public function SetVehicleParams(params:VehicleParams):Void;
    #end
    
    /**
        Returns third person camera distance.
		
		`**Returns:** Camera distance
    **/
    
    public function GetCameraDistance():Float;
    
    #if server
    /**
        Returns whether the engine is started or not.
		
		`**Returns:** Whether the engine is started or not.
    **/
    
    public function IsEngineStarted():Bool;
    #end
    #if server
    /**
        Returns the view position and forward angle of a given passenger seat.
		
		Name | Description
		--- | ---
		`role` | The passenger role. 0 is the driver. This parameter seems to be ignored by the game engine and is therefore optional.
		
		
		Name | Description
		--- | ---
		`a` | The view position, will be 0, 0, 0 on failure
		`b` | The view angles, will be 0, 0, 0 on failure
		`c` | The field of view, will be 0 on failure
    **/
    
    public function GetVehicleViewPosition(?role:Float):VehicleGetVehicleViewPositionReturn;
    #end
    #if server
    /**
        Sets maximum forward throttle
		
		Name | Description
		--- | ---
		`maxThrottle` | The new maximum throttle.
    **/
    
    public function SetMaxThrottle(maxThrottle:Float):Void;
    #end
    #if server
    /**
        Returns the total wheel height.
		
		Name | Description
		--- | ---
		`wheel` | The wheel to get the base wheel height of.
		
		
		`**Returns:** The total wheel height.
    **/
    
    public function GetWheelTotalHeight(wheel:Float):Float;
    #end
    #if server
    /**
        Returns whether the engine is enabled or not, i.e. whether it can be started.
		
		`**Returns:** Whether the engine is enabled
    **/
    
    public function IsEngineEnabled():Bool;
    #end
    
    /**
        ***INTERNAL** 
		
		Sets the vehicle class name.
		
		Name | Description
		--- | ---
		`class` | The vehicle class name to set
    **/
    @:deprecated("INTERNAL")
    public function SetVehicleClass(_class:String):Void;
    
    #if server
    /**
        Returns whether this vehicle is currently boosting or not.
		
		`**Returns:** Whether this vehicle is currently boosting or not.
    **/
    
    public function IsBoosting():Bool;
    #end
    #if server
    /**
        Returns the current speed of the vehicle in Half-Life Hammer Units (in/s). Same as Entity:GetVelocity + Vector:Length.
		
		`**Returns:** The speed of the vehicle
    **/
    
    public function GetHLSpeed():Float;
    #end
    #if server
    /**
        Returns the PhysObj of given wheel.
		
		Name | Description
		--- | ---
		`wheel` | The wheel to retrieve
		
		
		`**Returns:** The wheel
    **/
    
    public function GetWheel(wheel:Float):PhysObj;
    #end
    
    /**
        Returns true if the vehicle object is a valid or not. This will return false when Vehicle functions are not usable on the vehicle.
		
		`**Returns:** Is the vehicle a valid vehicle or not
    **/
    
    public function IsValidVehicle():Bool;
    
    #if server
    /**
        Returns the maximum steering degree of the vehicle
		
		`**Returns:** The maximum steering degree of the vehicle
    **/
    
    public function GetSteeringDegrees():Float;
    #end
    #if server
    /**
        Returns the seat position and angle of a given passenger seat.
		
		Name | Description
		--- | ---
		`role` | The passenger role. ( 1 is the driver )
		
		
		Name | Description
		--- | ---
		`a` | The seat position
		`b` | The seat angle
    **/
    
    public function GetPassengerSeatPoint(role:Float):VehicleGetPassengerSeatPointReturn;
    #end
    #if server
    /**
        Tries to find an Exit Point for leaving vehicle, if one is unobstructed in the direction given.
		
		Name | Description
		--- | ---
		`yaw` | Yaw/roll from vehicle angle to check for exit
		`distance` | Distance from origin to drop player
		
		
		`**Returns:** Returns the vector for exit position or nil if cannot exit that way.
    **/
    
    public function CheckExitPoint(yaw:Float, distance:Float):Vector;
    #end
    #if server
    /**
        Returns the base wheel height.
		
		Name | Description
		--- | ---
		`wheel` | The wheel to get the base wheel height of.
		
		
		`**Returns:** The base wheel height.
    **/
    
    public function GetWheelBaseHeight(wheel:Float):Float;
    #end
    #if server
    /**
        Sets whether this vehicle has a brake pedal.
		
		Name | Description
		--- | ---
		`brakePedal` | Whether this vehicle has a brake pedal
    **/
    
    public function SetHasBrakePedal(brakePedal:Bool):Void;
    #end
    
    /**
        Sets the third person mode state.
		
		Name | Description
		--- | ---
		`enable` | Enable or disable the third person mode for this vehicle
    **/
    
    public function SetThirdPersonMode(enable:Bool):Void;
    
    #if server
    /**
        Returns the wheel contact point.
		
		Name | Description
		--- | ---
		`wheel` | The wheel to check
		
		
		Name | Description
		--- | ---
		`a` | The contact position
		`b` | The Surface Properties ID of hit surface.
		`c` | Whether the wheel is on ground or not
    **/
    
    public function GetWheelContactPoint(wheel:Float):VehicleGetWheelContactPointReturn;
    #end
    #if server
    /**
        Sets the steering of the vehicle.
		
		Name | Description
		--- | ---
		`front` | Angle of the front wheels (-1 to 1)
		`rear` | Angle of the rear wheels (-1 to 1)
    **/
    
    public function SetSteering(front:Float, rear:Float):Void;
    #end
    #if server
    /**
        Returns whether this vehicle has boost at all.
		
		`**Returns:** Whether this vehicle has boost at all.
    **/
    
    public function HasBoost():Bool;
    #end
    #if server
    /**
        Releases the vehicle's handbrake (Jeep) so it can roll without any passengers. 
		
		This will be overwritten if the vehicle has a driver. Same as Vehicle:SetHandbrake( false )
    **/
    
    public function ReleaseHandbrake():Void;
    #end
    #if server
    /**
        Sets the maximum steering degrees of the vehicle
		
		Name | Description
		--- | ---
		`steeringDegrees` | The new maximum steering degree
    **/
    
    public function SetSteeringDegrees(steeringDegrees:Float):Void;
    #end
    #if server
    /**
        Turns on or off the Jeep handbrake so it can roll without a driver inside. 
		
		Does nothing while the vehicle has a driver in it.
		
		Name | Description
		--- | ---
		`handbrake` | true to turn on, false to turn off.
    **/
    
    public function SetHandbrake(handbrake:Bool):Void;
    #end
    #if server
    /**
        Returns the vehicle parameters of given vehicle.
		
		`**Returns:** The vehicle parameters. See VehicleParams structure
    **/
    
    public function GetVehicleParams():VehicleParams;
    #end
    #if server
    /**
        Gets the passenger of the vehicle, returns NULL if no drivers is present.
		
		Name | Description
		--- | ---
		`passenger` | The index of the passenger
		
		
		`**Returns:** The passenger
    **/
    
    public function GetPassenger(passenger:Float):Entity;
    #end
    #if server
    /**
        Starts or stops the engine.
		
		Name | Description
		--- | ---
		`start` | True to start, false to stop.
    **/
    
    public function StartEngine(start:Bool):Void;
    #end
    #if server
    /**
        Sets spring length of given wheel
		
		Name | Description
		--- | ---
		`wheel` | The wheel to change spring length of
		`length` | The new spring length
    **/
    
    public function SetSpringLength(wheel:Float, length:Float):Void;
    #end
    
    /**
        Returns the vehicle class name. This is only useful for Sandbox spawned vehicles or any vehicle that properly sets the vehicle class with Vehicle:SetVehicleClass.
		
		`**Returns:** The class name of the vehicle.
		
		___
		### Lua Examples
		#### Example 1
		Prints the spawn menu name of the vehicle the player is currently in.
		
		```lua 
		local c = Entity(1):GetVehicle():GetVehicleClass()
		if ( !list.Get( "Vehicles" )[ c ] ) then return end
		local t = list.Get( "Vehicles" )[ c ]
		print( t.Name )
		```
    **/
    
    public function GetVehicleClass():String;
    
    #if server
    /**
        Returns the remaining boosting time left.
		
		`**Returns:** The remaining boosting time left
    **/
    
    public function BoostTimeLeft():Float;
    #end
    #if server
    /**
        Sets the boost. It is possible that this function does not work while the vehicle has a valid driver in it.
		
		Name | Description
		--- | ---
		`boost` | The new boost value
    **/
    
    public function SetBoost(boost:Float):Void;
    #end
    #if server
    /**
        Sets the throttle of the vehicle. It is possible that this function does not work with a valid driver in it.
		
		Name | Description
		--- | ---
		`throttle` | The new throttle.
    **/
    
    public function SetThrottle(throttle:Float):Void;
    #end
    #if server
    /**
        Returns the max speed of the vehicle in MPH.
		
		`**Returns:** The max speed of the vehicle in MPH
    **/
    
    public function GetMaxSpeed():Float;
    #end
    #if server
    /**
        Sets friction of given wheel.  This function may be broken.
		
		Name | Description
		--- | ---
		`wheel` | The wheel to change the friction of
		`friction` | The new friction to set
    **/
    
    public function SetWheelFriction(wheel:Float, friction:Float):Void;
    #end
    #if server
    /**
        Returns whether this vehicle has a brake pedal. See Vehicle:SetHasBrakePedal.
		
		`**Returns:** Whether this vehicle has a brake pedal or not.
    **/
    
    public function HasBrakePedal():Bool;
    #end
    #if server
    /**
        Returns the current steering of the vehicle.
		
		`**Returns:** The current steering of the vehicle.
    **/
    
    public function GetSteering():Float;
    #end
    #if server
    /**
        Gets the driver of the vehicle, returns NULL if no driver is present.
		
		`**Returns:** The driver of the vehicle
    **/
    
    public function GetDriver():Entity;
    #end
    
    /**
        Sets the third person camera distance of the vehicle.
		
		Name | Description
		--- | ---
		`distance` | Camera distance to set to
    **/
    
    public function SetCameraDistance(distance:Float):Void;
    
    #if server
    /**
        Sets maximum reverse throttle
		
		Name | Description
		--- | ---
		`maxRevThrottle` | The new maximum throttle. This number must be negative.
    **/
    
    public function SetMaxReverseThrottle(maxRevThrottle:Float):Void;
    #end
    #if server
    /**
        Sets whether the entry or exit camera animation should be played or not.
		
		Name | Description
		--- | ---
		`bOn` | Whether the entry or exit camera animation should be played or not.
    **/
    
    public function SetVehicleEntryAnim(bOn:Bool):Void;
    #end
    
}


@:multiReturn extern class VehicleGetWheelContactPointReturn {
var a:Vector;
var b:Float;
var c:Bool;

}
@:multiReturn extern class VehicleGetVehicleViewPositionReturn {
var a:Vector;
var b:Angle;
var c:Float;

}
@:multiReturn extern class VehicleGetPassengerSeatPointReturn {
var a:Vector;
var b:Angle;

}
@:multiReturn extern class VehicleGetAmmoReturn {
var a:Float;
var b:Float;
var c:Float;

}

