package gmod.structs;
/**
    A structure containing vertex information for use with [surface](https://wiki.garrysmod.com/page/Category:surface). [DrawPoly](https://wiki.garrysmod.com/page/surface/DrawPoly). UV coordinates describe which part of a given texture should be drawn at a vertex - your graphics card's interpolator will fill in space between vertices. UV coords range from 0-1, with 0 being top/left and 1 being bottom/right. If you're using a texture these are mandatory.
	
	**Note:** Your points must be defined in a clockwise order. Otherwise, your shape will not render.
	
	**Note:** You must pass a table of tables with this structure to the function. You need to pass at least 3 points.
**/
typedef PolygonVertex = {
    /**
        The v texture coordinate of the vertex. Can be left blank.
    **/
    var v : Float;
    /**
        The u texture coordinate of the vertex. Can be left blank.
    **/
    var u : Float;
    /**
        The x coordinate of the vertex.
    **/
    var x : Float;
    /**
        The y coordinate of the vertex.
    **/
    var y : Float;
    
}
