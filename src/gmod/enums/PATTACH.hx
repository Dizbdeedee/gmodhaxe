package gmod.enums;
/**
    Enumerations used by ParticleEffectAttach.
**/
@:native("_G")
extern enum abstract PATTACH(Int) {
    /**
        Particle spawns in the beginning of coordinates ( Vector( 0, 0, 0 ) ), used for control points that don't attach to an entity
    **/
    var PATTACH_WORLDORIGIN;
    /**
        Particle attaches to passed to [ParticleEffectAttach](https://wiki.garrysmod.com/page/Global/ParticleEffectAttach) attachment id, but does not follow the entity
    **/
    var PATTACH_POINT;
    /**
        Create at a custom origin, but don't follow
    **/
    var PATTACH_CUSTOMORIGIN;
    /**
        Particle spawns in entity's origin and does not follow it
    **/
    var PATTACH_ABSORIGIN;
    /**
        Particle attaches to entity's origin and follows the entity
    **/
    var PATTACH_ABSORIGIN_FOLLOW;
    /**
        Particle attaches to passed to [ParticleEffectAttach](https://wiki.garrysmod.com/page/Global/ParticleEffectAttach) attachment id and follows the entity
    **/
    var PATTACH_POINT_FOLLOW;
    
}