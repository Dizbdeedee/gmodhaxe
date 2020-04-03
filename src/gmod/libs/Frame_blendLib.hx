package gmod.libs;
#if client

/**
    The frame blending library.
**/
@:native("_G.frame_blend")extern class Frame_blendLib {
    
    /**
        ***INTERNAL** 
		
		Returns amount of frames needed to render?
		
		`**Returns:** Amount of frames needed to render?
    **/
    @:deprecated("INTERNAL")
    static function RenderableFrames():Float;
    
    
    /**
        ***INTERNAL** 
		
		Renders the frame onto internal render target.
    **/
    @:deprecated("INTERNAL")
    static function CompleteFrame():Void;
    
    
    /**
        ***INTERNAL** 
		
		Actually draws the frame blend effect.
    **/
    @:deprecated("INTERNAL")
    static function DrawPreview():Void;
    
    
    /**
        ***INTERNAL** 
		
		Adds a frame to the blend. Calls frame_blend.CompleteFrame once enough frames have passed since last frame_blend.CompleteFrame call.
    **/
    @:deprecated("INTERNAL")
    static function AddFrame():Void;
    
    
    /**
        Returns whether we should skip frame or not
		
		`**Returns:** Should the frame be skipped or not
    **/
    
    static function ShouldSkipFrame():Bool;
    
    
    /**
        ***INTERNAL** 
		
		Blends the frame(s).
    **/
    @:deprecated("INTERNAL")
    static function BlendFrame():Void;
    
    
    /**
        Returns whether frame blend post processing effect is enabled or not.
		
		`**Returns:** Is frame blend enabled or not
    **/
    
    static function IsActive():Bool;
    
    
    /**
        ***INTERNAL** 
		
		Returns whether the current frame is the last frame?
		
		`**Returns:** Whether the current frame is the last frame?
    **/
    @:deprecated("INTERNAL")
    static function IsLastFrame():Bool;
    
    

}



#end