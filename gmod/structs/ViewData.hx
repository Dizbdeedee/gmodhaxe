package gmod.structs;
/**
    Table structure used for [render](https://wiki.garrysmod.com/page/Category:render). [RenderView](https://wiki.garrysmod.com/page/render/RenderView). Unless stated otherwise, the default values for all these keys would be inherited from the engine's CViewSetup and do not have static representations.
**/
typedef ViewData = {
    /**
        The main view's FOV
    **/
    var fov : Float;
    /**
        This allows you to "zoom in" on a part of the screen - for example, the top-left quarter of the screen. This is similar to how poster splits the screen into separate renders. 
		
		It's a table with 4 keys, controlling what portion of the screen to draw:
    **/
    var offcenter : AnyTable;
    /**
        The distance of the view's origin to the far clipping plane for the viewmodel
    **/
    var zfarviewmodel : Float;
    /**
        Coordinate for the bottom clipping plane
    **/
    var orthobottom : Float;
    /**
        Render the view orthogonal. Can also be a table with these keys: ( In which case orthogonal view is automatically set to true )
    **/
    var ?ortho : Bool;
    /**
        Coordinate for the left clipping plane
    **/
    var ortholeft : Float;
    /**
        Default width divided by height
    **/
    var aspectratio : Float;
    /**
        The viewmodel's FOV
    **/
    var viewmodelfov : Float;
    /**
        Coordinate for the right clipping plane
    **/
    var orthoright : Float;
    /**
        The view's original position
    **/
    var origin : Vector;
    /**
        The height of the viewport to render in
    **/
    var h : Float;
    /**
        The weapon's viewmodel 
		
		Default: true
    **/
    var ?drawviewmodel : Bool;
    /**
        Currently works identically to the "bloomtone" option (it also overrides it if you set this to false). 
		
		Default: false
    **/
    var ?dopostprocess : Bool;
    /**
        The x position of the viewport to render in
    **/
    var x : Float;
    /**
        Disables default engine bloom and pauses the "brightness changes" on HDR maps. 
		
		Default: true
    **/
    var ?bloomtone : Bool;
    /**
        The y position of the viewport to render in
    **/
    var y : Float;
    /**
        The view's angles
    **/
    var angles : Angle;
    /**
        The distance of the view's origin to the far clipping plane
    **/
    var zfar : Float;
    /**
        The distance of the view's origin to the near clipping plane for the viewmodel
    **/
    var znearviewmodel : Float;
    /**
        Draw monitors 
		
		Default: false
    **/
    var ?drawmonitors : Bool;
    /**
        Draw the HUD and call the hud painting related hooks 
		
		Default: false
    **/
    var ?drawhud : Bool;
    /**
        Coordinate for the top clipping plane
    **/
    var orthotop : Float;
    /**
        The distance of the view's origin to the near clipping plane
    **/
    var znear : Float;
    /**
        The width of the viewport to render in
    **/
    var w : Float;
    
}
