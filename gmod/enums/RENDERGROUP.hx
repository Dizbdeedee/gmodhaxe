package gmod.enums;
/**
    Enumerations used by ClientsideModel, ENT.RenderGroup in ENT structure and Entity:GetRenderGroup.
**/
@:native("_G")
extern enum abstract RENDERGROUP(Int) {
    /**
        Transparent overlays etc
    **/
    var RENDERGROUP_VIEWMODEL_TRANSLUCENT;
    /**
        Huge static prop, possibly leftover from goldsrc
    **/
    var RENDERGROUP_STATIC_HUGE;
    /**
        Static props?
    **/
    var RENDERGROUP_STATIC;
    /**
        Solid weapon view models
    **/
    var RENDERGROUP_VIEWMODEL;
    /**
        For brush entities
    **/
    var RENDERGROUP_OPAQUE_BRUSH;
    /**
        For non transparent/solid entities. For scripted entities, this will have ENTITY:Draw called
    **/
    var RENDERGROUP_OPAQUE;
    /**
        Huge opaque entity, possibly leftover from goldsrc
    **/
    var RENDERGROUP_OPAQUE_HUGE;
    /**
        Unclassfied. Won't get drawn.
    **/
    var RENDERGROUP_OTHER;
    /**
        For both translucent/transparent and opaque/solid anim entities For scripted entities, this will have both, ENTITY:Draw and ENTITY:DrawTranslucent called
    **/
    var RENDERGROUP_BOTH;
    /**
        For translucent/transparent entities For scripted entities, this will have ENTITY:DrawTranslucent called
    **/
    var RENDERGROUP_TRANSLUCENT;
    
}