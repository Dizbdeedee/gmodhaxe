package gmod.structs;
/**
    Table structure used as trace result. Default values are when the trace hits nothing.
**/
typedef TraceResult = {
    /**
        The position the trace stopped. This will be the provided endpos if the trace hit nothing.
    **/
    var HitPos : Vector;
    /**
        The contents of the hit surface. See CONTENTS_ Enums.
    **/
    var Contents : CONTENTS;
    /**
        The entity hit by the trace. 
		
		Default: NULL
    **/
    var ?Entity : Entity;
    /**
        Given the trace started in a solid enviroment, this will return at what distance the trace left the solid from 0-1. Doesn't work if the trace hit a non-worldspawn entity. 
		
		Default: 0
    **/
    var ?FractionLeftSolid : Float;
    /**
        The direction of the trace as a normal vector (vector with length of 1).
    **/
    var Normal : Vector;
    /**
        The ID of the hitbox hit by the trace. 
		
		Default: 0
    **/
    var ?HitBox : Float;
    /**
        MAT_ Enums of the material hit by the trace. 
		
		Default: 0
    **/
    var ?MatType : MAT;
    /**
        The direction of the surface that was hit as a normal vector (vector with length of 1). 
		
		Default: Vector(0, 0, 0)
    **/
    var ?HitNormal : Vector;
    /**
        The surface flags of the hit surface. See SURF_ Enums. 
		
		Default: 0
    **/
    var ?SurfaceFlags : SURF;
    /**
        Indicates whenever the trace hit a no-draw brush. 
		
		Default: false
    **/
    var ?HitNoDraw : Bool;
    /**
        The origin of the trace. Will match the provided startpos.
    **/
    var StartPos : Vector;
    /**
        Indicates whenever the trace hit the sky. 
		
		Default: false
    **/
    var ?HitSky : Bool;
    /**
        The surface material (not texture) of whatever the trace hit. Will be "**displacement**" if the trace hit a displacement, and **studio** if it hit a prop. 
		
		Default: "**empty**"
    **/
    var ?HitTexture : String;
    /**
        ID of hit surface property from scripts/surfaceproperties.txt. You can get the name using util.GetSurfacePropName. 
		
		Used for CEffectData:SetSurfaceProp. 
		
		Default: 0
    **/
    var ?SurfaceProps : Float;
    /**
        HITGROUP_ Enums describing what hitgroup the trace hit (not the same as HitBox). 
		
		Default: 0
    **/
    var ?HitGroup : HITGROUP;
    /**
        The displacement flags of the hit surface. See DISPSURF_ Enums. 
		
		Default: 0
    **/
    var ?DispFlags : DISPSURF;
    /**
        Indicates whenever the trace hit the world. 
		
		Default: false
    **/
    var ?HitWorld : Bool;
    /**
        Indicates whether the trace hit something. 
		
		Default: false
    **/
    var ?Hit : Bool;
    /**
        The PhysObj ID that was hit. 
		
		Used for Entity:GetPhysicsObjectNum. 
		
		Default: 0
    **/
    var ?PhysicsBone : Float;
    /**
        Indicates whenever the trace did not hit the world. 
		
		Default: false
    **/
    var ?HitNonWorld : Bool;
    /**
        Indicates whenever the trace started in a solid enviroment. 
		
		Default: false
    **/
    var ?StartSolid : Bool;
    /**
        This indicates the how much of your trace length was used from 0-1 (resultLength/originalLength). 
		
		Default: 1
    **/
    var ?Fraction : Float;
    /**
        True if the entire trace is inside a solid. 
		
		Default: false
    **/
    var ?AllSolid : Bool;
    
}
