package gmod.libs;
#if client

/**
    The video library.
**/
@:native("_G.video")extern class VideoLib {
    
    /**
        Attempts to create an IVideoWriter.
		
		Name | Description
		--- | ---
		`config` | The video config. See VideoData structure.
		
		
		Name | Description
		--- | ---
		`a` | The video object (returns false if there is an error)
		`b` | The error string, if there is an error
		
		
		___
		### Lua Examples
		#### Example 1
		How to create a basic IVideoWriter, and how to use it
		
		```lua 
		local config = {
		    container = "webm",
		    video = "vp8",
		    audio = "vorbis",
		    quality = 50,
		    bitrate = 200,
		    fps = 30,
		    lockfps = 30,
		    name = "Test",
		    width = 1280,
		    height = 720
		}
		local iVideoWriter = video.Record( config )
		iVideoWriter:SetRecordSound( true )
		
		local function Record()
		    iVideoWriter:AddFrame( FrameTime(), true )
		end
		
		function StartRecording()
		    hook.Add( "DrawOverlay", "Record", Record )
		end
		
		function StopRecording()
		    hook.Remove( "DrawOverlay", "Record" )
		    iVideoWriter:Finish()
		end
		```
    **/
    
    public static function Record(config:VideoData):VideoLibRecordReturn;
    
    

}


@:multiReturn extern class VideoLibRecordReturn {
var a:IVideoWriter;
var b:String;

}

#end