package gmod.structs;
/**
    Used for [surface](https://wiki.garrysmod.com/page/Category:surface). [CreateFont](https://wiki.garrysmod.com/page/surface/CreateFont).
**/
typedef FontData = {
    /**
        Add shadow casting to the font 
		
		Default: false
    **/
    var ?shadow : Bool;
    /**
        The strength of the font blurring 
		
		Range: 0 - 80 
		
		Default: 0
    **/
    var ?blursize : Float;
    /**
        Additive rendering 
		
		Default: false
    **/
    var ?additive : Bool;
    /**
        The "scanline" interval Must be > 1 to work. This setting is per blursize per font - so if you create a font using "Arial" without scanlines, you cannot create an Arial font using scanlines with the same blursize 
		
		Default: 0
    **/
    var ?scanlines : Float;
    /**
        Allow the font to display glyphs that are outside of the Latin-1 range. Unicode code points above 0xFFFF are not supported. 
		
		Default: false
    **/
    var ?extended : Bool;
    /**
        The font height in pixels 
		
		Range: 4 - 255 
		
		Default: 13
    **/
    var ?size : Float;
    /**
        Seems to add a line in the middle of each letter 
		
		Default: false
    **/
    var ?rotary : Bool;
    /**
        Add a strike through 
		
		Default: false
    **/
    var ?strikeout : Bool;
    /**
        Smooth the font 
		
		Default: true
    **/
    var ?antialias : Bool;
    /**
        The font source. This must be the actual name of the font, not a file name. Font files are stored in resource/fonts/. This cannot be an existing game font, i.e. "ChatText", "Trebuchet18", etc. (Default Fonts) 
		
		The length is limited to 31 characters maximum. 
		
		Default: "Arial"
    **/
    var ?font : String;
    /**
        Enables the use of symbolic fonts such as Webdings 
		
		Default: false
    **/
    var ?symbol : Bool;
    /**
        Add a black outline to the font. 
		
		This does not work well with antialias, and only allows black 1-pixel outlines. It may be preferable to not use this parameter, and instead use draw.SimpleTextOutlined when drawing text that you want outlined. 
		
		Default: false
    **/
    var ?outline : Bool;
    /**
        Add an underline to the font 
		
		Default: false
    **/
    var ?underline : Bool;
    /**
        The font boldness 
		
		Default: 500
    **/
    var ?weight : Float;
    /**
        Make the font italic 
		
		Default: false
    **/
    var ?italic : Bool;
    
}
