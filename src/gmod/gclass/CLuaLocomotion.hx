package gmod.gclass;
#if server

/**
    This class is essentially what controls a NextBot NPC. You can access it in a NextBot NPC by using self.loco variable.
**/
extern class CLuaLocomotion {
    
    /**
        Gets the height the bot is scared to fall from
		
		`**Returns:** Current death drop height
    **/
    
    function GetDeathDropHeight():Float;
    
    
    /**
        Sets the location we want to get to
		
		Name | Description
		--- | ---
		`goal` | The vector we want to get to
		`goalweight` | If unsure then set this to 1
    **/
    
    function Approach(goal:Vector, goalweight:Float):Void;
    
    
    /**
        Returns whether the locomotion/nextbot is on ground or not.
		
		`**Returns:** Whether the locomotion/nextbot is on ground or not.
    **/
    
    function IsOnGround():Bool;
    
    
    /**
        Returns the current movement velocity as a vector
		
		`**Returns:** Current velocity
    **/
    
    function GetVelocity():Vector;
    
    
    /**
        Makes the bot jump
    **/
    
    function Jump():Void;
    
    
    /**
        Sets the current movement velocity
		
		Name | Description
		--- | ---
		`velocity` | 
    **/
    
    function SetVelocity(velocity:Vector):Void;
    
    
    /**
        Removes the stuck status from the bot
    **/
    
    function ClearStuck():Void;
    
    
    /**
        Sets the max height the bot can step up
		
		Name | Description
		--- | ---
		`height` | Height (default is 18)
    **/
    
    function SetStepHeight(height:Float):Void;
    
    
    /**
        Sets the acceleration speed
		
		Name | Description
		--- | ---
		`speed` | Speed acceleration (default is 400)
    **/
    
    function SetAcceleration(speed:Float):Void;
    
    
    /**
        Return unit vector in XY plane describing our direction of motion - even if we are currently not moving
		
		`**Returns:** A vector representing the X and Y movement
    **/
    
    function GetGroundMotionVector():Vector;
    
    
    /**
        Gets the deceleration speed
		
		`**Returns:** Current deceleration speed
    **/
    
    function GetDeceleration():Float;
    
    
    /**
        Returns the NextBot this locomotion is associated with.
		
		`**Returns:** The nextbot
    **/
    
    function GetNextBot():NextBot;
    
    
    /**
        Sets the max rate at which the NextBot can visually rotate. This will not affect moving or pathing.
		
		Name | Description
		--- | ---
		`yawRate` | Desired new maximum yaw rate
    **/
    
    function SetMaxYawRate(yawRate:Float):Void;
    
    
    /**
        Returns true if we're stuck
		
		`**Returns:** Whether we're stuck or not
    **/
    
    function IsStuck():Bool;
    
    
    /**
        Returns the current acceleration as a vector
		
		`**Returns:** Current acceleration
    **/
    
    function GetCurrentAcceleration():Vector;
    
    
    /**
        Returns whether or not the target in question is on a ladder or not.
		
		`**Returns:** If the target is on a ladder or not.
    **/
    
    function IsUsingLadder():Bool;
    
    
    /**
        Sets movement speed.
		
		Name | Description
		--- | ---
		`speed` | The new desired speed
    **/
    
    function SetDesiredSpeed(speed:Float):Void;
    
    
    /**
        Returns true of the locomotion engine is jumping or climbing
		
		`**Returns:** Whether we're climbing or jumping or not
    **/
    
    function IsClimbingOrJumping():Bool;
    
    
    /**
        Returns maximum jump height of this CLuaLocomotion.
		
		`**Returns:** The maximum jump height.
    **/
    
    function GetMaxJumpHeight():Float;
    
    
    /**
        Returns the acceleration speed
		
		`**Returns:** Current acceleration speed
    **/
    
    function GetAcceleration():Float;
    
    
    /**
        Returns the max rate at which the NextBot can visually rotate.
		
		`**Returns:** Maximum yaw rate
    **/
    
    function GetMaxYawRate():Float;
    
    
    /**
        Sets the locomotion's gravity.
		
		**Note:** With values 0 or below, or even lower positive values, the nextbot will start to drift sideways, use CLuaLocomotion:SetVelocity to counteract this.
		
		Name | Description
		--- | ---
		`gravity` | New gravity to set. Default is 1000.
    **/
    
    function SetGravity(gravity:Float):Void;
    
    
    /**
        Returns whether this CLuaLocomotion can reach and/or traverse/move in given CNavArea.
		
		Name | Description
		--- | ---
		`area` | The area to test
		
		
		`**Returns:** Whether this CLuaLocomotion can traverse given CNavArea.
    **/
    
    function IsAreaTraversable(area:CNavArea):Bool;
    
    
    /**
        Gets the height of the bot's jump
		
		`**Returns:** Current jump height
    **/
    
    function GetJumpHeight():Float;
    
    
    /**
        Returns true if we're trying to move.
		
		`**Returns:** Whether we're trying to move or not.
    **/
    
    function IsAttemptingToMove():Bool;
    
    
    /**
        Returns the locomotion's gravity.
		
		`**Returns:** The gravity.
    **/
    
    function GetGravity():Float;
    
    
    /**
        Sets the deceleration speed.
		
		Name | Description
		--- | ---
		`deceleration` | New deceleration speed (default is 400)
    **/
    
    function SetDeceleration(deceleration:Float):Void;
    
    
    /**
        Sets the height the bot is scared to fall from.
		
		Name | Description
		--- | ---
		`height` | Height (default is 200)
    **/
    
    function SetDeathDropHeight(height:Float):Void;
    
    
    /**
        Sets the height of the bot's jump
		
		Name | Description
		--- | ---
		`height` | Height (default is 58)
    **/
    
    function SetJumpHeight(height:Float):Void;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`landingGoal` | 
		`landingForward` | 
    **/
    
    function JumpAcrossGap(landingGoal:Vector, landingForward:Vector):Void;
    
    
    /**
        Gets the max height the bot can step up
		
		`**Returns:** Current step height
    **/
    
    function GetStepHeight():Float;
    
    
    /**
        Sets the direction we want to face
		
		Name | Description
		--- | ---
		`goal` | The vector we want to face
    **/
    
    function FaceTowards(goal:Vector):Void;
    
    
}



#end
