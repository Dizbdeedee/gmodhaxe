package gmod.panels;
#if client

/**
    An image button. 
	
	This panel inherits all methods of DButton, such as DLabel:DoClick.
**/
extern class DImageButton extends DButton {
    /**
        Returns whether the image inside the button should be stretched to fit it or not 
		
		See DImageButton:SetStretchToFit
		
		`**Returns:** 
    **/
    
     
    function GetStretchToFit():Bool;
    /**
        Resizes the panel so that its width and height fit all of the content inside.
		
		**Warning:** You must call this function AFTER setting text/font, adjusting child panels or otherwise altering the panel.
		
		**Note:** Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented the Panel:SizeToContents method, such as DNumberWang and DImage.
    **/
    
     
    function SizeToContents():Void;
    /**
        See DImage:SetOnViewMaterial
		
		Name | Description
		--- | ---
		`mat` | 
		`backup` | 
    **/
    
     
    function SetOnViewMaterial(mat:String, backup:String):Void;
    /**
        Sets a Material directly as an image. Equivalent of DImage:SetMaterial.
		
		Name | Description
		--- | ---
		`mat` | The material to set
    **/
    
     
    function SetMaterial(mat:IMaterial):Void;
    /**
        ***Deprecated:** 
		
		Alias of DImageButton:SetImage.
    **/
    @:deprecated("")
     
    function SetIcon():Void;
    /**
        Hides or shows the image of the image button. Internally this calls Panel:SetVisible on the internal DImage.
		
		Name | Description
		--- | ---
		`visible` | Set true to make it visible ( default ), or false to hide the image
    **/
    
     
    function SetImageVisible(visible:Bool):Void;
    /**
        Sets whether the DImageButton should keep the aspect ratio of its image. Equivalent of DImage:SetKeepAspect. 
		
		Note that this will not try to fit the image inside the button, but instead it will fill the button with the image.
		
		Name | Description
		--- | ---
		`keep` | true to keep the aspect ratio, false not to
    **/
    
     
    function SetKeepAspect(keep:Bool):Void;
    /**
        Returns the "image" of the DImageButton. Equivalent of DImage:GetImage.
		
		`**Returns:** The path to the image that is loaded.
    **/
    
     
    function GetImage():String;
    /**
        Sets whether the image inside the DImageButton should be stretched to fill the entire size of the button, without preserving aspect ratio. 
		
		If set to false, the image will not be resized at all.
		
		Name | Description
		--- | ---
		`stretch` | True to stretch, false to not to stretch
    **/
    
     
    function SetStretchToFit(stretch:Bool):Void;
    /**
        Sets the "image" of the DImageButton. Equivalent of DImage:SetImage.
		
		Name | Description
		--- | ---
		`strImage` | The path of the image to load. When no file extension is supplied the VMT file extension is used.
		`strBackup` | The path of the backup image.
    **/
    
     
    function SetImage(strImage:String, strBackup:String):Void;
    /**
        Sets the color of the image. Equivalent of DImage:SetImageColor
		
		Name | Description
		--- | ---
		`color` | The Color to set
		
		
		___
		### Lua Examples
		#### Example 1
		Changes the image to blue:
		
		```lua 
		-- E.g. for the Engineer (blue)
		local engineerClass = vgui.Create("DImageButton", container)
		engineerClass:SetColor(Color(22, 166, 236, 255))
		-- ...
		```
		**Output:**
		
		Without SetColor(...) With SetColor(...)
    **/
    
     
    function SetColor(color:AnyTable):Void;
    
}



#end