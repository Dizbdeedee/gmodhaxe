package gmod.libs;
#if client

/**
    The markup library only contains a single function to create a MarkupObject.
**/
@:native("_G.markup")extern class MarkupLib {
    
    /**
        Parses markup into a MarkupObject. Currently, this only supports fonts and colors as demonstrated in the example.
		
		Name | Description
		--- | ---
		`markup` | The markup to be parsed.
		`maxwidth` | The max width of the output
		
		
		`**Returns:** The parsed markup object ready to be drawn.
		
		___
		### Lua Examples
		#### Example 1
		Renders a markup string on the HUD.
		
		```lua 
		local parsed = markup.Parse("<font=Default>changed font</font>\n<colour=255,0,255,255>changed colour</colour>")
		
		hook.Add("HUDPaint", "MarkupTest", function()
		    parsed:Draw(100, 100, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		```
    **/
    
    public static function Parse(markup:String, maxwidth:Float):MarkupObject;
    
    

}



#end