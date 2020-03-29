package gmod.gclass;
#if server

/**
    NextBots are a new system to create NPCs in the Source Engine, utilizing the more powerful navmesh library system for navigation over the old node based system. 
	
	This page lists all possible functions usable with NextBots. 
	
	 See NextBot NPC Creation for more information on how to create NextBot NPCs.
**/
extern class NextBot extends Entity {
    
    /**
        To be called in the behaviour coroutine only! Will yield until the bot has reached the goal or is stuck
		
		Name | Description
		--- | ---
		`pos` | The position we want to get to
		`options` | A table containing a bunch of tweakable options. number lookahead - Minimum look ahead distance. number tolerance - How close we must be to the goal before it can be considered complete. boolean draw - Draw the path. Only visible on listen servers and single player. number maxage - Maximum age of the path before it times out. number repath - Rebuilds the path after this number of seconds.
		
		
		`**Returns:** Either "failed", "stuck", "timeout" or "ok" - depending on how the NPC got on
    **/
    
    public function MoveToPos(pos:Vector, options:AnyTable):String;
    
    
    /**
        Returns a table of hiding spots.
		
		Name | Description
		--- | ---
		`specs` | This table should contain the search info. string type - The type (optional, only 'hiding' supported) Vector pos - the position to search. number radius - the radius to search. number stepup - the highest step to step up. number stepdown - the highest we can step down without being hurt.
		
		
		`**Returns:** An unsorted table of tables containing: Vector vector - The position of the hiding spot number distance - the distance to that position
    **/
    
    public function FindSpots(specs:AnyTable):AnyTable;
    
    
    /**
        Like NextBot:FindSpots but only returns a vector.
		
		Name | Description
		--- | ---
		`type` | Either "random", "near", "far"
		`options` | This table should contain the search info. string type - The type (Only'hiding' for now) Vector pos - the position to search. number radius - the radius to search. number stepup - the highest step to step up. number stepdown - the highest we can step down without being hurt.
		
		
		`**Returns:** If it finds a spot it will return a vector. If not it will return nil.
    **/
    
    public function FindSpot(type:String, options:AnyTable):Vector;
    
    
    /**
        Become a ragdoll and remove the entity.
		
		Name | Description
		--- | ---
		`info` | Damage info passed from an onkilled event
		
		
		`**Returns:** The created ragdoll, if any.
    **/
    
    public function BecomeRagdoll(info:CTakeDamageInfo):Entity;
    
    
    /**
        Sets the solid mask for given NextBot. 
		
		The default solid mask of a NextBot is MASK_NPCSOLID.
		
		Name | Description
		--- | ---
		`mask` | The new mask, see CONTENTS_ Enums and MASK_ Enums
    **/
    
    public function SetSolidMask(mask:CONTENTS):Void;
    
    
    /**
        To be called in the behaviour coroutine only! Plays an animation sequence and waits for it to end before returning.
		
		Name | Description
		--- | ---
		`name` | The sequence name
		`speed` | Playback Rate of that sequence
    **/
    
    public function PlaySequenceAndWait(name:String, ?speed:Float):Void;
    
    
    /**
        Should only be called in BodyUpdate. This sets the move_x and move_y pose parameters of the bot to fit how they're currently moving, sets the animation speed to suit the ground speed, and calls FrameAdvance.
		
		**Bug:** BUG This function might cause crashes with some activities. Issue Tracker: #3420
    **/
    
    public function BodyMoveXY():Void;
    
    
    /**
        Returns squared distance to an entity or a position. 
		
		See also NextBot:GetRangeTo.
		
		Name | Description
		--- | ---
		`to` | The position to measure distance to. Can be an entity.
		
		
		`**Returns:** The squared distance
    **/
    
    public function GetRangeSquaredTo(to:Vector):Float;
    
    
    /**
        Start doing an activity (animation)
		
		Name | Description
		--- | ---
		`activity` | One of the ACT_ Enums
    **/
    
    public function StartActivity(activity:ACT):Void;
    
    
    /**
        Returns the currently running activity
		
		`**Returns:** The current activity
    **/
    
    public function GetActivity():Float;
    
    
    /**
        Returns the solid mask for given NextBot.
		
		`**Returns:** The solid mask, see CONTENTS_ Enums and MASK_ Enums
    **/
    
    public function GetSolidMask():CONTENTS;
    
    
    /**
        Called from Lua when the NPC is stuck. This should only be called from the behaviour coroutine - so if you want to override this function and do something special that yields - then go for it. 
		
		You should always call self.loco:ClearStuck() in this function to reset the stuck status - so it knows it's unstuck. See CLuaLocomotion:ClearStuck.
    **/
    
    public function HandleStuck():Void;
    
    
    /**
        Returns the distance to an entity or position. 
		
		See also NextBot:GetRangeSquaredTo.
		
		Name | Description
		--- | ---
		`to` | The position to measure distance to. Can be an entity.
		
		
		`**Returns:** The distance
    **/
    
    public function GetRangeTo(to:Vector):Float;
    
    
}



#end