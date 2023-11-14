package gmod.gclass;

extern class SurfaceInfo {

    /**
        Returns the brush surface's material.

        `**Returns:** Material of one portion of a brush model
    **/
    function GetMaterial():IMaterial;

    /**
        Returns a list of vertices the brush surface is built from.

        `**Returns:** A list of Vector points. This will usually be 4 corners of a quadrilateral in counter-clockwise order.
    **/
    function GetVerticies():LuaArrayExt<Vector>;

    /**
        Checks if the brush surface is a nodraw surface, meaning it will not be drawn by the engine.

        `**Note:** This internally checks the SURFDRAW_NODRAW flag.

        `**Returns:** Returns true if this surface won't be drawn.
    **/
    function IsNoDraw():Bool;

    /**
        Checks if the brush surface is displaying the skybox.

        `**Note:** This internally checks the SURFDRAW_SKY flag.

        `**Returns:** Returns true if the surface is the sky.
    **/
    function IsSky():Bool;

    /**
        Checks if the brush surface is water.

        `**Note:** This internally checks the SURFDRAW_WATER flag.

        `**Returns:** Returns true if the surface is water.
    **/
    function IsWater():Bool;

}