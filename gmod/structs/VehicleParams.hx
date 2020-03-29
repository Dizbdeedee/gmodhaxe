package gmod.structs;
/**
    The structure used by [Vehicle](https://wiki.garrysmod.com/page/Category:Vehicle): [SetVehicleParams](https://wiki.garrysmod.com/page/Vehicle/SetVehicleParams) and [Vehicle](https://wiki.garrysmod.com/page/Category:Vehicle): [GetVehicleParams](https://wiki.garrysmod.com/page/Vehicle/GetVehicleParams).
**/
typedef VehicleParams = {
    /**
        See VehicleParamsEngine structure
    **/
    var engine : VehicleParamsEngine;
    /**
        Number of axles
    **/
    var axleCount : Float;
    /**
        Wheels per axle
    **/
    var wheelsPerAxle : Float;
    /**
        See VehicleParamsBody structure
    **/
    var body : VehicleParamsBody;
    /**
        A table of VehicleParamsAxle structure tables.
    **/
    var axles : VehicleParamsAxle;
    /**
        See VehicleParamsSteering structure
    **/
    var steering : VehicleParamsSteering;
    
}
