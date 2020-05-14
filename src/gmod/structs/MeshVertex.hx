package gmod.structs;
/**
    Table used by various functions, such as [IMesh](https://wiki.garrysmod.com/page/Category:IMesh): [BuildFromTriangles](https://wiki.garrysmod.com/page/IMesh/BuildFromTriangles).
**/
typedef MeshVertex = {
    /**
        The triangles tangent. Not used by the VertexLitGeneric shader.
    **/
    var tangent : Vector;
    /**
        The triangles normal required to calculate lighting(optional).
    **/
    var normal : Vector;
    /**
        The v texture scale.
    **/
    var v : Float;
    /**
        The triangles binormal. Not used by the VertexLitGeneric shader.
    **/
    var binormal : Vector;
    /**
        A table of four numbers. This is used by most shaders in Source to hold tangent information of the vertex ( tangentX, tangentY, tangentZ, tangentHandedness ).
    **/
    var userdata : AnyTable;
    /**
        The vertex color. Uses the Color structure.
    **/
    var color : Color;
    /**
        The u texture scale.
    **/
    var u : Float;
    /**
        The vertex position.
    **/
    var pos : Vector;
    
}
