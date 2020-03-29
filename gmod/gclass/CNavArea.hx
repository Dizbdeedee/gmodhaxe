package gmod.gclass;
#if server

/**
    An object returned by navmesh library functions.
**/
extern class CNavArea {
    
    /**
        Returns whether this area is in the Open List. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		`**Returns:** Whether this area is in the Open List.
    **/
    
    public function IsOpen():Bool;
    
    
    /**
        Returns true if this CNavArea contains the given vector.
		
		Name | Description
		--- | ---
		`pos` | The position to test.
		
		
		`**Returns:** True if the vector was inside and false otherwise.
    **/
    
    public function Contains(pos:Vector):Bool;
    
    
    /**
        Removes the given nav area.
    **/
    
    public function Remove():Void;
    
    
    /**
        Returns the cost from starting area this area when pathfinding. Set by CNavArea:SetCostSoFar. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		`**Returns:** The cost so far.
    **/
    
    public function GetCostSoFar():Float;
    
    
    /**
        Returns the NavDir_ Enums direction that the given vector faces on this CNavArea.
		
		Name | Description
		--- | ---
		`pos` | The position to compute direction towards.
		
		
		`**Returns:** The direction the vector is in relation to this CNavArea. See NavDir_ Enums.
    **/
    
    public function ComputeDirection(pos:Vector):NavDir;
    
    
    /**
        Returns whether we can be seen from the given position.
		
		Name | Description
		--- | ---
		`pos` | The position to check.
		
		
		Name | Description
		--- | ---
		`a` | Whether we can be seen or not.
		`b` | If we can be seen, this is returned with either the center or one of the corners of the Nav Area.
    **/
    
    public function IsVisible(pos:Vector):CNavAreaIsVisibleReturn;
    
    
    /**
        Removes this node from the Closed List. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
    **/
    
    public function RemoveFromClosedList():Void;
    
    
    /**
        Returns if we're shaped like a square.
		
		`**Returns:** If we're a square or not.
    **/
    
    public function IsRoughlySquare():Bool;
    
    
    /**
        Adds this CNavArea to the Open List. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
    **/
    
    public function AddToOpenList():Void;
    
    
    /**
        Adds this CNavArea to the closed list, a list of areas that have been checked by A* pathfinding algorithm. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
    **/
    
    public function AddToClosedList():Void;
    
    
    /**
        Returns all CNavLadders that have a ( one or two way ) connection from ( one and two way ) this CNavArea in given direction. 
		
		See CNavArea:GetLadders for a function that returns CNavLadder from/in all sides/directions.
		
		Name | Description
		--- | ---
		`navDir` | The direction, in which to look for CNavLadders. 0 = Up ( LadderDirectionType::LADDER_UP ) 1 = Down ( LadderDirectionType::LADDER_DOWN )
		
		
		`**Returns:** The CNavLadders that have a ( one or two way ) connection from this CNavArea in given direction.
    **/
    
    public function GetLaddersAtSide(navDir:Float):AnyTable;
    
    
    /**
        Returns the width this Nav Area.
		
		`**Returns:** 
    **/
    
    public function GetSizeX():Float;
    
    
    /**
        Sets the total cost when passing from starting area to the goal area through this node. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		Name | Description
		--- | ---
		`cost` | The total cost of the path to set. Must be above or equal 0.
    **/
    
    public function SetTotalCost(cost:Float):Void;
    
    
    /**
        Returns the height of this Nav Area.
		
		`**Returns:** 
    **/
    
    public function GetSizeY():Float;
    
    
    /**
        Returns a table of all the CNavAreas that have a ( one and two way ) connection from this CNavArea in given direction. 
		
		If an area has a one-way incoming connection to this CNavArea, then it will not be returned from this function, use CNavArea:GetIncomingConnections to get all incoming connections. 
		
		 See CNavArea:GetAdjacentAreas for a function that returns all areas from all sides/directions.
		
		Name | Description
		--- | ---
		`navDir` | The direction, in which to look for CNavAreas, see NavDir_ Enums.
		
		
		`**Returns:** A table of all CNavArea that have a ( one and two way ) connection from this CNavArea in given direction. Returns an empty table if this area has no outgoing connections to any other areas in given direction.
    **/
    
    public function GetAdjacentAreasAtSide(navDir:NavDir):AnyTable;
    
    
    /**
        Returns the height difference on the Z axis of the two CNavAreas. This is calculated from the center most point on both CNavAreas.
		
		Name | Description
		--- | ---
		`navArea` | The nav area to test against.
		
		
		`**Returns:** The ground height change.
    **/
    
    public function ComputeGroundHeightChange(navArea:CNavArea):Float;
    
    
    /**
        Returns whether the nav area is blocked or not, i.e. whether it can be walked through or not.
		
		Name | Description
		--- | ---
		`teamID` | The team ID to test, -2 = any team. Only 2 actual teams are available, 0 and 1.
		`ignoreNavBlockers` | Whether to ignore func_nav_blocker entities.
		
		
		`**Returns:** Whether the area is blocked or not
    **/
    
    public function IsBlocked(?teamID:Float, ?ignoreNavBlockers:Bool):Bool;
    
    
    /**
        Returns the closest point of this Nav Area from the given position.
		
		Name | Description
		--- | ---
		`pos` | The given position, can be outside of the Nav Area bounds.
		
		
		`**Returns:** The closest position on this Nav Area.
    **/
    
    public function GetClosestPointOnArea(pos:Vector):Vector;
    
    
    /**
        Returns the total cost when passing from starting area to the goal area through this node. Set by CNavArea:SetTotalCost. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		`**Returns:** The total cost
    **/
    
    public function GetTotalCost():Float;
    
    
    /**
        Sets the cost from starting area this area when pathfinding. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		Name | Description
		--- | ---
		`cost` | The cost so far
    **/
    
    public function SetCostSoFar(cost:Float):Void;
    
    
    /**
        Returns the height difference between the edges of two connected navareas.
		
		Name | Description
		--- | ---
		`navarea` | 
		
		
		`**Returns:** The height change
    **/
    
    public function ComputeAdjacentConnectionHeightChange(navarea:CNavArea):Float;
    
    
    /**
        Disconnects this nav area from given area or ladder. (Only disconnects one way)
		
		Name | Description
		--- | ---
		`area` | The CNavArea or CNavLadder this to disconnect from.
    **/
    
    public function Disconnect(area:CNavArea):Void;
    
    
    /**
        Returns a random point on the nav area.
		
		`**Returns:** The random point on the nav area.
    **/
    
    public function GetRandomPoint():Vector;
    
    
    /**
        Returns a table of good hiding spots in this area. 
		
		See also CNavArea:GetExposedSpots.
		
		Name | Description
		--- | ---
		`type` | The type of spots to include. 0 = None (Not recommended) 1 = In Cover/basically a hiding spot, in a corner with good hard cover nearby 2 = good sniper spot, had at least one decent sniping corridor 4 = perfect sniper spot, can see either very far, or a large area, or both 8 = exposed, spot in the open, usually on a ledge or cliff, same as GetExposedSpots Values over 255 and below 0 will be clamped.
		
		
		`**Returns:** A table of Vectors
    **/
    
    public function GetHidingSpots(?type:Float):AnyTable;
    
    
    /**
        Sets the attributes for given CNavArea.
		
		Name | Description
		--- | ---
		`attribs` | The attribute bitflag. See NAV_MESH_ Enums
    **/
    
    public function SetAttributes(attribs:NAV_MESH):Void;
    
    
    /**
        Returns the parent CNavArea
		
		`**Returns:** The parent CNavArea
    **/
    
    public function GetParent():CNavArea;
    
    
    /**
        Returns a random CNavArea that has an outgoing ( one or two way ) connection from this CNavArea in given direction.
		
		Name | Description
		--- | ---
		`navDir` | The direction, in which to look for CNavAreas, see NavDir_ Enums.
		
		
		`**Returns:** The random CNavArea that has an outgoing ( one or two way ) connection from this CNavArea in given direction, if any.
    **/
    
    public function GetRandomAdjacentAreaAtSide(navDir:NavDir):CNavArea;
    
    
    /**
        Returns whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea in given direction. 
		
		See CNavArea:IsConnected for a function that checks all sides.
		
		Name | Description
		--- | ---
		`navArea` | The CNavArea to test against.
		`navDirType` | The direction, in which to look for the connection. See NavDir_ Enums
		
		
		`**Returns:** Whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea in given direction.
    **/
    
    public function IsConnectedAtSide(navArea:CNavArea, navDirType:NavDir):Bool;
    
    
    /**
        Connects this CNavArea to another CNavArea or CNavLadder with a one way connection. ( From this area to the target ) 
		
		See CNavLadder:ConnectTo for making the connection from ladder to area.
		
		Name | Description
		--- | ---
		`area` | The CNavArea or CNavLadder this area leads to.
    **/
    
    public function ConnectTo(area:CNavArea):Void;
    
    
    /**
        Draws the hiding spots on debug overlay. This includes sniper/exposed spots too!
    **/
    
    public function DrawSpots():Void;
    
    
    /**
        Returns a table of all the CNavAreas that have a one-way connection to this CNavArea. 
		
		If a CNavArea has a two-way connection to or from this CNavArea then it will not be returned from this function, use CNavArea:GetAdjacentAreas to get outgoing ( one and two way ) connections. 
		
		 See CNavArea:GetIncomingConnectionsAtSide for a function that returns one-way incoming connections from only one side/direction.
		
		`**Returns:** A table of all CNavAreas with one-way connection to this CNavArea. Returns an empty table if there are no one-way incoming connections to this CNavArea.
    **/
    
    public function GetIncomingConnections():AnyTable;
    
    
    /**
        Returns a table of all the CNavAreas that have a one-way connection to this CNavArea from given direction. 
		
		If a CNavArea has a two-way connection to or from this CNavArea then it will not be returned from this function, use CNavArea:GetAdjacentAreas to get outgoing ( one and two way ) connections. 
		
		 See CNavArea:GetIncomingConnections for a function that returns one-way incoming connections from all sides/directions.
		
		Name | Description
		--- | ---
		`navDir` | The direction, from which to look for CNavAreas, see NavDir_ Enums.
		
		
		`**Returns:** A table of all CNavAreas with one-way connection to this CNavArea from given direction. Returns an empty table if there are no one-way incoming connections to this CNavArea from given direction.
    **/
    
    public function GetIncomingConnectionsAtSide(navDir:NavDir):AnyTable;
    
    
    /**
        Returns the center most vector point for the given CNavArea.
		
		`**Returns:** The center vector.
    **/
    
    public function GetCenter():Vector;
    
    
    /**
        Drops a corner or all corners of a CNavArea to the ground below it.
		
		Name | Description
		--- | ---
		`corner` | The corner(s) to drop, uses NavCorner_ Enums
    **/
    
    public function PlaceOnGround(corner:NavCorner):Void;
    
    
    /**
        Returns whether this Nav Area is flat within the tolerance of the nav_coplanar_slope_limit_displacement and nav_coplanar_slope_limit convars.
		
		`**Returns:** Whether this CNavArea is mostly flat.
    **/
    
    public function IsFlat():Bool;
    
    
    /**
        Returns size info about the nav area.
		
		`**Returns:** Returns a table containing the following keys: Vector hi Vector lo number SizeX number SizeY number SizeZ
    **/
    
    public function GetExtentInfo():AnyTable;
    
    
    /**
        Returns true if this CNavArea is overlapping the given CNavArea.
		
		Name | Description
		--- | ---
		`navArea` | The CNavArea to test against.
		
		
		`**Returns:** True if the given CNavArea overlaps this CNavArea at any point.
    **/
    
    public function IsOverlappingArea(navArea:CNavArea):Bool;
    
    
    /**
        Returns the Place of the nav area.
		
		`**Returns:** The place of the nav area, or no value if it doesn't have a place set.
    **/
    
    public function GetPlace():String;
    
    
    /**
        Returns the amount of CNavAreas that have a connection ( one and two way ) from this CNavArea. 
		
		See CNavArea:GetAdjacentCountAtSide for a function that only returns area count from one side/direction.
		
		`**Returns:** The amount of CNavAreas that have a connection ( one and two way ) from this CNavArea.
    **/
    
    public function GetAdjacentCount():Float;
    
    
    /**
        Sets the Place of the nav area. 
		
		There is a limit of 256 Places per nav file.
		
		Name | Description
		--- | ---
		`place` | Set to "" to remove place from the nav area.
		
		
		`**Returns:** Returns true of operation succeeded, false otherwise.
    **/
    
    public function SetPlace(place:String):Bool;
    
    
    /**
        Draws this navarea on debug overlay.
    **/
    
    public function Draw():Void;
    
    
    /**
        Returns true if the given CNavArea has this attribute flag set.
		
		Name | Description
		--- | ---
		`attribs` | Attribute mask to check for, see NAV_MESH_ Enums
		
		
		`**Returns:** True if the CNavArea matches the given mask. False otherwise.
    **/
    
    public function HasAttributes(attribs:NAV_MESH):Bool;
    
    
    /**
        Returns the amount of CNavAreas that have a connection ( one or two way ) from this CNavArea in given direction. 
		
		See CNavArea:GetAdjacentCount for a function that returns CNavArea count from/in all sides/directions.
		
		Name | Description
		--- | ---
		`navDir` | The direction, in which to look for CNavAreas, see NavDir_ Enums.
		
		
		`**Returns:** The amount of CNavAreas that have a connection ( one or two way ) from this CNavArea in given direction.
    **/
    
    public function GetAdjacentCountAtSide(navDir:NavDir):Float;
    
    
    /**
        Whether this Nav Area is placed underwater.
		
		`**Returns:** Whether we're underwater or not.
    **/
    
    public function IsUnderwater():Bool;
    
    
    /**
        Returns the vector position of the corner for the given CNavArea.
		
		Name | Description
		--- | ---
		`cornerid` | The target corner to get the position of, takes NavCorner_ Enums.
		
		
		`**Returns:** The corner position.
    **/
    
    public function GetCorner(cornerid:NavCorner):Vector;
    
    
    /**
        Returns the attribute mask for the given CNavArea.
		
		**Note:** A navmesh that was generated with nav_quicksave set to 1 will have all CNavAreas attribute masks set to 0
		
		`**Returns:** Attribute mask for this CNavArea, see NAV_MESH_ Enums for the specific flags. NOTE A navmesh that was generated with nav_quicksave set to 1 will have all CNavAreas attribute masks set to 0
    **/
    
    public function GetAttributes():NAV_MESH;
    
    
    /**
        Returns a table of very bad hiding spots in this area. 
		
		See also CNavArea:GetHidingSpots.
		
		`**Returns:** A table of Vectors
    **/
    
    public function GetExposedSpots():AnyTable;
    
    
    /**
        Sets the new parent of this CNavArea.
		
		Name | Description
		--- | ---
		`parent` | The new parent to set
    **/
    
    public function SetParent(parent:CNavArea):Void;
    
    
    /**
        Returns this CNavAreas unique ID.
		
		`**Returns:** The unique ID.
    **/
    
    public function GetID():Float;
    
    
    /**
        Returns whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea. 
		
		See CNavArea:IsConnectedAtSide for a function that only checks for outgoing connections in one direction.
		
		Name | Description
		--- | ---
		`navArea` | The CNavArea to test against.
		
		
		`**Returns:** Whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea.
    **/
    
    public function IsConnected(navArea:CNavArea):Bool;
    
    
    /**
        Adds a hiding spot onto this nav area. 
		
		There's a limit of 255 hiding spots per area.
		
		Name | Description
		--- | ---
		`pos` | The position on the nav area
		`flags` | Flags describing what kind of hiding spot this is. 0 = None (Not recommended) 1 = In Cover/basically a hiding spot, in a corner with good hard cover nearby 2 = good sniper spot, had at least one decent sniping corridor 4 = perfect sniper spot, can see either very far, or a large area, or both 8 = exposed, spot in the open, usually on a ledge or cliff Values over 255 will be clamped.
    **/
    
    public function AddHidingSpot(pos:Vector, ?flags:Float):Void;
    
    
    /**
        Returns all CNavLadders that have a ( one or two way ) connection from this CNavArea. 
		
		See CNavArea:GetLaddersAtSide for a function that only returns CNavLadders in given direction.
		
		`**Returns:** The CNavLadders that have a ( one or two way ) connection from this CNavArea.
    **/
    
    public function GetLadders():AnyTable;
    
    
    /**
        Returns if this position overlaps the Nav Area within the given tolerance.
		
		Name | Description
		--- | ---
		`pos` | The overlapping position to test.
		`tolerance` | The tolerance of the overlapping, set to 0 for no tolerance.
		
		
		`**Returns:** Whether the given position overlaps the Nav Area or not.
    **/
    
    public function IsOverlapping(pos:Vector, ?tolerance:Float):Bool;
    
    
    /**
        Returns how this CNavArea is connected to its parent.
		
		`**Returns:** See NavTraverseType_ Enums
    **/
    
    public function GetParentHow():NavTraverseType;
    
    
    /**
        Returns whether the Open List is empty or not. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		`**Returns:** Whether the Open List is empty or not.
    **/
    
    public function IsOpenListEmpty():Bool;
    
    
    /**
        Clears the open and closed lists for a new search. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
    **/
    
    public function ClearSearchLists():Void;
    
    
    /**
        Returns whether this node is in the Closed List. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		`**Returns:** Whether this node is in the Closed List.
    **/
    
    public function IsClosed():Bool;
    
    
    /**
        Returns whether this Nav Area is in the same plane as the given one.
		
		Name | Description
		--- | ---
		`navArea` | The Nav Area to test.
		
		
		`**Returns:** Whether we're coplanar or not.
    **/
    
    public function IsCoplanar(navArea:CNavArea):Bool;
    
    
    /**
        Returns whether this CNavArea is valid or not.
		
		`**Returns:** Whether this CNavArea is valid or not.
    **/
    
    public function IsValid():Bool;
    
    
    /**
        Removes a CNavArea from the Open List with the lowest cost to traverse to from the starting node, and returns it. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
		
		`**Returns:** The CNavArea from the Open List with the lowest cost to traverse to from the starting node.
    **/
    
    public function PopOpenList():CNavArea;
    
    
    /**
        Returns a table of all the CNavAreas that have a ( one and two way ) connection from this CNavArea. 
		
		If an area has a one-way incoming connection to this CNavArea, then it will not be returned from this function, use CNavArea:GetIncomingConnections to get all one-way incoming connections. 
		
		 See CNavArea:GetAdjacentAreasAtSide for a function that only returns areas from one side/direction.
		
		`**Returns:** A table of all CNavArea that have a ( one and two way ) connection from this CNavArea. Returns an empty table if this area has no outgoing connections to any other areas.
    **/
    
    public function GetAdjacentAreas():AnyTable;
    
    
    /**
        Returns the elevation of this Nav Area at the given position.
		
		Name | Description
		--- | ---
		`pos` | The position to get the elevation from, the z value from this position is ignored and only the X and Y values are used to this task.
		
		
		`**Returns:** The elevation.
    **/
    
    public function GetZ(pos:Vector):Float;
    
    
    /**
        Sets the position of a corner of a nav area.
		
		Name | Description
		--- | ---
		`corner` | The corner to set, uses NavCorner_ Enums
		`position` | The new position to set.
    **/
    
    public function SetCorner(corner:NavCorner, position:Vector):Void;
    
    
    /**
        Moves this open list to appropriate position based on its CNavArea:GetTotalCost compared to the total cost of other areas in the open list. 
		
		Used in pathfinding via the A* algorithm. More information can be found on the Simple Pathfinding page.
    **/
    
    public function UpdateOnOpenList():Void;
    
    
}


@:multiReturn extern class CNavAreaIsVisibleReturn {
var a:Bool;
var b:Vector;

}

#end