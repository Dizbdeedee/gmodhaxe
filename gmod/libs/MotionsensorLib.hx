package gmod.libs;


/**
    Functions related to Kinect for Windows usage in GMod.
**/
@:native("_G.motionsensor")extern class MotionsensorLib {
    #if client
    /**
        Returns true if we have detected that there's a kinect connected to the PC
		
		`**Returns:** Connected or not
    **/
    
    public static function IsAvailable():Bool;
    #end
    
    /**
        
		
		Name | Description
		--- | ---
		`translator` | 
		`sensor` | 
		`pos` | 
		`rotation` | 
		
		
		`**Returns:** Ang. If !translator.AnglesTable then return - {}
    **/
    
    public static function ProcessAnglesTable(translator:AnyTable, sensor:AnyTable, pos:Vector, rotation:Angle):Angle;
    
    #if client
    /**
        
    **/
    
    public static function GetSkeleton():Void;
    #end
    
    /**
        
		
		Name | Description
		--- | ---
		`ent` | Entity to choose builder for
		
		
		`**Returns:** Chosen builder
    **/
    
    public static function ChooseBuilderFromEntity(ent:Entity):String;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`translator` | 
		`sensor` | 
		`pos` | 
		`ang` | 
		`special_vectors` | 
		`boneid` | 
		`v` | 
		
		
		`**Returns:** Return nil on failure
    **/
    
    public static function ProcessAngle(translator:AnyTable, sensor:AnyTable, pos:Vector, ang:Angle, special_vectors:AnyTable, boneid:Float, v:AnyTable):Bool;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`translator` | 
		`sensor` | 
		
		
		`**Returns:** Pos. if !translator.PositionTable then return - {}
    **/
    
    public static function ProcessPositionTable(translator:AnyTable, sensor:AnyTable):Vector;
    
    #if client
    /**
        This starts access to the kinect sensor. Note that this usually freezes the game for a couple of seconds.
    **/
    
    public static function Start():Void;
    #end
    #if client
    /**
        Return whether a kinect is connected - and active (ie - Start has been called).
		
		`**Returns:** Connected and active or not
    **/
    
    public static function IsActive():Bool;
    #end
    
    /**
        
		
		Name | Description
		--- | ---
		`translator` | 
		`player` | 
		`rotation` | 
		
		
		Name | Description
		--- | ---
		`a` | Pos
		`b` | ang
		`c` | sensor
    **/
    
    public static function BuildSkeleton(translator:AnyTable, player:Player, rotation:Angle):MotionsensorLibBuildSkeletonReturn;
    
    #if client
    /**
        Returns the depth map material.
		
		`**Returns:** The material
    **/
    
    public static function GetColourMaterial():IMaterial;
    #end
    #if client
    /**
        Stops the motion capture.
    **/
    
    public static function Stop():Void;
    #end
    

}


@:multiReturn extern class MotionsensorLibBuildSkeletonReturn {
var a:Vector;
var b:Angle;
var c:Sensor;

}

