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
    
    public function GetDeathDropHeight():Float;
    
    
    /**
        Sets the location we want to get to
		
		Name | Description
		--- | ---
		`goal` | The vector we want to get to
		`goalweight` | If unsure then set this to 1
    **/
    
    public function Approach(goal:Vector, goalweight:Float):Void;
    
    
    /**
        Returns whether the locomotion/nextbot is on ground or not.
		
		`**Returns:** Whether the locomotion/nextbot is on ground or not.
    **/
    
    public function IsOnGround():Bool;
    
    
    /**
        Returns the current movement velocity as a vector
		
		`**Returns:** Current velocity
    **/
    
    public function GetVelocity():Vector;
    
    
    /**
        Makes the bot jump
    **/
    
    public function Jump():Void;
    
    
    /**
        Sets the current movement velocity
		
		Name | Description
		--- | ---
		`velocity` | 
    **/
    
    public function SetVelocity(velocity:Vector):Void;
    
    
    /**
        Removes the stuck status from the bot
    **/
    
    public function ClearStuck():Void;
    
    
    /**
        Sets the max height the bot can step up
		
		Name | Description
		--- | ---
		`height` | Height (default is 18)
    **/
    
    public function SetStepHeight(height:Float):Void;
    
    
    /**
        Sets the acceleration speed
		
		Name | Description
		--- | ---
		`speed` | Speed acceleration (default is 400)
    **/
    
    public function SetAcceleration(speed:Float):Void;
    
    
    /**
        Return unit vector in XY plane describing our direction of motion - even if we are currently not moving
		
		`**Returns:** A vector representing the X and Y movement
    **/
    
    public function GetGroundMotionVector():Vector;
    
    
    /**
        Gets the deceleration speed
		
		`**Returns:** Current deceleration speed
    **/
    
    public function GetDeceleration():Float;
    
    
    /**
        Returns the NextBot this locomotion is associated with.
		
		`**Returns:** The nextbot
    **/
    
    public function GetNextBot():NextBot;
    
    
    /**
        Sets the max rate at which the NextBot can visually rotate. This will not affect moving or pathing.
		
		Name | Description
		--- | ---
		`yawRate` | Desired new maximum yaw rate
    **/
    
    public function SetMaxYawRate(yawRate:Float):Void;
    
    
    /**
        Returns true if we're stuck
		
		`**Returns:** Whether we're stuck or not
    **/
    
    public function IsStuck():Bool;
    
    
    /**
        Returns the current acceleration as a vector
		
		`**Returns:** Current acceleration
    **/
    
    public function GetCurrentAcceleration():Vector;
    
    
    /**
        Returns whether or not the target in question is on a ladder or not.
		
		`**Returns:** If the target is on a ladder or not.
    **/
    
    public function IsUsingLadder():Bool;
    
    
    /**
        Sets movement speed.
		
		Name | Description
		--- | ---
		`speed` | The new desired speed
    **/
    
    public function SetDesiredSpeed(speed:Float):Void;
    
    
    /**
        Returns true of the locomotion engine is jumping or climbing
		
		`**Returns:** Whether we're climbing or jumping or not
    **/
    
    public function IsClimbingOrJumping():Bool;
    
    
    /**
        Returns maximum jump height of this CLuaLocomotion.
		
		`**Returns:** The maximum jump height.
    **/
    
    public function GetMaxJumpHeight():Float;
    
    
    /**
        Returns the acceleration speed
		
		`**Returns:** Current acceleration speed
    **/
    
    public function GetAcceleration():Float;
    
    
    /**
        Returns the max rate at which the NextBot can visually rotate.
		
		`**Returns:** Maximum yaw rate
    **/
    
    public function GetMaxYawRate():Float;
    
    
    /**
        Sets the locomotion's gravity.
		
		**Note:** With values 0 or below, or even lower positive values, the nextbot will start to drift sideways, use CLuaLocomotion:SetVelocity to counteract this.
		
		Name | Description
		--- | ---
		`gravity` | New gravity to set. Default is 1000.
    **/
    
    public function SetGravity(gravity:Float):Void;
    
    
    /**
        Returns whether this CLuaLocomotion can reach and/or traverse/move in given CNavArea.
		
		Name | Description
		--- | ---
		`area` | The area to test
		
		
		`**Returns:** Whether this CLuaLocomotion can traverse given CNavArea.
    **/
    
    public function IsAreaTraversable(area:CNavArea):Bool;
    
    
    /**
        Gets the height of the bot's jump
		
		`**Returns:** Current jump height
    **/
    
    public function GetJumpHeight():Float;
    
    
    /**
        Returns true if we're trying to move.
		
		`**Returns:** Whether we're trying to move or not.
    **/
    
    public function IsAttemptingToMove():Bool;
    
    
    /**
        Returns the locomotion's gravity.
		
		`**Returns:** The gravity.
    **/
    
    public function GetGravity():Float;
    
    
    /**
        Sets the deceleration speed.
		
		Name | Description
		--- | ---
		`deceleration` | New deceleration speed (default is 400)
    **/
    
    public function SetDeceleration(deceleration:Float):Void;
    
    
    /**
        Sets the height the bot is scared to fall from.
		
		Name | Description
		--- | ---
		`height` | Height (default is 200)
    **/
    
    public function SetDeathDropHeight(height:Float):Void;
    
    
    /**
        Sets the height of the bot's jump
		
		Name | Description
		--- | ---
		`height` | Height (default is 58)
    **/
    
    public function SetJumpHeight(height:Float):Void;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`landingGoal` | 
		`landingForward` | 
    **/
    
    public function JumpAcrossGap(landingGoal:Vector, landingForward:Vector):Void;
    
    
    /**
        Gets the max height the bot can step up
		
		`**Returns:** Current step height
    **/
    
    public function GetStepHeight():Float;
    
    
    /**
        Sets the direction we want to face
		
		Name | Description
		--- | ---
		`goal` | The vector we want to face
    **/
    
    public function FaceTowards(goal:Vector):Void;
    
    
}



#end