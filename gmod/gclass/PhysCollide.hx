package gmod.gclass;


/**
    A PhysCollide holds collision data from VPhysics. These objects can be used to run (currently quite limited) collision tests, but do not represent actual physics objects. 
	
	Created by CreatePhysCollideBox or CreatePhysCollidesFromModel.
**/
extern class PhysCollide {
    
    /**
        Performs a trace against this PhysCollide with the given parameters. This can be used for both line traces and box traces.
		
		Name | Description
		--- | ---
		`origin` | The origin for the PhysCollide during the trace
		`angles` | The angles for the PhysCollide during the trace
		`rayStart` | The start position of the trace
		`rayEnd` | The end position of the trace
		`rayMins` | The mins of the trace's bounds
		`rayMaxs` | The maxs of the trace's bounds
		
		
		Name | Description
		--- | ---
		`a` | Hit position of the trace. This is false if the trace did not hit.
		`b` | Hit normal of the trace
		`c` | Fraction of the trace. This is calculated from the distance between startPos, hitPos, and endPos.
    **/
    
    public function TraceBox(origin:Vector, angles:Angle, rayStart:Vector, rayEnd:Vector, rayMins:Vector, rayMaxs:Vector):PhysCollideTraceBoxReturn;
    
    
    /**
        Destroys the PhysCollide object.
    **/
    
    public function Destroy():Void;
    
    
    /**
        Checks whether this PhysCollide object is valid or not. 
		
		You should just use IsValid instead.
		
		`**Returns:** Is valid or not.
    **/
    
    public function IsValid():Bool;
    
    
}


@:multiReturn extern class PhysCollideTraceBoxReturn {
var a:Vector;
var b:Vector;
var c:Float;

}

