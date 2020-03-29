package gmod.enums;
/**
    Enumerations used by CNavArea:GetAttributes and CNavArea:HasAttributes.
**/
@:native("_G")
extern enum abstract NAV_MESH(Int) {
    /**
        Area should not be considered for hiding spot generation
    **/
    var NAV_MESH_DONT_HIDE;
    /**
        This area represents stairs, do not attempt to climb or jump them - just walk up
    **/
    var NAV_MESH_STAIRS;
    /**
        
    **/
    var NAV_MESH_NAV_BLOCKER;
    /**
        Must crouch to use this node/area
    **/
    var NAV_MESH_CROUCH;
    /**
        Area has designer specified cost controlled by func_nav_cost entities
    **/
    var NAV_MESH_FUNC_COST;
    /**
        Do not adjust for obstacles, just move along area
    **/
    var NAV_MESH_PRECISE;
    /**
        Must walk to traverse this area
    **/
    var NAV_MESH_WALK;
    /**
        Hostages shouldn't use this area
    **/
    var NAV_MESH_NO_HOSTAGES;
    /**
        The nav area is invalid.
    **/
    var NAV_MESH_INVALID;
    /**
        Avoid this area unless alternatives are too dangerous
    **/
    var NAV_MESH_AVOID;
    /**
        Must stop when entering this area
    **/
    var NAV_MESH_STOP;
    /**
        This nav area is the climb point on the tip of an obstacle
    **/
    var NAV_MESH_OBSTACLE_TOP;
    /**
        Must run to traverse this area
    **/
    var NAV_MESH_RUN;
    /**
        Inhibit discontinuity jumping
    **/
    var NAV_MESH_NO_JUMP;
    /**
        Bots hiding in this area should stand
    **/
    var NAV_MESH_STAND;
    /**
        Area may become blocked, and should be periodically checked
    **/
    var NAV_MESH_TRANSIENT;
    /**
        Area is in an elevator's path
    **/
    var NAV_MESH_HAS_ELEVATOR;
    /**
        Don't merge this area with adjacent areas
    **/
    var NAV_MESH_NO_MERGE;
    /**
        Must jump to traverse this area (only used during generation)
    **/
    var NAV_MESH_JUMP;
    /**
        This nav area is adjacent to a drop of at least CliffHeight
    **/
    var NAV_MESH_CLIFF;
    
}