package gmod.libs;


/**
    The math library is a standard Lua library that provides functions for manipulating numbers. In Garry's Mod several additional math functions have been added.
**/
@:native("_G.math")extern class MathLib {
    
    /**
        Returns the hyperbolic sine of the given angle.
		
		Name | Description
		--- | ---
		`number` | Angle in radians.
		
		
		`**Returns:** The hyperbolic sine of the given angle.
    **/
    
    public static function sinh(number:Float):Float;
    
    
    /**
        Gradually approaches the target value by the specified amount.
		
		Name | Description
		--- | ---
		`current` | The value we're currently at.
		`target` | The target value. This function will never overshoot this value.
		`change` | The amount that the current value is allowed to change by to approach the target. (It makes no difference whether this is positive or negative.)
		
		
		`**Returns:** New current value, closer to the target than it was previously.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates what this function does
		
		```lua 
		print( math.Approach( 0, 5, 1 ) ) -- attempts to increment 0 by 1, 0 + 1 is less than 5 so returns 1
		print( math.Approach( 4, 5, 3 ) ) -- attempts to increment 4 by 3, 4 + 3 = 7 is greater than 5 so returns 5
		```
		
		#### Example 2
		Common usage example of this function with a control variable.
		
		```lua 
		local MyNumber = 0
		local Target = 0
		local LastThink = 0
		local ChangeRate = 1
		
		hook.Add( "Think", "math.Approach Example", function()
		    local now = CurTime()
		    local timepassed = now - LastThink
		    LastThink = now
		
		    MyNumber = math.Approach( MyNumber, Target, ChangeRate * timepassed )
		
		    -- Normally, you would use MyNumber in code that appears here.
		end )
		
		-- The following functions are for example only:
		function GetMyNumber()
		    return MyNumber
		end
		
		function SetMyNumberTarget( newtarget )
		    Target = newtarget
		end
		
		function SetMyNumberChangeRate( newrate )
		    ChangeRate = newrate
		end
		```
    **/
    
    public static function Approach(current:Float, target:Float, change:Float):Float;
    
    
    /**
        Converts radians to degrees.
		
		Name | Description
		--- | ---
		`radians` | Value to be converted to degrees.
		
		
		`**Returns:** degrees
    **/
    
    public static function deg(radians:Float):Float;
    
    
    /**
        ***Deprecated:** You should use math. Distance instead
		
		Returns the difference between two points in 2D space. Alias of math.Distance.
		
		Name | Description
		--- | ---
		`x1` | X position of first point
		`y1` | Y position of first point
		`x2` | X position of second point
		`y2` | Y position of second point
		
		
		`**Returns:** Distance between the two points.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( math.Distance( 1, 2, 5, 6 ) ) -- distance bet
		```
		**Output:**
		
		5.6568542494924
    **/
    @:deprecated("You should use math. Distance instead")
    public static function Dist(x1:Float, y1:Float, x2:Float, y2:Float):Float;
    
    
    /**
        Remaps the value from one range to another
		
		Name | Description
		--- | ---
		`value` | The value
		`inMin` | The minimum of the initial range
		`inMax` | The maximum of the initial range
		`outMin` | The minimum of new range
		`outMax` | The maximum of new range
		
		
		`**Returns:** The number in the new range
		
		___
		### Lua Examples
		#### Example 1
		Example usage, converts a value from range 0-1, to range 0-255.
		
		```lua 
		print( math.Remap( 0.5, 0, 1, 0, 255 ) )
		```
		**Output:**
		
		127.5
    **/
    
    public static function Remap(value:Float, inMin:Float, inMax:Float, outMin:Float, outMax:Float):Float;
    
    
    /**
        ***Deprecated:** This is removed in Lua versions later than what GMod is currently using. You should use the % operator or math. fmod instead.
		
		Returns the modulus of the specified values. Same as math.fmod.
		
		Name | Description
		--- | ---
		`base` | The base value
		`modulator` | Modulator
		
		
		`**Returns:** The calculated modulus
    **/
    @:deprecated("This is removed in Lua versions later than what GMod is currently using. You should use the % operator or math. fmod instead.")
    public static function mod(base:Float, modulator:Float):Float;
    
    
    /**
        Floors or rounds a number down.
		
		Name | Description
		--- | ---
		`number` | The number to be rounded down.
		
		
		`**Returns:** floored numbers
		
		___
		### Lua Examples
		#### Example 1
		Round pi.
		
		```lua 
		print(math.floor(math.pi))
		```
		**Output:**
		
		3
		
		#### Example 2
		Demonstrates the difference between math.Round and math.floor.
		
		```lua 
		local value = 3.6
		
		print( math.Round( value ), math.floor( value ) )
		```
		**Output:**
		
		4 3
    **/
    
    public static function floor(number:Float):Float;
    
    
    /**
        Takes a normalised number and returns the floating point representation.
		
		Name | Description
		--- | ---
		`normalizedFraction` | The value to get the normalized fraction and the exponent from.
		`exponent` | The value to get the normalized fraction and the exponent from.
		
		
		`**Returns:** result
    **/
    
    public static function ldexp(normalizedFraction:Float, exponent:Float):Float;
    
    
    /**
        Returns the x power of the Euler constant e.
		
		Name | Description
		--- | ---
		`exponent` | The exponent for the function.
		
		
		`**Returns:** e to the specified power
    **/
    
    public static function exp(exponent:Float):Float;
    
    
    /**
        Returns the smallest value of all arguments.
		
		Name | Description
		--- | ---
		`numbers` | Numbers to get the smallest from.
		
		
		`**Returns:** The smallest number
		
		___
		### Lua Examples
		#### Example 1
		Get the smallest number of a group.
		
		```lua 
		print( math.min( 1, 2, -3, 464, 654698468 ) )
		```
		**Output:**
		
		-3
    **/
    
    public static function min(numbers:Rest<Dynamic>):Float;
    
    
    /**
        Basic code for Bézier-Spline algorithm.
		
		Name | Description
		--- | ---
		`tDiff` | From 0 to 1, where alongside the spline the point will be.
		`tPoints` | A table of Vectors. The amount cannot be less than 4.
		`tMax` | Just leave this at 1.
		
		
		`**Returns:** Point on Bezier curve, related to tDiff.
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function, makes a black box moving along the beizer curve made out of 4 points
		
		```lua 
		local points = { Vector( 100, 100, 0 ), Vector( 200, 200, 0 ), Vector( 300, 100, 0 ), Vector( 400, 200, 0 ) }
		hook.Add( "HUDPaint", "BSplinePointExample", function()
		    -- Draw the points
		    for id, p in pairs( points ) do
		        draw.RoundedBox( 0, p.x - 2, p.y - 2, 4, 4, color_white )
		    end
		
		    -- Draw the spline
		    local pos = math.BSplinePoint( ( math.cos( CurTime() ) + 1 ) / 2, points, 1 )
		    draw.RoundedBox( 0, pos.x - 2, pos.y - 2, 4, 4, Color( 0, 0, 0 ) )
		end )
		```
    **/
    
    public static function BSplinePoint(tDiff:Float, tPoints:AnyTable, tMax:Float):Vector;
    
    
    /**
        Returns the integral and fractional component of the modulo operation.
		
		Name | Description
		--- | ---
		`base` | The base value.
		
		
		Name | Description
		--- | ---
		`a` | The integral component.
		`b` | The fractional component.
		
		
		___
		### Lua Examples
		#### Example 1
		Finds the integral and fractional components of 5.6.
		
		```lua 
		print(math.modf(5.6))
		```
		**Output:**
		
		5   0.6
    **/
    
    public static function modf(base:Float):MathLibModfReturn;
    
    
    /**
        Returns a random float between min and max. 
		
		See also math.random
		
		Name | Description
		--- | ---
		`min` | The minimum value.
		`max` | The maximum value.
		
		
		`**Returns:** Random float between min and max.
    **/
    
    public static function Rand(min:Float, max:Float):Float;
    
    
    /**
        Converts an integer to a binary (base-2) string.
		
		Name | Description
		--- | ---
		`int` | Number to be converted.
		
		
		`**Returns:** Binary number string. The length of this will always be a multiple of 3.
		
		___
		### Lua Examples
		#### Example 1
		Prints the binary representation of 4
		
		```lua 
		print(math.IntToBin(4))
		```
		**Output:**
		
		100
    **/
    
    public static function IntToBin(int:Int):String;
    
    
    /**
        Returns the square root of the number.
		
		Name | Description
		--- | ---
		`value` | Value to get the square root of.
		
		
		`**Returns:** squareRoot
    **/
    
    public static function sqrt(value:Float):Float;
    
    
    /**
        Returns the hyperbolic cosine of the given angle.
		
		Name | Description
		--- | ---
		`number` | Angle in radians.
		
		
		`**Returns:** The hyperbolic cosine of the given angle.
    **/
    
    public static function cosh(number:Float):Float;
    
    
    /**
        Increments an angle towards another by specified rate.
		
		**Note:** This function is for numbers representing angles (0-360), NOT Angle objects!
		
		Name | Description
		--- | ---
		`currentAngle` | The current angle to increase
		`targetAngle` | The angle to increase towards
		`rate` | The amount to approach the target angle by
		
		
		`**Returns:** Modified angle
    **/
    
    public static function ApproachAngle(currentAngle:Float, targetAngle:Float, rate:Float):Float;
    
    
    /**
        ***INTERNAL** Use math. BSplinePoint instead.
		
		Basic code for Bezier-Spline algorithm, helper function for math.BSplinePoint.
		
		**Bug:** BUG Sending in a value < 1 will result in an infinite loop. Pull Request: #1477
		
		Name | Description
		--- | ---
		`i` | 
		`k` | BUG Sending in a value < 1 will result in an infinite loop. Pull Request: #1477
		`t` | 
		`tinc` | 
		
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL: Use math. BSplinePoint instead.")
    public static function calcBSplineN(i:Float, k:Float, t:Float, tinc:Float):Float;
    
    
    /**
        Calculates the difference between two angles.
		
		Name | Description
		--- | ---
		`a` | The first angle.
		`b` | The second angle.
		
		
		`**Returns:** The difference between the angles between -180 and 180
		
		___
		### Lua Examples
		#### Example 1
		Find the angle difference between various angles
		
		```lua 
		print("Angle difference between 159 and 240 is " .. math.AngleDifference(159, 240))
		print("Angle difference between 240 and 159 is " .. math.AngleDifference(240, 159))
		print("Angle difference between 58 and 145 is " .. math.AngleDifference(58, 145))
		```
		**Output:**
		
		Angle difference between 159 and 240 is -81 Angle difference between 240 and 159 is 81 Angle difference between 58 and 145 is -87
    **/
    
    public static function AngleDifference(a:Float, b:Float):Float;
    
    
    /**
        Returns the difference between two points in 2D space.
		
		Name | Description
		--- | ---
		`x1` | X position of first point
		`y1` | Y position of first point
		`x2` | X position of second point
		`y2` | Y position of second point
		
		
		`**Returns:** Distance between the two points
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( math.Distance( 1, 2, 5, 6 ) ) -- distance bet
		```
		**Output:**
		
		5.6568542494924
    **/
    
    public static function Distance(x1:Float, y1:Float, x2:Float, y2:Float):Float;
    
    
    /**
        Rounds towards zero.
		
		Name | Description
		--- | ---
		`num` | The number to truncate
		`digits` | The amount of digits to keep after the point.
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		local num = 54.59874
		
		print( math.Truncate( num, 2 ) ) -- 54.59
		print( math.Round( num, 2 ) ) -- 54.6
		```
    **/
    
    public static function Truncate(num:Float, ?digits:Float):Void;
    
    
    /**
        Rounds the given value to the nearest whole number or to the given decimal places.
		
		Name | Description
		--- | ---
		`value` | The value to round.
		`decimals` | The decimal places to round to.
		
		
		`**Returns:** The rounded value.
		
		___
		### Lua Examples
		#### Example 1
		Rounds a number to the nearest whole number.
		
		```lua 
		print(math.Round(104.6256712))
		```
		**Output:**
		
		105
		
		#### Example 2
		Rounds the number to two decimal places.
		
		```lua 
		print(math.Round(104.6256712, 2))
		```
		**Output:**
		
		104.63
    **/
    
    public static function Round(value:Float, ?decimals:Float):Float;
    
    
    /**
        Returns the cosine of given angle.
		
		Name | Description
		--- | ---
		`number` | Angle in radians
		
		
		`**Returns:** Cosine of given angle
		
		___
		### Lua Examples
		#### Example 1
		Prints the cosine of 3.14159265 (Pi)
		
		```lua 
		print( math.cos( 3.14159265 ) )
		```
		**Output:**
		
		-1
    **/
    
    public static function cos(number:Float):Float;
    
    
    /**
        Converts an angle in degrees to it's equivalent in radians.
		
		Name | Description
		--- | ---
		`degrees` | The angle measured in degrees.
		
		
		`**Returns:** radians
		
		___
		### Lua Examples
		#### Example 1
		Convert various angles in degrees to their equivalent in radians.
		
		```lua 
		print( "Degrees: 360, Radians: " .. math.rad( 360 ) ) -- 2*pi
		print( "Degrees: 180, Radians: " .. math.rad( 180 ) ) -- pi
		print( "Degrees: 90, Radians: " .. math.rad( 90 ) ) -- pi/2
		print( "Degrees: 1, Radians: " .. math.rad( 1 ) ) -- pi/180
		```
		**Output:**
		
		Degrees: 360, Radians: 6.2831853071796 Degrees: 180, Radians: 3.1415926535898 Degrees: 90, Radians: 1.5707963267949 Degrees: 1, Radians: 0.017453292519943
    **/
    
    public static function rad(degrees:Float):Float;
    
    
    /**
        With one argument, return the natural logarithm of x (to base e). 
		
		With two arguments, return the logarithm of x to the given base, calculated as log(x)/log(base).
		
		Name | Description
		--- | ---
		`x` | The value to get the base from exponent from.
		`base` | The logarithmic base.
		
		
		`**Returns:** Logarithm of x to the given base
    **/
    
    public static function log(x:Float, ?base:Float):Float;
    
    
    /**
        Calculates the progress of a value fraction, taking in to account given easing fractions
		
		Name | Description
		--- | ---
		`progress` | Fraction of the progress to ease
		`easeIn` | Fraction of how much easing to begin with
		`easeOut` | Fraction of how much easing to end with
		
		
		`**Returns:** Eased Value
		
		___
		### Lua Examples
		#### Example 1
		Calculates the easing of three situations
		
		```lua 
		print(math.EaseInOut(0.1, 0.1, 0.1))
		print(math.EaseInOut(0.2, 0.1, 0.1))
		print(math.EaseInOut(0.3, 0.1, 0.1))
		```
		**Output:**
		
		0.055555... 0.166666... 0.277777...
    **/
    
    public static function EaseInOut(progress:Float, easeIn:Float, easeOut:Float):Float;
    
    
    /**
        Returns the hyperbolic tangents of the given number.
		
		Name | Description
		--- | ---
		`number` | Angle in radians.
		
		
		`**Returns:** The hyperbolic tangent of the given angle.
    **/
    
    public static function tanh(number:Float):Float;
    
    
    /**
        Converts a binary string into a number.
		
		Name | Description
		--- | ---
		`string` | Binary string to convert
		
		
		`**Returns:** Base 10 number.
		
		___
		### Lua Examples
		#### Example 1
		Will print the string "101010101" as a number in console.
		
		```lua 
		print( math.BinToInt( "101010101" ) )
		```
		**Output:**
		
		341
    **/
    
    public static function BinToInt(string:String):Float;
    
    
    /**
        Used to split the number value into a normalized fraction and an exponent. Two values are returned: the first is a multiplier in the range 1/2 (inclusive) to 1 (exclusive) and the second is an integer exponent. 
		
		The result is such that x = m*2^e.
		
		Name | Description
		--- | ---
		`x` | The value to get the normalized fraction and the exponent from.
		
		
		Name | Description
		--- | ---
		`a` | m, multiplier - between 0.5 and 1
		`b` | e, exponent - always an integer
    **/
    
    public static function frexp(x:Float):MathLibFrexpReturn;
    
    
    /**
        Returns the largest value of all arguments.
		
		Name | Description
		--- | ---
		`numbers` | Numbers to get the largest from
		
		
		`**Returns:** The largest number
		
		___
		### Lua Examples
		#### Example 1
		Get the largest number of a group.
		
		```lua 
		print( math.max( 464, 654698468, 1, 3, 2 ) )
		```
		
		#### Example 2
		Prevent a value from falling under a certain minimum. A one-sided version of math.Clamp.
		
		```lua 
		local minimumValue = 5
		
		function lowClamp(num)
		
		     return math.max( minimumValue, num )
		
		end
		
		print( lowClamp( 0.1 ) )
		print( lowClamp( -6 ) )
		print( lowClamp( 5 ) )
		print( lowClamp( 8 ) )
		print( lowClamp( 24 ) )
		```
    **/
    
    public static function max(numbers:Rest<Dynamic>):Float;
    
    
    /**
        Returns the arc sine of the given number.
		
		Name | Description
		--- | ---
		`normal` | Sine value in the range of -1 to 1.
		
		
		`**Returns:** An angle in radians, in the range -pi/2 to pi/2, which has the given sine value. nan if the argument is out of range.
    **/
    
    public static function asin(normal:Float):Float;
    
    
    /**
        Seeds the random number generator. The same seed will guarantee the same sequence of numbers each time with math.random. 
		
		For shared random values across predicted realms, use util.SharedRandom.
		
		**Warning:** Incorrect usage of this function will affect all random numbers in the game.
		
		Name | Description
		--- | ---
		`seed` | The new seed
    **/
    
    public static function randomseed(seed:Float):Void;
    
    
    /**
        atan2 functions like math.atan(y / x), except it also takes into account the quadrant of the angle and so doesn't have a limited range of output.
		
		**Note:** The Y argument comes first!
		
		Name | Description
		--- | ---
		`y` | Y coordinate.
		`x` | X coordinate.
		
		
		`**Returns:** The angle of the line from (0, 0) to (x, y) in radians, in the range -pi to pi.
		
		___
		### Lua Examples
		#### Example 1
		atan( 1 ) and atan2( 1, 1 ) are both math.pi / 4atan2( -1, -1 ) equals to ( (-3) * math.pi ) / 4
		
		```lua 
		print( atan( 1 ) )
		print( ata2( 1, 1 ) )
		print( atan2( -1, -1 ) )
		```
		**Output:**
		
		0.7853981633974483 0.7853981633974483 -2.356194490192345
    **/
    
    public static function atan2(y:Float, x:Float):Float;
    
    
    /**
        Returns the arc cosine of the given number.
		
		Name | Description
		--- | ---
		`cos` | Cosine value in range of -1 to 1.
		
		
		`**Returns:** An angle in radians, between 0 and pi, which has the given cos value. nan if the argument is out of range.
    **/
    
    public static function acos(cos:Float):Float;
    
    
    /**
        Returns the base-10 logarithm of x. This is usually more accurate than math.log(x, 10).
		
		Name | Description
		--- | ---
		`x` | The value to get the base from exponent from.
    **/
    
    public static function log10(x:Float):Void;
    
    
    /**
        Returns the tangent of the given angle.
		
		Name | Description
		--- | ---
		`value` | Angle in radians
		
		
		`**Returns:** The tangent of the given angle.
    **/
    
    public static function tan(value:Float):Float;
    
    
    /**
        Clamps a number between a minimum and maximum value
		
		Name | Description
		--- | ---
		`input` | The number to clamp.
		`min` | The minimum value, this function will never return a number less than this.
		`max` | The maximum value, this function will never return a number greater than this.
		
		
		`**Returns:** The clamped value.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates what this function does.
		
		```lua 
		print( math.Clamp( 10, 0, 5 ) ) -- 10 is greater than 5 so returns 5
		print( math.Clamp( 3, 0, 5 ) ) -- 3 is greater than 0 and less than 5, so returns 3
		print( math.Clamp( -1, 0, 5 ) ) -- -1 is less than 0, so returns 0
		```
		**Output:**
		
		5 3 0
		
		#### Example 2
		Heals player "ply" by 10 health, but won't let their health go above 100.
		
		```lua 
		ply:SetHealth( math.Clamp( ply:Health() + 10, 0, 100 ) )
		```
    **/
    
    public static function Clamp(input:Float, min:Float, max:Float):Float;
    
    
    /**
        Calculates the absolute value of a number (effectively removes any negative sign).
		
		Name | Description
		--- | ---
		`x` | The number to get the absolute value of.
		
		
		`**Returns:** absolute_value
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates what this function does.
		
		```lua 
		print( math.abs( 15 ) )
		print( math.abs( -15 ) )
		```
		**Output:**
		
		15 15
    **/
    
    public static function abs(x:Float):Float;
    
    
    /**
        Returns the modulus of the specified values. 
		
		While this is similar to the % operator, it will return a negative value if the first argument is negative, whereas the % operator will return a positive value even if the first operand is negative.
		
		Name | Description
		--- | ---
		`base` | The base value.
		`modulator` | The modulator.
		
		
		`**Returns:** The calculated modulus.
    **/
    
    public static function fmod(base:Float, modulator:Float):Float;
    
    
    /**
        Normalizes angle, so it returns value between -180 and 180.
		
		Name | Description
		--- | ---
		`angle` | The angle to normalize, in degrees.
		
		
		`**Returns:** The normalized angle, in the range of -180 to 180 degrees.
    **/
    
    public static function NormalizeAngle(angle:Float):Float;
    
    
    /**
        Returns x raised to the power y. In particular, math.pow(1.0, x) and math.pow(x, 0.0) always return 1.0, even when x is a zero or a NaN. If both x and y are finite, x is negative, and y is not an integer then math.pow(x, y) is undefined.
		
		Name | Description
		--- | ---
		`x` | Base.
		`y` | Exponent.
		
		
		`**Returns:** y power of x
    **/
    
    public static function pow(x:Float, y:Float):Float;
    
    
    /**
        Ceils or rounds a number up.
		
		Name | Description
		--- | ---
		`number` | The number to be rounded up.
		
		
		`**Returns:** ceiled numbers
		
		___
		### Lua Examples
		#### Example 1
		Round pi.
		
		```lua 
		print(math.ceil(math.pi))
		```
		**Output:**
		
		4
    **/
    
    public static function ceil(number:Float):Float;
    
    
    /**
        Returns the sine of given angle.
		
		Name | Description
		--- | ---
		`number` | Angle in radians
		
		
		`**Returns:** Sine for given angle
    **/
    
    public static function sin(number:Float):Float;
    
    
    /**
        When called without arguments, returns a uniform pseudo-random real number in the range 0 to 1 which includes 0 but excludes 1. 
		
		When called with an integer number m, returns a uniform pseudo-random integer in the range 1 to m inclusive. 
		
		 When called with two integer numbers m and n, returns a uniform pseudo-random integer in the range m to n inclusive. 
		
		 See also math.Rand
		
		Name | Description
		--- | ---
		`m` | If m is the only parameter: upper limit. If n is also provided: lower limit. If provided, this must be an integer.
		`n` | Upper limit. If provided, this must be an integer.
		
		
		`**Returns:** Random value
		
		___
		### Lua Examples
		#### Example 1
		Generate a random number between 1 and 400 with both math.random and math.Rand.
		
		```lua 
		print(math.random(1,400))
		
		print(math.Rand(1,400))
		```
		
		#### Example 2
		Select a random key from a table, where the keys have a different probability of being selected.
		
		```lua 
		function GetWeightedRandomKey(tab)
		    local sum = 0
		
		    for _, chance in pairs(tab) do
		        sum = sum + chance
		    end
		
		    local select = math.random() * sum
		
		    for key, chance in pairs(tab) do
		        select = select - chance
		        if select < 0 then return key end
		    end
		end
		
		-- Example usage:
		local fruit = {
		    Grape = 4.5,
		    Orange = 20,
		    Banana = 3.14
		}
		
		for i = 1, 5 do
		    print(GetWeightedRandomKey(fruit))
		end
		```
	**/
	@:overload(function ():Float {})
    @:overload(function (upperLimit:Int):Int {})
    public static function random(m:Int, n:Int):Int;
    
    
    /**
        Returns the fraction of where the current time is relative to the start and end times
		
		Name | Description
		--- | ---
		`start` | Start time in seconds
		`end` | End time in seconds
		`current` | Current time in seconds
		
		
		`**Returns:** Fraction
		
		___
		### Lua Examples
		#### Example 1
		Prints the time fraction of 5 between 0 and 10
		
		```lua 
		print(math.TimeFraction(0, 10, 5))
		```
		**Output:**
		
		0.5
    **/
    
    public static function TimeFraction(start:Float, end:Float, current:Float):Float;
    
    

}


@:multiReturn extern class MathLibModfReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class MathLibFrexpReturn {
var a:Float;
var b:Float;

}

