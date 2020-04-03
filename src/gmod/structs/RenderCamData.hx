package gmod.structs;
/**
    Used for [cam](https://wiki.garrysmod.com/page/Category:cam). [Start](https://wiki.garrysmod.com/page/cam/Start). Unless stated otherwise, the default values for all these keys would be inherited from the engine's current CViewSetup and do not have static representations.
**/
typedef RenderCamData = {
    /**
        The field of view
    **/
    var fov : Float;
    /**
        A table having these keys: ( all floats )
    **/
    var offcenter : AnyTable;
    /**
        Set to true if this is to draw into a subrect of the larger screen. 
		
		Default: false
    **/
    var ?subrect : Bool;
    /**
        If set, makes the view/camera orthogonal. A table having these keys: ( all floats )
    **/
    var ortho : AnyTable;
    /**
        The position to render from
    **/
    var origin : Vector;
    /**
        The height of the view port
    **/
    var h : Float;
    /**
        The x position of the view port
    **/
    var x : Float;
    /**
        m_bDoBloomAndToneMapping 
		
		Default: false
    **/
    var ?bloomtone : Bool;
    /**
        The y position of the view port
    **/
    var y : Float;
    /**
        The angles to render from
    **/
    var angles : Angle;
    /**
        The distance to the far clipping plane
    **/
    var zfar : Float;
    /**
        The type of cam. Valid types are:
    **/
    var ?type : String;
    /**
        The distance to the near clipping plane
    **/
    var znear : Float;
    /**
        The aspect ratio of the view port (Note that this is NOT set to w/h by default)
    **/
    var aspect : Float;
    /**
        The width of the view port
    **/
    var w : Float;
    
}
