package gmod.structs;
/**
    Table structure used [GM](https://wiki.garrysmod.com/page/Category:GM_Hooks): [CalcView](https://wiki.garrysmod.com/page/GM/CalcView) and [GM](https://wiki.garrysmod.com/page/Category:GM_Hooks): [CalcVehicleView](https://wiki.garrysmod.com/page/GM/CalcVehicleView) hook.
**/
typedef CamData = {
    /**
        The camera's FOV
    **/
    var fov : Float;
    /**
        If set, enables orthographic mode. The table has following arguments:
    **/
    var ?ortho : AnyTable;
    /**
        The camera's position
    **/
    var origin : Vector;
    /**
        The camera's angles
    **/
    var angles : Angle;
    /**
        Distance to far clipping plane
    **/
    var zfar : Float;
    /**
        Set true to draw local players player model. 
		
		Default: false
    **/
    var ?drawviewer : Bool;
    /**
        Distance to near clipping plane
    **/
    var znear : Float;
    
}
