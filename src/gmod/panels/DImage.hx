package gmod.panels;
#if client

/**
    DImage is an advanced, more robust version of the Material panel. 
	
	See DImageButton for a click-able version of this panel.
**/
extern class DImage extends DPanel {
    /**
        ***INTERNAL** 
		
		Sets the backup material to be loaded when the image is first rendered. Used by DImage:SetOnViewMaterial.
		
		Name | Description
		--- | ---
		`backupMat` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetFailsafeMatName(backupMat:String):Void;
    /**
        Paints a ghost copy of the DImage panel at the given position and dimensions. This function overrides Panel:PaintAt.
		
		Name | Description
		--- | ---
		`posX` | The x coordinate to draw the panel from.
		`posY` | The y coordinate to draw the panel from.
		`width` | The width of the panel image to be drawn.
		`height` | The height of the panel image to be drawn.
    **/
    
     
    function PaintAt(posX:Float, posY:Float, width:Float, height:Float):Void;
    /**
        Returns whether the DImage should keep the aspect ratio of its image when being resized. 
		
		See DImage:SetKeepAspect for more info on how it works.
		
		`**Returns:** Whether the DImage should keep the aspect ratio of its image when being resized.
    **/
    
     
    function GetKeepAspect():Bool;
    /**
        Resizes the panel so that its width and height fit all of the content inside.
		
		**Warning:** You must call this function AFTER setting text/font, adjusting child panels or otherwise altering the panel.
		
		**Note:** Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented the Panel:SizeToContents method, such as DNumberWang and DImage.
    **/
    
     
    function SizeToContents():Void;
    /**
        Similar to DImage:SetImage, but will only do the expensive part of actually loading the textures/material if the material is about to be rendered/viewed. 
		
		Useful for cases like DIconBrowser, where there are hundreds of small icons in 1 panel in a list that do not need all to be loaded at the same time.
		
		Name | Description
		--- | ---
		`mat` | 
		`backupMat` | 
    **/
    
     
    function SetOnViewMaterial(mat:String, backupMat:String):Void;
    /**
        Sets a Material directly as an image.
		
		Name | Description
		--- | ---
		`mat` | The material to set
    **/
    
     
    function SetMaterial(mat:IMaterial):Void;
    /**
        ***INTERNAL** 
		
		Returns the texture path set by DImage:SetMatName.
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetMatName():String;
    /**
        Returns true if the image is not yet loaded.
		
		`**Returns:** 
    **/
    
     
    function Unloaded():Bool;
    /**
        Returns the current Material of the DImage.
		
		`**Returns:** 
    **/
    
     
    function GetMaterial():IMaterial;
    /**
        ***INTERNAL** 
		
		Actually loads the IMaterial to render it. Called from DImage:LoadMaterial.
    **/
    @:deprecated("INTERNAL")
     
    function DoLoadMaterial():Void;
    /**
        Sets the image's color override.
		
		Name | Description
		--- | ---
		`col` | The color override of the image. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a frame with a Portal box inside and sets the color to green.
		
		```lua 
		-- Frame
		MainFrame = vgui.Create("DFrame")
		MainFrame:SetSize(200, 180)
		MainFrame:Center()
		MainFrame:SetTitle("Color example")
		
		-- Image of a Portal box
		local metalbox_img = vgui.Create("DImage", MainFrame)
		metalbox_img:SetPos(35, 35)
		metalbox_img:SetSize(128, 128)
		metalbox_img:SetImage("spawnicons/models/props/metal_box_128.png")
		
		metalbox_img:SetImageColor(Color(128, 255, 0, 255))
		```
    **/
    
     
    function SetImageColor(col:Color):Void;
    /**
        ***INTERNAL** 
		
		Returns the texture path set by DImage:SetFailsafeMatName.
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetFailsafeMatName():String;
    /**
        Sets whether the DImage should keep the aspect ratio of its image when being resized. 
		
		Note that this will not try to fit the image inside the button, but instead it will fill the button with the image.
		
		Name | Description
		--- | ---
		`keep` | true to keep the aspect ratio, false not to
    **/
    
     
    function SetKeepAspect(keep:Bool):Void;
    /**
        Returns the color override of the image panel.
		
		`**Returns:** The color override of the image. Uses the Color structure.
		
		___
		### Lua Examples
		#### Example 1
		Creates an image panel and prints the default color override to console.
		
		```lua 
		-- Generic image panel
		local img = vgui.Create("DImage")
		img:SetSize(128, 128)
		img:Center()
		img:SetImage("cantop")
		
		print(img:GetImageColor())
		```
		**Output:**
		
		255 255 255 255
    **/
    
     
    function GetImageColor():Color;
    /**
        ***INTERNAL** 
		
		Initializes the loading process of the material to render if it is not loaded yet. 
		
		You do not need to call this function. It is done for you automatically.
    **/
    @:deprecated("INTERNAL")
     
    function LoadMaterial():Void;
    /**
        Returns the image loaded in the image panel.
		
		`**Returns:** The path to the image that is loaded.
		
		___
		### Lua Examples
		#### Example 1
		Creates a frame with a randomly chosen post process effect thumbnail and prints the image path to console.
		
		```lua 
		-- Frame
		MainFrame = vgui.Create("DFrame")
		MainFrame:SetSize(200, 200)
		MainFrame:Center()
		MainFrame:SetTitle("Post process effect")
		
		-- Load post process effect thumbnail
		local postprocess = vgui.Create("DImage", MainFrame)
		postprocess:SetSize(128, 128)
		postprocess:Center()
		
		local materials = file.Find("materials/gui/postprocess--.png", "GAME")
		
		postprocess:SetImage("materials/gui/postprocess/"..materials[math.random(1, #materials)])
		
		print(postprocess:GetImage())
		```
		**Output:**
		
		materials/gui/postprocess/colourmod.png
    **/
    
     
    function GetImage():String;
    /**
        ***INTERNAL** 
		
		"Fixes" the current material of the DImage if it has VertexLit shader by creating a new one with the same name and a prefix of "_DImage" and automatically calling DImage:SetMaterial with the new material. 
		
		This fixes the problem where using materials using shaders that expect lighting information causing "weird" flickering when displayed in 2D/Unlit environment.
    **/
    @:deprecated("INTERNAL")
     
    function FixVertexLitMaterial():Void;
    /**
        ***INTERNAL** 
		
		Sets the material to be loaded when the image is first rendered. Used by DImage:SetOnViewMaterial.
		
		Name | Description
		--- | ---
		`mat` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetMatName(mat:String):Void;
    /**
        Sets the image to load into the frame. If the first image can't be loaded and strBackup is set, that image will be loaded instead. 
		
		This eventually calls DImage:SetMaterial.
		
		Name | Description
		--- | ---
		`strImage` | The path of the image to load. When no file extension is supplied the VMT file extension is used.
		`strBackup` | The path of the backup image.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a frame with a map of de_inferno inside, with the default avatar image loaded as a backup.
		
		```lua 
		-- Frame
		MainFrame = vgui.Create( "DFrame" )
		MainFrame:SetSize( 300, 300 )
		MainFrame:Center()
		MainFrame:SetTitle( "Map of de_inferno" )
		
		-- Map of de_inferno (requires CS:S)
		local css_map = vgui.Create( "DImage", MainFrame )
		css_map:SetPos( 25, 40 )
		css_map:SetSize( 250, 250 )
		
		-- Set image to de_inferno map
		-- If it can't be loaded, load the [?] avatar image instead
		css_map:SetImage("overviews/de_inferno", "vgui/avatar_default")
		```
		**Output:**
		
		If CS:S is mounted then the left image is shown, otherwise the right image is shown.
    **/
    
     
    function SetImage(strImage:String, ?strBackup:String):Void;
    
}



#end