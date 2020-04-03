package gmod.structs;
/**
    Table used by panel animation methods, primarily [Panel](https://wiki.garrysmod.com/page/Category:Panel): [AnimationThinkInternal](https://wiki.garrysmod.com/page/Panel/AnimationThinkInternal), and returned by [Panel](https://wiki.garrysmod.com/page/Category:Panel): [NewAnimation](https://wiki.garrysmod.com/page/Panel/NewAnimation).
**/
typedef AnimationData = {
    /**
        The system time value returned by SysTime when the animation ends/will end.
    **/
    var EndTime : Float;
    /**
        The target colour of the panel object. Only used by Panel:ColorTo.
    **/
    var Color : AnyTable;
    /**
        Whether to resize the panel horizontally or not. Only used by Panel:SizeTo.
    **/
    var SizeX : Bool;
    /**
        The alpha (0-255) of the panel object when the animation started. Only used by Panel:AlphaTo.
    **/
    var StartAlpha : Float;
    /**
        The position of the panel object when the animation started. Used by Panel:MoveTo and Panel:MoveBy.
    **/
    var StartPos : Vector;
    /**
        The system time value returned by SysTime when the animation starts/will start.
    **/
    var StartTime : Float;
    /**
        The speed to use for transitions when using linear interpolation (Lerp) animations. Only used by Panel:LerpPositions.
    **/
    var Speed : Float;
    /**
        The target alpha (0-255) of the panel object. Only used by Panel:AlphaTo.
    **/
    var Alpha : Float;
    /**
        Whether or not to use easing to make the panel 'jump' at its target, slowing as it approaches. Only used by Panel:LerpPositions.
    **/
    var UseGravity : Bool;
    /**
        The think function called every frame that will animate the panel object. This varies based on the animation. You can create a custom function for this if you aren't using the stock panel methods. The arguments passed to it are:
    **/
    var Think : Function;
    /**
        The colour of the panel object when the animation started. Only used by Panel:ColorTo.
    **/
    var StartColor : AnyTable;
    /**
        The callback function that will be called upon completion of the animation. The arguments passed to it are:
    **/
    var OnEnd : Function;
    /**
        The target position, or target translation of the panel object. Used by Panel:MoveTo and Panel:MoveBy respectively.
    **/
    var Pos : Vector;
    /**
        The target size of the panel object. Only used by Panel:SizeTo. 
		
		Default: (0, 0, 0)
    **/
    var ?Size : Vector;
    /**
        The ease in/out level of the animation. 
		
		Default: -1
    **/
    var ?Ease : Float;
    /**
        Whether to resize the panel vertically or not. Only used by Panel:SizeTo.
    **/
    var SizeY : Bool;
    /**
        The size of the panel object when the animation started. Only used by Panel:SizeTo.
    **/
    var StartSize : Vector;
    
}
