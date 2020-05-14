package gmod.structs;
/**
    Used by [Entity](https://wiki.garrysmod.com/page/Category:Entity): [GetSequenceInfo](https://wiki.garrysmod.com/page/Entity/GetSequenceInfo).
**/
typedef SequenceInfo = {
    /**
        Maxs part of the bounding box for this sequence
    **/
    var bbmax : Float;
    /**
        transition node at exit
    **/
    var localexitnode : Float;
    /**
        If non 0, the next sequence for auto advancing sequences
    **/
    var nextseq : Float;
    /**
        transition node at entry
    **/
    var localentrynode : Float;
    /**
        How likely this sequence is to be picked when playing an activity its attached to. -1 means this is the only sequence for that activity. (needs validation)
    **/
    var actweight : Float;
    /**
        Name of the activity this sequence is attached to.
    **/
    var activityname : String;
    /**
        
    **/
    var numblends : Float;
    /**
        ideal cross fade out time (0.2 default)
    **/
    var fadeouttime : Float;
    /**
        Transition rules
    **/
    var nodeflags : Float;
    /**
        The looping and other flags of this sequence.
    **/
    var flags : Float;
    /**
        A 1-based array of all animationIDs associated with this sequence. For use with Entity:GetAnimInfo.
    **/
    var anims : AnyTable;
    /**
        If non 0, index of pose parameter to be used as cycle index. This means that the sequence playback will be controlled by a pose parameter.
    **/
    var cycleposeindex : Float;
    /**
        The activity ID associated with this sequence. See ACT_ Enums.
    **/
    var activity : ACT;
    /**
        Name of the sequence.
    **/
    var label : String;
    /**
        ideal cross fade in time (0.2 default)
    **/
    var fadeintime : Float;
    /**
        Frame that should generate EndOFSequence
    **/
    var lastframe : Float;
    /**
        Mins part of the bounding box for this sequence
    **/
    var bbmin : Float;
    /**
        Number of animation events this sequence has.
    **/
    var numevents : Float;
    /**
        
    **/
    var pose : Float;
    
}
