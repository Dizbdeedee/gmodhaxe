package gmod.gclass;


/**
    List of all possible functions to manipulate angles. 
	
	Created by Angle & many more functions.
**/
extern class Angle {
    /**
        The pitch component of the angle
    **/
    var p:Float;
    /**
        The yaw component of the angle
    **/
    var y:Float;
    /**
        The roll component of the angle
    **/
    var r:Float;

    @:noCompletion
    var pitch:Float;
    @:noCompletion
    var yaw:Float;
    @:noCompletion
    var roll:Float;    
    @:noCompletion
    var x:Float;
    @:noCompletion
    var z:Float;

    /**
        Adds the values of the argument angle to the orignal angle. This functions the same as angle1 + angle2 without creating a new angle object, skipping object construction and garbage collection.
		
		Name | Description
		--- | ---
		`angle` | The angle to add.
    **/
    
    function Add(angle:Angle):Void;
    
    
    /**
        Normalizes the angles by applying a module with 360 to pitch, yaw and roll.
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function
		
		```lua 
		local a = Angle( 0, 181, 1 )
		a:Normalize()
		print( a )
		```
		**Output:**
		
		0.000 -179.000 1.000
    **/
    
    function Normalize():Void;
    
    
    /**
        Sets the p, y, and r of the angle.
		
		Name | Description
		--- | ---
		`p` | 
		`y` | 
		`r` | 
    **/
    
    function SetUnpacked(p:Float, y:Float, r:Float):Void;
    
    
    /**
        Copies pitch, yaw and roll from the second angle to the first.
		
		Name | Description
		--- | ---
		`originalAngle` | The angle to copy the values from.
    **/
    
    function Set(originalAngle:Angle):Void;
    
    
    /**
        Returns whether the pitch, yaw and roll are 0 or not.
		
		`**Returns:** Whether the pitch, yaw and roll are 0 or not.
    **/
    
    function IsZero():Bool;
    
    
    /**
        Returns a normal vector facing in the direction that points up relative to the angle's direction.
		
		`**Returns:** The up direction of the angle.
    **/
    
    function Up():Vector;
    
    
    /**
        Subtracts the values of the argument angle to the orignal angle. This functions the same as angle1 - angle2 without creating a new angle object, skipping object construction and garbage collection.
		
		Name | Description
		--- | ---
		`angle` | The angle to subtract.
    **/
    
    function Sub(angle:Angle):Void;
    
    
    /**
        Returns a normal vector facing in the direction that points right relative to the angle's direction.
		
		`**Returns:** The right direction of the angle
    **/
    
    function Right():Vector;
    
    
    /**
        Divides all values of the original angle by a scalar. This functions the same as angle1 / num without creating a new angle object, skipping object construction and garbage collection.
		
		Name | Description
		--- | ---
		`scalar` | The number to divide by.
    **/
    
    function Div(scalar:Float):Void;
    
    
    /**
        Rotates the angle around the specified axis by the specified degrees.
		
		Name | Description
		--- | ---
		`axis` | The axis to rotate around.
		`rotation` | The degrees to rotate around the specified axis.
    **/
    
    function RotateAroundAxis(axis:Vector, rotation:Float):Void;
    
    
    /**
        Returns a normal vector facing in the direction that the angle points.
		
		`**Returns:** The forward direction of the angle
    **/
    
    function Forward():Vector;
    
    
    /**
        Sets pitch, yaw and roll to 0. This function is faster than doing it manually.
    **/
    
    function Zero():Void;
    
    
    /**
        Returns the angle as a table with three elements.
		
		`**Returns:** The table with elements 1 = p, 2 = y, 3 = r.
    **/
    
    function ToTable():AnyTable;
    
    
    /**
        Returns the p, y, and r of the angle.
		
		Name | Description
		--- | ---
		`a` | p, pitch, x, or Angle[1].
		`b` | y, yaw, or Angle[2].
		`c` | r, roll, r, or Angle[3].
    **/
    
    function Unpack():AngleUnpackReturn;
    
    
    /**
        Snaps the angle to nearest interval of degrees.
		
		**Note:** This will modify the original angle too!
		
		Name | Description
		--- | ---
		`axis` | The component/axis to snap. Can be either "p"/"pitch", "y"/"yaw" or "r"/"roll".
		`target` | The target angle snap interval
		
		
		`**Returns:** The snapped angle.
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		print( Angle( 0, 92, 0 ):SnapTo( "y", 90 ) )
		print( Angle( 0, 115, 0 ):SnapTo( "y", 45 ) )
		print( Angle( 12, 98, 167 ):SnapTo( "p", 30 ):SnapTo( "y", 45 ):SnapTo( "r", 45 ) )
		```
		**Output:**
		
		Angle( 0, 90, 0 )
		Angle( 0, 135, 0 )
		Angle( 0, 90, -180 )
    **/
    
    function SnapTo(axis:String, target:Float):Angle;
    
    
    /**
        Multiplies a scalar to all the values of the orignal angle. This functions the same as num * angle without creating a new angle object, skipping object construction and garbage collection.
		
		Name | Description
		--- | ---
		`scalar` | The number to multiply.
    **/
    
    function Mul(scalar:Float):Void;
    
    
}


@:multiReturn extern class AngleUnpackReturn {
var a:Float;
var b:Float;
var c:Float;

}

