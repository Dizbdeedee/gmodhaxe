package gmod.gclass;


/**
    A class used to store the inputs from CUserCmd and other information related to the current movement simulation, such as velocity, position and so on. 
	
	This can only be accessed during GM:SetupMove , GM:Move , GM:PlayerTick and GM:FinishMove.
**/
extern class CMoveData {
    
    /**
        Returns whether the key is down or not
		
		Name | Description
		--- | ---
		`key` | The key to test, see IN_ Enums
		
		
		`**Returns:** Is the key down or not
    **/
    
    public function KeyDown(key:IN):Bool;
    
    
    /**
        Returns the vertical speed of the player. ( Z axis of CMoveData:GetVelocity )
		
		`**Returns:** Vertical speed
    **/
    
    public function GetUpSpeed():Float;
    
    
    /**
        Gets the players velocity.
		
		**Bug:** BUG This will return Vector(0,0,0) sometimes when walking on props. Issue Tracker: #3413
		
		`**Returns:** The players velocity
		
		___
		### Lua Examples
		#### Example 1
		Prints the player's velocity.
		
		```lua 
		function GM:Move( ply, movedata )
		    print( movedata:GetVelocity() )
		end
		```
    **/
    
    public function GetVelocity():Vector;
    
    
    /**
        Sets the player's velocity
		
		Name | Description
		--- | ---
		`velocity` | The velocity to set
		
		
		___
		### Lua Examples
		#### Example 1
		Make the player shake to hell and back.
		
		```lua 
		function GM:SetupMove( ply, movedata )
		    movedata:SetVelocity( VectorRand() * 800 )
		end
		```
    **/
    
    public function SetVelocity(velocity:Vector):Void;
    
    
    /**
        Gets the player's position.
		
		`**Returns:** The player's position.
		
		___
		### Lua Examples
		#### Example 1
		Print's the players position.
		
		```lua 
		function GM:SetupMove( ply, movedata )
		    print( movedata:GetOrigin() )
		end
		```
    **/
    
    public function GetOrigin():Vector;
    
    
    /**
        Gets the aim angle. On client is the same as Entity:GetAngles.
		
		`**Returns:** Aiming angle
    **/
    
    public function GetAngles():Angle;
    
    
    /**
        Gets the number passed to "impulse" console command
		
		`**Returns:** The impulse
    **/
    
    public function GetImpulseCommand():Float;
    
    
    /**
        Sets the pressed buttons on the move data
		
		Name | Description
		--- | ---
		`buttons` | A number representing which buttons are down, see IN_ Enums
    **/
    
    public function SetButtons(buttons:IN):Void;
    
    
    /**
        Sets the players position.
		
		Name | Description
		--- | ---
		`pos` | The position
		
		
		___
		### Lua Examples
		#### Example 1
		Make the player freeze at the origin of the map.
		
		```lua 
		function GM:SetupMove( ply, movedata )
		    movedata:SetOrigin( vector_origin )
		end
		```
    **/
    
    public function SetOrigin(pos:Vector):Void;
    
    
    /**
        Returns whether the key was down or not. Unlike CMoveData:KeyDown, it will return false if CMoveData:KeyPressed is true and it will return true if CMoveData:KeyReleased is true.
		
		Name | Description
		--- | ---
		`key` | The key to test, seee IN_ Enums
		
		
		`**Returns:** Was the key down or not
    **/
    
    public function KeyWasDown(key:IN):Bool;
    
    
    /**
        Returns the strafe speed of the player.
		
		`**Returns:** speed
    **/
    
    public function GetSideSpeed():Float;
    
    
    /**
        Sets the 'old' pressed buttons on the move data. These buttons are used to work out which buttons have been released, which have just been pressed and which are being held down.
		
		Name | Description
		--- | ---
		`buttons` | A number representing which buttons were down, see IN_ Enums
    **/
    
    public function SetOldButtons(buttons:IN):Void;
    
    
    /**
        Returns the angle the player is moving at. For more info, see CMoveData:SetMoveAngles.
		
		`**Returns:** The move direction
    **/
    
    public function GetMoveAngles():Angle;
    
    
    /**
        Returns the maximum client speed of the player
		
		`**Returns:** The maximum client speed
    **/
    
    public function GetMaxClientSpeed():Float;
    
    
    /**
        Sets the radius that constrains the players movement. It is unknown what this function does as changing its values doesn't affect player movement.
		
		Name | Description
		--- | ---
		`radius` | The new constraint radius
    **/
    
    public function SetConstraintRadius(radius:Float):Void;
    
    
    /**
        Sets players forward speed.
		
		Name | Description
		--- | ---
		`speed` | New forward speed
    **/
    
    public function SetForwardSpeed(speed:Float):Void;
    
    
    /**
        Sets the impulse command. This isn't actually utilised in the engine anywhere.
		
		Name | Description
		--- | ---
		`impulse` | The impulse to set
    **/
    
    public function SetImpulseCommand(impulse:Float):Void;
    
    
    /**
        Sets the serverside move angles, making the movement keys act as if player was facing that direction.
		
		**Bug:** BUG This does nothing clientside. Issue Tracker: #1181
		
		Name | Description
		--- | ---
		`dir` | The aim direction.
    **/
    
    public function SetMoveAngles(dir:Angle):Void;
    
    
    /**
        Gets which buttons are down
		
		`**Returns:** An integer representing which buttons are down, see IN_ Enums
    **/
    
    public function GetButtons():IN;
    
    
    /**
        Sets angles.
		
		**Bug:** BUG This function does nothing. Issue Tracker: #2382
		
		Name | Description
		--- | ---
		`ang` | The angles.
    **/
    
    public function SetAngles(ang:Angle):Void;
    
    
    /**
        Sets players strafe speed.
		
		Name | Description
		--- | ---
		`speed` | Strafe speed
    **/
    
    public function SetSideSpeed(speed:Float):Void;
    
    
    /**
        Sets absolute move angles.( ? ) Doesn't seem to do anything.
		
		Name | Description
		--- | ---
		`ang` | New absolute move angles
    **/
    
    public function SetAbsMoveAngles(ang:Angle):Void;
    
    
    /**
        Sets the maximum speed of the player. This must match with CMoveData:SetMaxClientSpeed both, on server and client. Doesn't seem to be doing anything on it's own, use CMoveData:SetMaxClientSpeed instead.
		
		Name | Description
		--- | ---
		`maxSpeed` | The new maximum speed
    **/
    
    public function SetMaxSpeed(maxSpeed:Float):Void;
    
    
    /**
        Sets vertical speed of the player. ( Z axis of CMoveData:SetVelocity )
		
		Name | Description
		--- | ---
		`speed` | Vertical speed to set
    **/
    
    public function SetUpSpeed(speed:Float):Void;
    
    
    /**
        Sets the maximum player speed. Player won't be able to run or sprint faster then this value. This also automatically sets CMoveData:SetMaxSpeed when used in the GM:SetupMove hook. You must set it manually in the GM:Move hook. This must be called on both client and server to avoid prediction errors. This will not reduce speed in air.
		
		**Note:** Setting this to 0 will not make the player stationary. It won't do anything.
		
		Name | Description
		--- | ---
		`maxSpeed` | The new maximum speed
		
		
		___
		### Lua Examples
		#### Example 1
		Doesn't let the player to run or sprint faster than 100 units per second.
		
		```lua 
		hook.Add("SetupMove","MySpeed", function( ply, mv )
		    mv:SetMaxClientSpeed( 100 )
		end )
		```
		
		#### Example 2
		Doubles the players speed properly.
		
		```lua 
		hook.Add( "Move", "testestst", function( ply, mv, usrcmd )
		    local speed = mv:GetMaxSpeed() * 2
		    mv:SetMaxSpeed( speed )
		    mv:SetMaxClientSpeed( speed )
		end )
		```
    **/
    
    public function SetMaxClientSpeed(maxSpeed:Float):Void;
    
    
    /**
        Returns the maximum speed of the player.
		
		`**Returns:** The maximum speed
    **/
    
    public function GetMaxSpeed():Float;
    
    
    /**
        Gets the aim angle. Only works clientside, server returns same as CMoveData:GetAngles.
		
		`**Returns:** The aim angle
    **/
    
    public function GetOldAngles():Angle;
    
    
    /**
        Returns whether the key was released
		
		Name | Description
		--- | ---
		`key` | A key to test, see IN_ Enums
		
		
		`**Returns:** Was the key released or not.
    **/
    
    public function KeyReleased(key:IN):Bool;
    
    
    /**
        Adds keys to the move data, as if player pressed them.
		
		Name | Description
		--- | ---
		`keys` | Keys to add, see IN_ Enums
    **/
    
    public function AddKey(keys:IN):Void;
    
    
    /**
        Gets the aim angle. Seems to be same as CMoveData:GetAngles.
		
		`**Returns:** Aiming angle
    **/
    
    public function GetAbsMoveAngles():Angle;
    
    
    /**
        Get which buttons were down last frame
		
		`**Returns:** An integer representing which buttons were down, see IN_ Enums
    **/
    
    public function GetOldButtons():IN;
    
    
    /**
        Returns whether the key was pressed. If you want to check if the key is held down, try CMoveData:KeyDown
		
		Name | Description
		--- | ---
		`key` | The key to test, see IN_ Enums
		
		
		`**Returns:** Was the key pressed or not.
    **/
    
    public function KeyPressed(key:IN):Bool;
    
    
    /**
        Returns the players forward speed.
		
		`**Returns:** speed
    **/
    
    public function GetForwardSpeed():Float;
    
    
    /**
        Sets old aim angles. ( ? ) Doesn't seem to be doing anything.
		
		Name | Description
		--- | ---
		`aimAng` | The old angles
    **/
    
    public function SetOldAngles(aimAng:Angle):Void;
    
    
    /**
        Returns the radius that constrains the players movement.
		
		`**Returns:** The constraint radius
    **/
    
    public function GetConstraintRadius():Float;
    
    
}



