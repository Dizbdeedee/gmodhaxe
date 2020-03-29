package gmod.gclass;


/**
    A class used to store the player inputs, such as mouse movement, view angles, IN_ Enums buttons pressed and analog movement, the data from this class is then transfered to a CMoveData during actual movement simulation. 
	
	Can be modified during GM:CreateMove, GM:StartCommand and used in read only with GM:SetupMove and Player:GetCurrentCommand.
**/
extern class CUserCmd {
    
    /**
        Sets the delta of the angular vertical mouse movement of the player. 
		
		See also CUserCmd:SetMouseX.
		
		Name | Description
		--- | ---
		`speed` | Angular vertical move delta.
    **/
    
    public function SetMouseY(speed:Float):Void;
    
    
    /**
        Returns true if the specified button(s) is pressed.
		
		Name | Description
		--- | ---
		`key` | Bitflag representing which button to check, see IN_ Enums.
		
		
		`**Returns:** Is key down or not
    **/
    
    public function KeyDown(key:IN):Bool;
    
    
    /**
        Returns tick count since joining the server.
		
		**Note:** This will always return 0 for bots.
		
		**Note:** Returns 0 clientside during prediction calls. If you are trying to use CUserCmd:Set*() on the client in a movement or command hook, keep doing so till TickCount returns a non-zero number to maintain prediction.
		
		`**Returns:** The amount of ticks passed since joining the server.
    **/
    
    public function TickCount():Float;
    
    
    /**
        Returns the delta of the angular horizontal mouse movement of the player.
		
		`**Returns:** xDelta
    **/
    
    public function GetMouseX():Float;
    
    
    /**
        When players are not sending usercommands to the server (often due to lag), their last usercommand will be executed multiple times as a backup. This function returns true if that is happening. 
		
		This will never return true clientside.
		
		`**Returns:** isForced
    **/
    
    public function IsForced():Bool;
    
    
    /**
        Sets speed the client wishes to move upwards with, negative to move down. 
		
		See also CUserCmd:SetSideMove and CUserCmd:SetForwardMove.
		
		Name | Description
		--- | ---
		`speed` | The new speed to request.
    **/
    
    public function SetUpMove(speed:Float):Void;
    
    
    /**
        The speed the client wishes to move forward with, negative if the clients wants to move backwards.
		
		`**Returns:** The desired speed
    **/
    
    public function GetForwardMove():Float;
    
    
    /**
        Sets the buttons as a bitflag. See also CUserCmd:GetButtons.
		
		**Note:** If you are looking to affect player movement, you may need to use CUserCmd:SetForwardMove instead of setting the keys.
		
		Name | Description
		--- | ---
		`buttons` | Bitflag representing which buttons are "down", see IN_ Enums.
    **/
    
    public function SetButtons(buttons:IN):Void;
    
    
    /**
        Sets speed the client wishes to move forward with, negative if the clients wants to move backwards. 
		
		See also CUserCmd:ClearMovement, CUserCmd:SetSideMove and CUserCmd:SetUpMove.
		
		Name | Description
		--- | ---
		`speed` | The new speed to request. The client will not be able to move faster than their set walk/sprint speed.
    **/
    
    public function SetForwardMove(speed:Float):Void;
    
    
    /**
        Gets the current impulse from the client, usually 0.
		
		`**Returns:** The impulse
    **/
    
    public function GetImpulse():Float;
    
    
    /**
        Removed a key bit from the current key bitflag.
		
		Name | Description
		--- | ---
		`button` | Bitflag to be removed from the key bitflag, see IN_ Enums.
    **/
    
    public function RemoveKey(button:IN):Void;
    
    
    /**
        Removes all keys from the command.
		
		**Note:** If you are looking to affect player movement, you may need to use CUserCmd:ClearMovement instead of clearing the buttons.
    **/
    
    public function ClearButtons():Void;
    
    
    /**
        Clears the movement from the command. 
		
		See also CUserCmd:SetForwardMove, CUserCmd:SetSideMove and CUserCmd:SetUpMove.
    **/
    
    public function ClearMovement():Void;
    
    
    /**
        Returns a bitflag indicating which buttons are pressed.
		
		`**Returns:** Pressed buttons, see IN_ Enums
    **/
    
    public function GetButtons():IN;
    
    
    /**
        Sets the direction the client wants to move in.
		
		**Note:** The pitch (vertical) angle should be clamped to +/- 89° to prevent the player's view from glitching.
		
		Name | Description
		--- | ---
		`viewAngle` | New view angles.
		
		
		___
		### Lua Examples
		#### Example 1
		Locks the player's view to only vertical movement.
		
		```lua 
		hook.Add("InputMouseApply", "LockToPitchOnly", function( ccmd, x, y, angle )
		    -- By leaving angle.roll and angle.yaw alone, we effectively lock them
		    angle.pitch = math.Clamp( angle.pitch + y / 50, -89, 89 )
		    ccmd:SetViewAngles( angle )
		    return true
		end)
		```
    **/
    
    public function SetViewAngles(viewAngle:Angle):Void;
    
    
    /**
        Returns an increasing number representing the index of the user cmd. The value returned is occasionally 0 inside GM:CreateMove, so it's advised to check for a non-zero value if you wish to get the correct number.
		
		`**Returns:** The command number
    **/
    
    public function CommandNumber():Float;
    
    
    /**
        Sets the delta of the angular horizontal mouse movement of the player. 
		
		See also CUserCmd:SetMouseY.
		
		Name | Description
		--- | ---
		`speed` | Angular horizontal move delta.
    **/
    
    public function SetMouseX(speed:Float):Void;
    
    
    /**
        The speed the client wishes to move sideways with, positive if it wants to move right, negative if it wants to move left.
		
		`**Returns:** requestSpeed
    **/
    
    public function GetSideMove():Float;
    
    
    /**
        Sets speed the client wishes to move sidewards with, positive to move right, negative to move left. 
		
		See also CUserCmd:SetForwardMove and CUserCmd:SetUpMove.
		
		Name | Description
		--- | ---
		`speed` | The new speed to request.
    **/
    
    public function SetSideMove(speed:Float):Void;
    
    
    /**
        The speed the client wishes to move up with, negative if the clients wants to move down.
		
		`**Returns:** requestSpeed
    **/
    
    public function GetUpMove():Float;
    
    
    /**
        Returns the delta of the angular vertical mouse movement of the player.
		
		`**Returns:** yDelta
    **/
    
    public function GetMouseY():Float;
    
    
    /**
        Sets the impulse command to be sent to the server. 
		
		For example, 101 is an impulse that will give the player all Half-Life 2 weapons with sv_cheats set to 1. Impulse 100 will toggle their flashlight.
		
		Name | Description
		--- | ---
		`speed` | The impulse to send.
    **/
    
    public function SetImpulse(speed:Float):Void;
    
    
    /**
        Returns the scroll delta as whole number.
		
		`**Returns:** Scroll delta
    **/
    
    public function GetMouseWheel():Float;
    
    
    /**
        Gets the direction the player is looking in.
		
		`**Returns:** requestDir
    **/
    
    public function GetViewAngles():Angle;
    
    
    /**
        Forces the associated player to select a weapon. This is used internally in the default HL2 weapon selection HUD. 
		
		This may not work immediately if the current command is in prediction. Use input.SelectWeapon to switch the weapon from the client when the next available command can do so.
		
		**Note:** This is the ideal function to use to create a custom weapon selection HUD, as it allows prediction to run properly for WEAPON:Deploy and GM:PlayerSwitchWeapon
		
		Name | Description
		--- | ---
		`weapon` | The weapon entity to select.
    **/
    
    public function SelectWeapon(weapon:Weapon):Void;
    
    
    /**
        Sets the scroll delta.
		
		Name | Description
		--- | ---
		`speed` | The scroll delta.
    **/
    
    public function SetMouseWheel(speed:Float):Void;
    
    
}



