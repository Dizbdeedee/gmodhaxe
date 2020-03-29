package gmod.enums;
/**
    Enumerations used by Entity:SetMoveCollide and Entity:GetMoveCollide.
**/
@:native("_G")
extern enum abstract MOVECOLLIDE(Int) {
    /**
        Entity slides along surfaces (no bounce) - applies friciton (adjusts velocity)
    **/
    var MOVECOLLIDE_FLY_SLIDE;
    /**
        Entity bounces, reflects, based on elasticity of surface and object - applies friction (adjust velocity)
    **/
    var MOVECOLLIDE_FLY_BOUNCE;
    /**
        [ENTITY](https://wiki.garrysmod.com/page/Category:ENTITY_Hooks):[Touch](https://wiki.garrysmod.com/page/ENTITY/Touch) will modify the velocity however it likes
    **/
    var MOVECOLLIDE_FLY_CUSTOM;
    /**
        Default behavior
    **/
    var MOVECOLLIDE_DEFAULT;
    /**
        Number of different movecollides
    **/
    var MOVECOLLIDE_COUNT;
    
}