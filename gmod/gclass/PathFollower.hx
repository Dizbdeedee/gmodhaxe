package gmod.gclass;
#if server

/**
    Path object for a NextBot NPC. Returned by Path.
**/
extern class PathFollower {
    
    /**
        How close we can get to the goal to call it done
		
		Name | Description
		--- | ---
		`distance` | The distance we're setting it to
    **/
    
    public function SetGoalTolerance(distance:Float):Void;
    
    
    /**
        Returns the vector position of distance along path
		
		Name | Description
		--- | ---
		`distance` | The distance along the path to query
		
		
		`**Returns:** The position
		
		___
		### Lua Examples
		#### Example 1
		Gets the current position on the path as a Vector.
		
		```lua 
		path:GetPositionOnPath( path:GetCursorPosition() )
		```
    **/
    
    public function GetPositionOnPath(distance:Float):Vector;
    
    
    /**
        Returns the last segment of the path.
		
		`**Returns:** A table with PathSegment structure.
    **/
    
    public function LastSegment():PathSegment;
    
    
    /**
        Sets the cursor position to given distance. 
		
		For relative distance, see PathFollower:MoveCursor.
		
		Name | Description
		--- | ---
		`distance` | The distance to move the cursor (in world units)
    **/
    
    public function MoveCursorTo(distance:Float):Void;
    
    
    /**
        Sets minimum range movement goal must be along path
		
		Name | Description
		--- | ---
		`mindist` | The minimum look ahead distance
    **/
    
    public function SetMinLookAheadDistance(mindist:Float):Void;
    
    
    /**
        The closest position along the path to a position
		
		Name | Description
		--- | ---
		`position` | The point we're querying for
		
		
		`**Returns:** The closest position on the path
    **/
    
    public function GetClosestPosition(position:Vector):Vector;
    
    
    /**
        If you created your path with type "Chase" this functions should be used in place of PathFollower:Update to cause the bot to chase the specified entity.
		
		Name | Description
		--- | ---
		`bot` | The bot to update along the path
		`ent` | The entity we want to chase
    **/
    
    public function Chase(bot:NextBot, ent:Entity):Void;
    
    
    /**
        Move the bot along the path.
		
		Name | Description
		--- | ---
		`bot` | The bot to update along the path
    **/
    
    public function Update(bot:NextBot):Void;
    
    
    /**
        Returns the cursor data
		
		`**Returns:** A table with 3 keys: number curvature Vector forward Vector pos
    **/
    
    public function GetCursorData():AnyTable;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public function GetHindrance():Entity;
    
    
    /**
        Returns how close we can get to the goal to call it done.
		
		`**Returns:** The distance we're setting it to
    **/
    
    public function GetGoalTolerance():Float;
    
    
    /**
        Returns the current goal data. Can return nil if the current goal is invalid, for example immediately after PathFollower:Update.
		
		`**Returns:** A table with PathSegment structure.
    **/
    
    public function GetCurrentGoal():PathSegment;
    
    
    /**
        Moves the cursor by give distance. 
		
		For a function that sets the distance, see PathFollower:MoveCursorTo.
		
		Name | Description
		--- | ---
		`distance` | The distance to move the cursor (in relative world units)
    **/
    
    public function MoveCursor(distance:Float):Void;
    
    
    /**
        Returns the current progress along the path
		
		`**Returns:** The current progress
    **/
    
    public function GetCursorPosition():Float;
    
    
    /**
        Returns the age since the path was built
		
		`**Returns:** Path age
    **/
    
    public function GetAge():Float;
    
    
    /**
        Returns the total length of the path
		
		`**Returns:** The length of the path
    **/
    
    public function GetLength():Float;
    
    
    /**
        Returns all of the segments of the given path.
		
		`**Returns:** A table of tables with PathSegment structure.
    **/
    
    public function GetAllSegments():PathSegment;
    
    
    /**
        Moves the cursor to the end of the path
    **/
    
    public function MoveCursorToStart():Void;
    
    
    /**
        Compute shortest path from bot to 'goal' via A* algorithm.
		
		Name | Description
		--- | ---
		`from` | The nextbot we're generating for
		`to` | To point
		`generator` | A funtion that allows you to alter the path generation. See example below for the default function.
		
		
		`**Returns:** If returns true, path was found to the goal position. If returns false, path may either be invalid (use IsValid() to check), or valid but doesn't reach all the way to the goal.
		
		___
		### Lua Examples
		#### Example 1
		The default path generator. You do not have to provide the PathFollower.Compute any generator functions if you want to use the default generator.
		
		```lua 
		path:Compute( self, pos, function( area, fromArea, ladder, elevator, length )
		    if ( !IsValid( fromArea ) ) then
		
		        // first area in path, no cost
		        return 0
		    
		    else
		    
		        if ( !self.loco:IsAreaTraversable( area ) ) then
		            // our locomotor says we can't move here
		            return -1
		        end
		
		        // compute distance traveled along path so far
		        local dist = 0
		
		        if ( IsValid( ladder ) ) then
		            dist = ladder:GetLength()
		        elseif ( length > 0 ) then
		            // optimization to avoid recomputing length
		            dist = length
		        else
		            dist = ( area:GetCenter() - fromArea:GetCenter() ):GetLength()
		        end
		
		        local cost = dist + fromArea:GetCostSoFar()
		
		        // check height change
		        local deltaZ = fromArea:ComputeAdjacentConnectionHeightChange( area )
		        if ( deltaZ >= self.loco:GetStepHeight() ) then
		            if ( deltaZ >= self.loco:GetMaxJumpHeight() ) then
		                // too high to reach
		                return -1
		            end
		
		            // jumping is slower than flat ground
		            local jumpPenalty = 5
		            cost = cost + jumpPenalty * dist
		        elseif ( deltaZ < -self.loco:GetDeathDropHeight() ) then
		            // too far to drop
		            return -1
		        end
		
		        return cost
		    end
		end )
		```
    **/
    
    public function Compute(from:NextBot, to:Vector, ?generator:Function):Bool;
    
    
    /**
        Returns the minimum range movement goal must be along path.
		
		`**Returns:** The minimum look ahead distance
    **/
    
    public function GetMinLookAheadDistance():Float;
    
    
    /**
        Draws the path. This is meant for debugging - and uses debug overlay.
    **/
    
    public function Draw():Void;
    
    
    /**
        Invalidates the current path
    **/
    
    public function Invalidate():Void;
    
    
    /**
        Returns the path end position
		
		`**Returns:** The end position
    **/
    
    public function GetEnd():Vector;
    
    
    /**
        Moves the cursor to the end of the path
    **/
    
    public function MoveCursorToEnd():Void;
    
    
    /**
        Moves the cursor of the path to the closest position compared to given vector.
		
		Name | Description
		--- | ---
		`pos` | 
		`type` | Seek type 0 = SEEK_ENTIRE_PATH - Search the entire path length 1 = SEEK_AHEAD - Search from current cursor position forward toward end of path 2 = SEEK_BEHIND - Search from current cursor position backward toward path start
		`alongLimit` | 
    **/
    
    public function MoveCursorToClosestPosition(pos:Vector, ?type:Float, ?alongLimit:Float):Void;
    
    
    /**
        Resets the age which is retrieved by PathFollower:GetAge to 0.
    **/
    
    public function ResetAge():Void;
    
    
    /**
        Returns the path start position
		
		`**Returns:** The start position
    **/
    
    public function GetStart():Vector;
    
    
    /**
        Returns the first segment of the path.
		
		`**Returns:** A table with PathSegment structure.
    **/
    
    public function FirstSegment():PathSegment;
    
    
    /**
        Returns true if the path is valid
		
		`**Returns:** Wether the path is valid or not.
    **/
    
    public function IsValid():Bool;
    
    
}



#end