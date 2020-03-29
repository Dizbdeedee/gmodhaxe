package gmod.gclass;
#if client

/**
    This is returned from video.Record.
**/
extern class IVideoWriter {
    
    /**
        Returns the width of the video stream.
		
		`**Returns:** width
    **/
    
    public function Width():Float;
    
    
    /**
        Returns the height of the video stream.
		
		`**Returns:** height
    **/
    
    public function Height():Float;
    
    
    /**
        Adds the current framebuffer to the video stream.
		
		Name | Description
		--- | ---
		`frameTime` | Usually set to what FrameTime is, or simply 1/fps.
		`downsample` | If true it will downsample the whole screenspace to the videos width and height, otherwise it will just record from the top left corner to the given width and height and therefor not the whole screen.
		
		
		___
		### Lua Examples
		#### Example 1
		If ActiveVideo was a IVideoWriter, it would record the screen every frame.
		
		```lua 
		--Taken from /lua/menu/video.lua
		
		hook.Add( "DrawOverlay", "CaptureFrames", function()
		
		    if ( !ActiveVideo ) then return end
		    
		    ActiveVideo:AddFrame( FrameTime(), true );
		
		end )
		```
    **/
    
    public function AddFrame(frameTime:Float, downsample:Bool):Void;
    
    
    /**
        Sets whether to record sound or not.
		
		Name | Description
		--- | ---
		`record` | Record.
    **/
    
    public function SetRecordSound(record:Bool):Void;
    
    
    /**
        Ends the video recording and dumps it to disk.
    **/
    
    public function Finish():Void;
    
    
}



#end