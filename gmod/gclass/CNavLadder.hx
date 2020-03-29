package gmod.gclass;
#if server

/**
    An object that represents a ladder for Nextbots.
**/
extern class CNavLadder {
    
    /**
        Removes the given nav ladder.
    **/
    
    public function Remove():Void;
    
    
    /**
        Returns the world position based on given height relative to the ladder.
		
		Name | Description
		--- | ---
		`height` | The Z position in world space coordinates.
		
		
		`**Returns:** The closest point on the ladder to that height.
    **/
    
    public function GetPosAtHeight(height:Float):Vector;
    
    
    /**
        Returns the bottom area of the CNavLadder.
		
		`**Returns:** 
    **/
    
    public function GetBottomArea():CNavArea;
    
    
    /**
        Returns the bottom most position of the ladder.
		
		`**Returns:** The bottom most position of the ladder.
    **/
    
    public function GetBottom():Vector;
    
    
    /**
        Disconnects this ladder from given area in a single direction.
		
		Name | Description
		--- | ---
		`area` | The CNavArea this to disconnect from.
    **/
    
    public function Disconnect(area:CNavArea):Void;
    
    
    /**
        Returns the top right CNavArea of the CNavLadder.
		
		`**Returns:** The top right CNavArea of the CNavLadder.
    **/
    
    public function GetTopRightArea():CNavArea;
    
    
    /**
        Returns whether this CNavLadder has an outgoing ( one or two way ) connection to given CNavArea in given direction.
		
		Name | Description
		--- | ---
		`navArea` | The CNavArea to test against.
		`navDirType` | The direction, in which to look for the connection. See NavDir_ Enums
		
		
		`**Returns:** Whether this CNavLadder has an outgoing ( one or two way ) connection to given CNavArea in given direction.
    **/
    
    public function IsConnectedAtSide(navArea:CNavArea, navDirType:NavDir):Bool;
    
    
    /**
        Connects this ladder to a CNavArea with a one way connection. ( From this ladder to the target area ). 
		
		See CNavArea:ConnectTo for making the connection from area to ladder.
		
		Name | Description
		--- | ---
		`area` | The area this ladder leads to.
    **/
    
    public function ConnectTo(area:CNavArea):Void;
    
    
    /**
        Sets the top forward area of the CNavLadder.
		
		Name | Description
		--- | ---
		`area` | 
    **/
    
    public function SetTopForwardArea(area:CNavArea):Void;
    
    
    /**
        Returns the direction of this CNavLadder. ( The direction in which players back will be facing if they are looking directly at the ladder )
		
		`**Returns:** The direction of this CNavLadder.
    **/
    
    public function GetNormal():Vector;
    
    
    /**
        Returns the top forward CNavArea of the CNavLadder.
		
		`**Returns:** The top forward CNavArea of the CNavLadder.
    **/
    
    public function GetTopForwardArea():CNavArea;
    
    
    /**
        Returns the top behind CNavArea of the CNavLadder.
		
		`**Returns:** The top behind CNavArea of the CNavLadder.
    **/
    
    public function GetTopBehindArea():CNavArea;
    
    
    /**
        Sets the top right area of the CNavLadder.
		
		Name | Description
		--- | ---
		`area` | 
    **/
    
    public function SetTopRightArea(area:CNavArea):Void;
    
    
    /**
        Returns the length of the ladder.
		
		`**Returns:** The length of the ladder.
    **/
    
    public function GetLength():Float;
    
    
    /**
        Sets the bottom area of the CNavLadder.
		
		Name | Description
		--- | ---
		`area` | 
    **/
    
    public function SetBottomArea(area:CNavArea):Void;
    
    
    /**
        Sets the top behind area of the CNavLadder.
		
		Name | Description
		--- | ---
		`area` | 
    **/
    
    public function SetTopBehindArea(area:CNavArea):Void;
    
    
    /**
        Returns the width of the ladder in Hammer Units.
		
		`**Returns:** The width of the ladder in Hammer Units.
    **/
    
    public function GetWidth():Float;
    
    
    /**
        Returns the top left CNavArea of the CNavLadder.
		
		`**Returns:** The top left CNavArea of the CNavLadder.
    **/
    
    public function GetTopLeftArea():CNavArea;
    
    
    /**
        Returns this CNavLadders unique ID.
		
		`**Returns:** The unique ID.
    **/
    
    public function GetID():Float;
    
    
    /**
        Sets the top left area of the CNavLadder.
		
		Name | Description
		--- | ---
		`area` | 
    **/
    
    public function SetTopLeftArea(area:CNavArea):Void;
    
    
    /**
        Returns the topmost position of the ladder.
		
		`**Returns:** The topmost position of the ladder.
    **/
    
    public function GetTop():Vector;
    
    
    /**
        Returns whether this CNavLadder is valid or not.
		
		`**Returns:** Whether this CNavLadder is valid or not.
    **/
    
    public function IsValid():Bool;
    
    
}



#end