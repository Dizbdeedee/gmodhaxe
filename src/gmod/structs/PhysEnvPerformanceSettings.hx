package gmod.structs;
/**
    Table used by [physenv](https://wiki.garrysmod.com/page/Category:physenv). [SetPerformanceSettings](https://wiki.garrysmod.com/page/physenv/SetPerformanceSettings).
**/
typedef PhysEnvPerformanceSettings = {
    /**
        Maximum speed of an object.
    **/
    var MaxVelocity : Float;
    /**
        Maximum amount of seconds to precalculate collisions with objects.
    **/
    var LookAheadTimeObjectsVsObject : Float;
    /**
        Maximum amount of seconds to precalculate collisions with world.
    **/
    var LookAheadTimeObjectsVsWorld : Float;
    /**
        Minimum mass of an object to be affected by friction.
    **/
    var MinFrictionMass : Float;
    /**
        Maximum collision checks per tick.
    **/
    var MaxCollisionChecksPerTimestep : Float;
    /**
        Maximum mass of an object to be affected by friction.
    **/
    var MaxFrictionMass : Float;
    /**
        Maximum rotation velocity.
    **/
    var MaxAngularVelocity : Float;
    /**
        Maximum collision per object per tick.
    **/
    var MaxCollisionsPerObjectPerTimestep : Float;
    
}
