package gmod.structs;
/**
    Table returned by [util](https://wiki.garrysmod.com/page/Category:util). [GetSurfaceData](https://wiki.garrysmod.com/page/util/GetSurfaceData).
**/
typedef SurfacePropertyData = {
    /**
        Hardness threshold for impact sounds. HitSurface.hardnessFactor >= InflictorSurface.hardThreshold - hard impact sound (depends on hardVelocityThreshold's value), HitSurface.hardnessFactor < InflictorSurface.hardThreshold - soft impact sound (always).
    **/
    var hardThreshold : Float;
    /**
        The name of the surface property, identical to util.GetSurfacePropName.
    **/
    var name : String;
    /**
        This is the physical drag on an object when in contact with this surface (0 - x, 0 none to x a lot).
    **/
    var dampening : Float;
    /**
        Unused sound.
    **/
    var rollingSound : String;
    /**
        Material density in kg / m^3 (water is 1000). If a surface's density is < 1000, it will float in water. This is used to calculate the total mass of an object.
    **/
    var density : Float;
    /**
        Velocity threshold for impact sounds. impactSpeed >= HitSurface.hardVelocityThreshold - hard impact sound (depends on hardThreshold's value), impactSpeed < HitSurface.hardVelocityThreshold - soft impact sound (always).
    **/
    var hardVelocityThreshold : Float;
    /**
        Footstep sound for right foot.
    **/
    var stepRightSound : String;
    /**
        Roughness threshold for friction sounds. HitSurface.roughnessFactor >= InflictorSurface.roughThreshold - rough friction sound, HitSurface.roughnessFactor < InflictorSurface.roughThreshold - soft friction sound.
    **/
    var roughThreshold : Float;
    /**
        Scalar multiplier for player jump height - or more accurately, applied z-axis velocity on a surface. For example, 1 - normal jump, 2 - twice as high, and 0.5 - half as high.
    **/
    var jumpFactor : Float;
    /**
        The surface material. See MAT_ Enums.
    **/
    var material : MAT;
    /**
        Friction sound when roughly scraping against an entity.
    **/
    var scrapeRoughSound : String;
    /**
        Bullet impact sound with this surface.
    **/
    var bulletImpactSound : String;
    /**
        Sound to play when a prop or func_breakable is broken.
    **/
    var breakSound : String;
    /**
        Physical impact sound when hitting surfaces hard.
    **/
    var impactHardSound : String;
    /**
        Unused sound.
    **/
    var strainSound : String;
    /**
        Indicates whether or not the surface is a ladder. Used to detect whether a player is on a ladder. 0 - false, > 0 - true.
    **/
    var climbable : Float;
    /**
        Footstep sound for left foot.
    **/
    var stepLeftSound : String;
    /**
        Collision elasticity - used to compute coefficient of restitution represented as a number 0.0 - 1.0. 0.01 is soft, 1.0 is hard.
    **/
    var elasticity : Float;
    /**
        Material thickness. If this is 0, the material is not volumetrically solid, and thus the object mass will be calculated as "volume * 0.0254^3 * density" where 0.0254 is meters per inch. If non-zero, the mass will be "surfacearea * thickness * 0.0254^3 * density".
    **/
    var thickness : Float;
    /**
        Friction sound when smoothly scraping against an entity.
    **/
    var scrapeSmoothSound : String;
    /**
        How hard a surface is. If this is greater than or equal to another surfaces's hardThreshold, a hard impact sound will be used.
    **/
    var hardnessFactor : Float;
    /**
        Scalar multiplier for player speed. Achieves this by multiplying CMoveData:SetMaxSpeed in GM:Move.
    **/
    var maxSpeedFactor : Float;
    /**
        Physical impact sound when hitting surfaces softly.
    **/
    var impactSoftSound : String;
    /**
        Amount of sound reflected from the surface represented as a number 0.0 - 1.0. 0 - no reflection, 1 - fully reflected.
    **/
    var reflectivity : Float;
    /**
        Physical friction used to slow entities touching the surface represented as a number 0.0 - 1.0. 0.01 is slick, 1.0 is completely rough.
    **/
    var friction : Float;
    /**
        How rough a surface is. If this is greater than or equal to another surfaces's roughThreshold, a rough scrape sound will be used.
    **/
    var roughnessFactor : Float;
    
}
