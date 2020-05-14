package gmod.structs;
#if server
/**
    Structure represents a path segment, returned by [PathFollower](https://wiki.garrysmod.com/page/Category:PathFollower): [GetCurrentGoal](https://wiki.garrysmod.com/page/PathFollower/GetCurrentGoal), [PathFollower](https://wiki.garrysmod.com/page/Category:PathFollower): [FirstSegment](https://wiki.garrysmod.com/page/PathFollower/FirstSegment) and [PathFollower](https://wiki.garrysmod.com/page/Category:PathFollower): [LastSegment](https://wiki.garrysmod.com/page/PathFollower/LastSegment).
**/
typedef PathSegment = {
    /**
        The navmesh ladder this segment occupies, if any.
    **/
    var ladder : CNavLadder;
    /**
        The direction of travel to reach the end of this segment from the start, represented as a normalised vector.
    **/
    var forward : Vector;
    /**
        
    **/
    var m_portalHalfWidth : Float;
    /**
        The navmesh area this segment occupies.
    **/
    var area : CNavArea;
    /**
        Length of this segment.
    **/
    var length : Float;
    /**
        The position of the end of this segment.
    **/
    var pos : Vector;
    /**
        
    **/
    var curvature : Float;
    /**
        
    **/
    var m_portalCenter : Vector;
    /**
        Distance of this segment from the start of the path.
    **/
    var distanceFromStart : Float;
    /**
        The movement type of this segment, indicating how bots are expected to move along this segment.
    **/
    var type : Float;
    /**
        The direction of travel to reach the end of this segment from the start, represented as a cardinal direction integer 0 to 3, or 9 for vertical movement.
    **/
    var how : Float;
    
}
#end