package gmod.libs;
#if client

/**
    The mesh library allows you to create meshes. A mesh is a set of vertices that define a 3D shape, for constant meshes you should use the IMesh object instead.
**/
@:native("_G.mesh")extern class MeshLib {
    
    /**
        Sets the normal to be used for the next vertex.
		
		Name | Description
		--- | ---
		`normal` | The normal of the vertex.
    **/
    
    public static function Normal(normal:Vector):Void;
    
    
    /**
        Sets the color to be used for the next vertex.
		
		Name | Description
		--- | ---
		`r` | Red component.
		`g` | Green component.
		`b` | Blue component.
		`a` | Alpha component.
    **/
    
    public static function Color(r:Float, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Pushes the new vertex data onto the render stack.
    **/
    
    public static function AdvanceVertex():Void;
    
    
    /**
        A table of four numbers. This is used by most shaders in Source to hold tangent information of the vertex ( tangentX, tangentY, tangentZ, tangentHandedness ).
		
		**Note:** It is recommended to use IMesh:BuildFromTriangles instead of the mesh library.
		
		Name | Description
		--- | ---
		`tangentX` | 
		`tangentY` | 
		`tangentZ` | 
		`tangentHandedness` | 
    **/
    
    public static function UserData(tangentX:Float, tangentY:Float, tangentZ:Float, tangentHandedness:Float):Void;
    
    
    /**
        Sets the texture coordinates for the next vertex. 
		
		Non-zero values of stage require the currently bound material to support it. For example, any LightmappedGeneric material supports stages 1 and 2 (lightmap texture coordinates).
		
		Name | Description
		--- | ---
		`stage` | The stage of the texture coordinate.
		`u` | U coordinate.
		`v` | V coordinate.
    **/
    
    public static function TexCoord(stage:Float, u:Float, v:Float):Void;
    
    
    /**
        Returns the amount of vertex that have yet been pushed.
		
		`**Returns:** vertexCount
    **/
    
    public static function VertexCount():Float;
    
    
    /**
        Draws a quad using a position, a normal and the size.
		
		Name | Description
		--- | ---
		`position` | The center of the quad.
		`normal` | The normal of the quad.
		`sizeX` | X size in pixels.
		`sizeY` | Y size in pixels.
    **/
    
    public static function QuadEasy(position:Vector, normal:Vector, sizeX:Float, sizeY:Float):Void;
    
    
    /**
        Ends the mesh and renders it.
    **/
    
    public static function End():Void;
    
    
    /**
        Sets the specular map values. 
		
		This function actually does nothing.
		
		Name | Description
		--- | ---
		`r` | The red channel multiplier of the specular map.
		`g` | The green channel multiplier of the specular map.
		`b` | The blue channel multiplier of the specular map.
		`a` | The alpha channel multiplier of the specular map.
    **/
    
    public static function Specular(r:Float, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Draws a quad using 4 vertices.
		
		Name | Description
		--- | ---
		`vertex1` | The first vertex.
		`vertex2` | The second vertex.
		`vertex3` | The third vertex.
		`vertex4` | The fourth vertex.
    **/
    
    public static function Quad(vertex1:Vector, vertex2:Vector, vertex3:Vector, vertex4:Vector):Void;
    
    
    /**
        Starts a new dynamic mesh. If an IMesh is passed, it will use that mesh instead.
		
		Name | Description
		--- | ---
		`mesh` | Mesh to build. This argument can be removed if you wish to build a "dynamic" mesh. See examples below.
		`primitiveType` | Primitive type, see MATERIAL_ Enums.
		`primiteCount` | The amount of primitives.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a triangle near Vector( 0, 0, 0 ) in the map using a dynamic mesh.
		
		```lua 
		local mat = Material( "editor/wireframe" ) -- The material (a wireframe)
		
		local verts = { -- A table of 3 vertices that form a triangle
		    { pos = Vector( 0,  0,  0 ), u = 0, v = 0 }, -- Vertex 1
		    { pos = Vector( 10, 0,  0 ), u = 1, v = 0 }, -- Vertex 2
		    { pos = Vector( 10, 10, 0 ), u = 1, v = 1 }, -- Vertex 3
		}
		
		hook.Add( "PostDrawOpaqueRenderables", "MeshLibTest", function()
		
		    render.SetMaterial( mat ) -- Apply the material
		    mesh.Begin( MATERIAL_TRIANGLES, 1 ) -- Begin writing to the dynamic mesh
		    for i = 1, #verts do
		        mesh.Position( verts[i].pos ) -- Set the position
		        mesh.TexCoord( 0, verts[i].u, verts[i].v ) -- Set the texture UV coordinates
		        mesh.AdvanceVertex() -- Write the vertex
		    end
		    mesh.End() -- Finish writing the mesh and draw it
		end )
		```
		
		#### Example 2
		Draws a triangle near Vector( 0, 0, 0 ) in the map using a static mesh.
		
		```lua 
		local mat = Material( "editor/wireframe" ) -- The material (a wireframe)
		local obj = Mesh() -- Create the IMesh object
		
		local verts = { -- A table of 3 vertices that form a triangle
		    { pos = Vector( 0,  0,  0 ), u = 0, v = 0 }, -- Vertex 1
		    { pos = Vector( 10, 0,  0 ), u = 1, v = 0 }, -- Vertex 2
		    { pos = Vector( 10, 10, 0 ), u = 1, v = 1 }, -- Vertex 3
		}
		
		mesh.Begin( obj, MATERIAL_TRIANGLES, 1 ) -- Begin writing to the static mesh
		for i = 1, #verts do
		    mesh.Position( verts[i].pos ) -- Set the position
		    mesh.TexCoord( 0, verts[i].u, verts[i].v ) -- Set the texture UV coordinates
		    mesh.AdvanceVertex() -- Write the vertex
		end
		mesh.End() -- Finish writing to the IMesh
		
		hook.Add( "PostDrawOpaqueRenderables", "MeshLibTest", function()
		
		    render.SetMaterial( mat ) -- Apply the material
		    obj:Draw() -- Draw the mesh
		end )
		```
    **/
    
    public static function Begin(?mesh:IMesh, primitiveType:MATERIAL, primiteCount:Float):Void;
    
    
    /**
        Sets the s tangent to be used. 
		
		This function actually does nothing.
		
		Name | Description
		--- | ---
		`sTanger` | The s tangent.
    **/
    
    public static function TangentS(sTanger:Vector):Void;
    
    
    /**
        Sets the position to be used for the next vertex.
		
		Name | Description
		--- | ---
		`position` | The position of the vertex.
    **/
    
    public static function Position(position:Vector):Void;
    
    
    /**
        Sets the T tangent to be used. 
		
		This function actually does nothing.
		
		Name | Description
		--- | ---
		`tTanger` | The t tangent.
    **/
    
    public static function TangentT(tTanger:Vector):Void;
    
    

}



#end