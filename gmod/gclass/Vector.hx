package gmod.gclass;


/**
    List of all possible functions to manipulate vectors. 
	
	Created by Vector & many more functions.
**/
extern class Vector {
    
    /**
        Adds the values of the argument vector to the orignal vector. This functions the same as vector1 + vector2 without creating a new vector object, skipping object construction and garbage collection.
		
		Name | Description
		--- | ---
		`vector` | The vector to add.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the components of the vectors together.
		
		```lua 
		a = Vector(1, 1, 1)
		a:Add(Vector(1, 2, 3))
		print(a)
		```
		**Output:**
		
		2 3 4
		
		#### Example 2
		If you don't want to set your vector to the result, and just return a new vector as the result. You can use a '+' operator to add two vectors together. The original vector will remain unchanged.
		
		```lua 
		a = Vector(1, 1, 1)
		print(a + Vector(1, 2, 3))
		```
		**Output:**
		
		2 3 4
    **/
    
    public function Add(vector:Vector):Void;
    
    #if client
    /**
        Returns where on the screen the specified position vector would appear. A related function is gui.ScreenToVector, which converts a 2D coordinate to a 3D direction.
		
		**Note:** Should be called from a 3D rendering environment or after cam.Start3D or it may not work correctly.
		
		**Bug:** BUG Errors in a render hook can make this value incorrect until the player restarts their game. Issue Tracker: #462
		
		**Bug:** BUG cam.Start3D or 3D context cam.Start with non-default parameters incorrectly sets the reference FOV for this function, causing incorrect return values. This can be fixed by creating and ending a default 3D context (cam.Start3D with no arguments). Issue Tracker: #1404
		
		`**Returns:** The created ToScreenData structure.
    **/
    
    public function ToScreen():ToScreenData;
    #end
    
    /**
        Returns the squared distance of 2 vectors, this is faster than Vector:Distance as calculating the square root is an expensive process.
		
		Name | Description
		--- | ---
		`otherVec` | The vector to calculate the distance to.
		
		
		`**Returns:** Squared distance to the vector
		
		___
		### Lua Examples
		#### Example 1
		Checks if a player is within `dist` units of another player in the most efficient way possible.
		
		```lua 
		function PlayerWithinBounds(ply,otherPly, dist)
		    return ply:GetPos():DistToSqr(otherPly:GetPos()) < (dist*dist)
		    -- This is computationally faster than:
		    -- ply:GetPos():Distance(otherPly:GetPos()) < dist
		end
		print(PlayerWithinBounds(Entity(1),Entity(2),500))
		```
		**Output:**
		
		true
    **/
    
    public function DistToSqr(otherVec:Vector):Float;
    
    
    /**
        Returns whenever the given vector is in a box created by the 2 other vectors.
		
		Name | Description
		--- | ---
		`boxStart` | The first vector.
		`boxEnd` | The second vector.
		
		
		`**Returns:** Is the vector in the box or not
		
		___
		### Lua Examples
		#### Example 1
		Checks if player is within a certain area on the map.
		
		```lua 
		-- Position to test, we get the position of first player on the server
		local testPos = Entity( 1 ):GetPos()
		
		-- Positions to test, in this case we test if the player is in spawn area of gm_construct
		local pos1 = Vector( 1119, 895, 63 )
		local pos2 = Vector( 656, -896, -144 )
		
		-- This will return true if the player is within the tested area
		print( testPos:WithinAABox( pos1, pos2 ) )
		```
    **/
    
    public function WithinAABox(boxStart:Vector, boxEnd:Vector):Bool;
    
    
    /**
        Normalizes the given vector. This changes the vector you call it on, if you want to return a normalized copy without affecting the original, use Vector:GetNormalized.
		
		___
		### Lua Examples
		#### Example 1
		Normalizes Vector(4, 3, 2).
		
		```lua 
		local test = Vector(4, 3, 2)
		test:Normalize()
		MsgN( test )
		```
		**Output:**
		
		0.7428 0.5571 0.3714.
    **/
    
    public function Normalize():Void;
    
    
    /**
        Sets the x, y, and z of the vector.
		
		Name | Description
		--- | ---
		`x` | The x component
		`y` | The y component
		`z` | The z component
    **/
    
    public function SetUnpacked(x:Float, y:Float, z:Float):Void;
    
    
    /**
        Copies the values from the second vector to the first vector.
		
		Name | Description
		--- | ---
		`vector` | The vector to copy from.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets vector B to vector A's value.
		
		```lua 
		a = Vector(1, 2, 3)
		b = Vector()
		b:Set(a)
		print(b)
		```
		**Output:**
		
		1, 2, 3.
    **/
    
    public function Set(vector:Vector):Void;
    
    
    /**
        Returns a normalized version of the vector. Normalized means vector with same direction but with length of 1. 
		
		This does not affect the vector you call it on; to do this, use Vector:Normalize.
		
		`**Returns:** Normalized version of the vector.
    **/
    
    public function GetNormalized():Vector;
    
    
    /**
        Checks whenever all fields of the vector are 0.
		
		`**Returns:** Do all fields of the vector equal 0 or not
		
		___
		### Lua Examples
		#### Example 1
		Confirm that the Vector is indeed 0.
		
		```lua 
		a = Vector(0, 0, 0)
		print(a:IsZero())
		```
		**Output:**
		
		true
    **/
    
    public function IsZero():Bool;
    
    
    /**
        Returns the squared length of the vector, x² + y² + z². 
		
		This is faster than Vector:Length as calculating the square root is an expensive process.
		
		`**Returns:** Squared length of the vector
    **/
    
    public function LengthSqr():Float;
    
    
    /**
        Returns the pythagorean distance between the vector and the other vector.
		
		**Warning:** This is a relatively expensive process since it uses the square root. It is recommended that you use Vector:DistToSqr whenever possible.
		
		Name | Description
		--- | ---
		`otherVector` | The vector to get the distance to.
		
		
		`**Returns:** Distance between the vectors.
		
		___
		### Lua Examples
		#### Example 1
		Gets the distance from A to B.
		
		```lua 
		print(Vector(0, 0, 0):Distance(Vector(2, 3, 4)))
		```
		**Output:**
		
		5.3851647377014
    **/
    
    public function Distance(otherVector:Vector):Float;
    
    
    /**
        ***Deprecated:** Use Vector: GetNormalized instead.
		
		Returns a normalized version of the vector. This is a alias of Vector:GetNormalized.
		
		`**Returns:** Normalized version of the vector.
    **/
    @:deprecated("Use Vector: GetNormalized instead.")
    public function GetNormal():Vector;
    
    
    /**
        Returns the dot product of this vector and the passed one. 
		
		The dot product of two vectors is the product of their magnitudes (lengths), and the cosine of the angle between them:
		
		Name | Description
		--- | ---
		`otherVector` | The vector to calculate the dot product with
		
		
		`**Returns:** The dot product between the two vectors
		
		___
		### Lua Examples
		#### Example 1
		Get the angle of two opposite normalized vectors.
		
		```lua 
		local a = Vector(0, 1, 0)
		local b = Vector(0, -1, 0)
		
		local dot = a:Dot(b) -- returns the cos(ang) of the two vectors because they're both of length 1
		print("Radians", math.acos(dot)) -- the inverse of the cosine to get the angle
		print("Degrees", math.deg(math.acos(dot))) -- Convert radians to degrees
		```
		**Output:**
		
		Radians 3.1415926535898 Degrees 180
		
		#### Example 2
		Calculates whether the player is looking in the direction of an entity. This is often faster than traces, but it produces a slightly different result.The player is looking in the direction of the entity if the angle between the aimvector and the vector from the player to the entity is less than 45 degrees (or pi / 8 radians).
		
		```lua 
		local directionAng = math.pi / 8 
		local aimvector = ply:GetAimVector()
		-- The vector that goes from the player's shoot pos to the entity's position
		local entVector = ent:GetPos() - ply:GetShootPos() 
		local dot = aimvector:Dot(entVector) / entVector:Length()
		print(dot < directionAng)
		```
		**Output:**
		
		This script will say if the player is looking in the direction of the entity.
		
		#### Example 3
		A function to make sure the player is looking somewhere.
		
		```lua 
		function IsLookingAt( ply, targetVec )
		 return ply:GetAimVector():Dot( ( targetVec - ply:GetPos() + Vector(70) ):GetNormalized() ) < 0.95 
		end
		```
		**Output:**
		
		Returns true if ply is looking at (or close to) the target.
    **/
    
    public function Dot(otherVector:Vector):Float;
    
    
    /**
        Translates the Vector (values ranging from 0 to 1) into a Color structure. This will also range the values from 0 - 1 to 0 - 255. 
		
		x * 255 -> r y * 255 -> g z * 255 -> b 
		
		 This is the opposite of Color:ToVector
		
		`**Returns:** The created Color structure.
		
		___
		### Lua Examples
		#### Example 1
		Get the Player1's player model color but in RGB
		
		```lua 
		print( Entity( 1 ):GetPlayerColor( ):ToColor( ) )
		```
		**Output:**
		
		Prints the player color of Player1 in RGB instead of a Vector
    **/
    
    public function ToColor():Color;
    
    
    /**
        Substracts the values of the second vector from the orignal vector, this function can be used to avoid garbage collection.
		
		Name | Description
		--- | ---
		`vector` | The other vector.
		
		
		___
		### Lua Examples
		#### Example 1
		Subtracts vector A's components with the other vector.
		
		```lua 
		a = Vector(5, 6, 7)
		a:Sub(Vector(1, 2, 3))
		print(a)
		```
		
		#### Example 2
		If you don't want to set your vector to the result, and just return a new vector as the result. You can use a ' - ' operator to subtract two vectors from each other.
		
		```lua 
		a = Vector(5, 6, 7)
		print(a-Vector(1, 2, 3))
		```
    **/
    
    public function Sub(vector:Vector):Void;
    
    
    /**
        Calculates the cross product of this vector and the passed one. 
		
		The cross product of two vectors is a 3-dimensional vector with a direction perpendicular (at right angles) to both of them (according to the right-hand rule), and magnitude equal to the area of parallelogram they span. This is defined as the product of the magnitudes, the sine of the angle between them, and unit (normal) vector n defined by the right-hand rule:
		
		Name | Description
		--- | ---
		`otherVector` | Vector to calculate the cross product with.
		
		
		`**Returns:** The cross product of the two vectors.
    **/
    
    public function Cross(otherVector:Vector):Vector;
    
    
    /**
        Divide the vector by the given number, that means x, y and z are divided by that value. This will change the value of the original vector, see example 2 for division without changing the value.
		
		Name | Description
		--- | ---
		`divisor` | The value to divide the vector with.
		
		
		___
		### Lua Examples
		#### Example 1
		Divides a vector by 255.
		
		```lua 
		a = Vector(255, 130, 0)
		a:Div(255)
		print(a)
		```
		
		#### Example 2
		If you don't want to set your vector to the result, and just return a new vector as the result. You can use a ' / ' operator to divide a vector with a divisor.
		
		```lua 
		a = Vector(255, 255, 255)
		print(a/255)
		```
    **/
    
    public function Div(divisor:Float):Void;
    
    
    /**
        Rotates a vector by the given angle. Doesn't return anything, but rather changes the original vector.
		
		Name | Description
		--- | ---
		`rotation` | The angle to rotate the vector by.
    **/
    
    public function Rotate(rotation:Angle):Void;
    
    
    /**
        Sets x, y and z to 0.
    **/
    
    public function Zero():Void;
    
    
    /**
        Returns the angle of the vector, but instead of assuming that up is Vector( 0, 0, 1 ) (Like Vector:Angle does) you can specify which direction is 'up' for the angle.
		
		Name | Description
		--- | ---
		`up` | The up direction vector
		
		
		`**Returns:** The angle
		
		___
		### Lua Examples
		#### Example 1
		Shows usage of the function
		
		```lua 
		print( Vector( 0, 0, 100 ):AngleEx( Vector( 0, 0, 0 ) ) )
		```
		**Output:**
		
		Angle( -90.000, -0.000, 0.000 )
    **/
    
    public function AngleEx(up:Vector):Angle;
    
    
    /**
        Returns the vector as a table with three elements.
		
		`**Returns:** The table with elements 1 = x, 2 = y, 3 = z.
    **/
    
    public function ToTable():AnyTable;
    
    
    /**
        Returns the length of the vector in two dimensions, without the Z axis.
		
		`**Returns:** Length of the vector in two dimensions, √ x² + y²
    **/
    
    public function Length2D():Float;
    
    
    /**
        ***Deprecated:** This is an alias of Vector: Dot. Use that instead.
		
		Returns the dot product of the two vectors.       A function to make sure the player is looking somewhere.
		
		Name | Description
		--- | ---
		`Vector` | The other vector.
		
		
		`**Returns:** Dot Product
		
		___
		### Lua Examples
		#### Example 1
		A function to make sure the player is looking somewhere.
		
		```lua 
		function IsLookingAt( ply, targetVec )
		 return ply:GetAimVector():DotProduct( ( targetVec - ply:GetPos() + Vector(70) ):GetNormalized() ) < 0.95 
		end
		```
		**Output:**
		
		Returns true if ply is looking at (or close to) the target.
    **/
    @:deprecated("This is an alias of Vector: Dot. Use that instead.")
    public function DotProduct(Vector:Vector):Float;
    
    
    /**
        Returns the x, y, and z of the vector.
		
		Name | Description
		--- | ---
		`a` | x or Vector[1].
		`b` | y or Vector[2].
		`c` | z or Vector[3].
    **/
    
    public function Unpack():VectorUnpackReturn;
    
    
    /**
        Returns an angle representing the normal of the vector.
		
		`**Returns:** The angle/direction of the vector.
    **/
    
    public function Angle():Angle;
    
    
    /**
        Returns the squared length of the vectors x and y value, x² + y². 
		
		This is faster than Vector:Length2D as calculating the square root is an expensive process.
		
		`**Returns:** Squared length of the vector in two dimensions
    **/
    
    public function Length2DSqr():Float;
    
    
    /**
        Returns the Euclidean length of the vector: √ x² + y² + z²
		
		`**Returns:** Length of the vector.
		
		___
		### Lua Examples
		#### Example 1
		Gets the length of the vector.
		
		```lua 
		print(Vector(15, 16, 17):Length())
		```
		**Output:**
		
		27.748874664307.
    **/
    
    public function Length():Float;
    
    
    /**
        Returns if the vector is equal to another vector with the given tolerance.
		
		Name | Description
		--- | ---
		`compare` | The vector to compare to.
		`tolerance` | The tolerance range.
		
		
		`**Returns:** Are the vectors equal or not.
    **/
    
    public function IsEqualTol(compare:Vector, tolerance:Float):Bool;
    
    
    /**
        Scales the vector by the given number, that means x, y and z are multiplied by that value.
		
		Name | Description
		--- | ---
		`multiplier` | The value to scale the vector with.
		
		
		___
		### Lua Examples
		#### Example 1
		Scales a vector by 250.
		
		```lua 
		a = Vector(1, 1, 1)
		a:Mul(250)
		print(a)
		```
		
		#### Example 2
		If you don't want to set your vector to the result, and just return a new vector as the result. You can use a ' * ' operator to multiply a vector with a scalar.
		
		```lua 
		a = Vector(1, 1, 1)
		print(a*250)
		```
    **/
    
    public function Mul(multiplier:Float):Void;
    
    
}


@:multiReturn extern class VectorUnpackReturn {
var a:Float;
var b:Float;
var c:Float;

}

