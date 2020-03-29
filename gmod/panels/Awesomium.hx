package gmod.panels;
#if client

/**
    Base panel for elements using the Awesomium UI engine.
**/
extern class Awesomium extends Panel {
    /**
        Stops the loading of the HTML panel's current page.
    **/
    
     
    function StopLoading():Void;
    /**
        Refreshes the HTML panel's current page.
		
		Name | Description
		--- | ---
		`ignoreCache` | If true, the refresh will ignore cached content similar to "ctrl+f5" in most browsers.
    **/
    
     
    function Refresh(?ignoreCache:Bool):Void;
    /**
        Goes to the page in the HTML panel's history at the specified relative offset.
		
		Name | Description
		--- | ---
		`offset` | The offset in the panel's back/forward history, relative to the current page, that you would like to skip to. Because this is relative, 0 = current page while negative goes back and positive goes forward. For example, -2 will go back 2 pages in the history.
    **/
    
     
    function GoToHistoryOffset(offset:Float):Void;
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`objectName` | 
		`callbackName` | 
    **/
    @:deprecated("INTERNAL")
     
    function NewObjectCallback(objectName:String, callbackName:String):Void;
    /**
        Goes forward one page in the HTML panel's history if available.
    **/
    
     
    function GoForward():Void;
    /**
        Forcibly updates the panels' HTML Material, similar to when Paint is called on it. This is only useful if the panel is not normally visible, i.e the panel exists purely for its HTML Material.
		
		**Note:** Only works on with panels that have a HTML Material. See Panel:GetHTMLMaterial for more details.
		
		**Note:** A good place to call this is in the GM:PreRender hook
    **/
    
     
    function UpdateHTMLTexture():Void;
    /**
        Returns the panel's HTML material. Only works with Awesomium, HTML and DHTML panels that have been fully loaded.
		
		`**Returns:** The HTML material used by the panel. Typically starts with "__vgui_texture_" followed by an incremental number.
		
		___
		### Lua Examples
		#### Example 1
		Defines a new entity which can display a web page on a TV screen.
		
		```lua 
		AddCSLuaFile()
		
		ENT.Type = "anim"
		ENT.Base = "base_entity"
		
		ENT.PrintName = "Web Screen"
		ENT.Author = "Microflash"
		ENT.Spawnable = true
		
		if ( CLIENT ) then
		    ENT.Mat = nil
		    ENT.Panel = nil
		end
		
		function ENT:Initialize()
		
		    if ( SERVER ) then
		        
		        self:SetModel("models/props_phx/rt_screen.mdl")
		        self:SetMoveType(MOVETYPE_VPHYSICS)
		        self:SetSolid(SOLID_VPHYSICS)
		        
		        self:PhysicsInit(SOLID_VPHYSICS)
		        
		        self:Freeze()
		        
		    else
		    
		        -- Reset material and panel and load DHTML panel
		        self.Mat = nil
		        self.Panel = nil
		        self:OpenPage()
		        
		    end
		    
		end
		
		function ENT:Freeze()
		    local phys = self:GetPhysicsObject()
		    if (IsValid(phys)) then phys:EnableMotion(false) end
		end
		
		-- Load the DHTML reference panel
		function ENT:OpenPage()
		
		    -- Iff for some reason a panel is already loaded, delete it
		    if(self.Panel) then
		    
		        self.Panel:Remove()
		        self.Panel = nil
		    
		    end
		
		    -- Create a web page panel and fill the entire screen
		    self.Panel = vgui.Create("DHTML")
		    self.Panel:Dock(FILL)
		    
		    -- Wiki page URL
		    local url = "http://wiki.garrysmod.com/page/Category:Material"
		    
		    -- Load the wiki page
		    self.Panel:OpenURL(url)
		    
		    -- Hide the panel
		    self.Panel:SetAlpha(0)
		    self.Panel:SetMouseInputEnabled(false)
		    
		    -- Disable HTML messages
		    function self.Panel:ConsoleMessage(msg) end
		
		end
		
		function ENT:Draw()
		
		    -- Iff the material has already been grabbed from the panel
		    if(self.Mat) then
		        
		        -- Apply it to the screen/model
		        if(render.MaterialOverrideByIndex) then
		            render.MaterialOverrideByIndex(1, self.Mat)
		        else
		            render.ModelMaterialOverride(self.Mat)
		        end
		        
		    -- Otherwise, check that the panel is valid and the HTML material is finished loading
		    elseif(self.Panel && self.Panel:GetHTMLMaterial()) then
		
		        -- Get the html material
		        local html_mat = self.Panel:GetHTMLMaterial()
		        
		        -- Used to make the material fit the model screen
		        -- May need to be changed iff using a different model
		        -- For the multiplication number it goes in segments of 512
		        -- Based off the players screen resolution
		        local scale_x, scale_y = ScrW()/2048, ScrH()/1024
		        
		        -- Create a new material with the proper scaling and shader
		        local matdata =
		        {
		            ["$basetexture"]=html_mat:GetName(),
		            ["$basetexturetransform"]="center 0 0 scale "..scale_x.." "..scale_y.." rotate 0 translate 0 0",
		            ["$model"]=1
		        }
		        -- Unique ID used for material name
		        local uid = string.Replace(html_mat:GetName(), "__vgui_texture_", "")
		        
		        -- Create the model material
		        self.Mat = CreateMaterial("WebMaterial_"..uid, "VertexLitGeneric", matdata)
		    
		    end
		
		    -- Render the model
		    self:DrawModel()
		    
		    -- Reset the material override or else everything will have a HTML material!
		    render.ModelMaterialOverride(nil)
		
		end
		
		function ENT:OnRemove()
		    -- Make sure the panel is removed too
		    if(self.Panel) then self.Panel:Remove() end
		end
		```
    **/
    
     
    function GetHTMLMaterial():IMaterial;
    /**
        Goes back one page in the HTML panel's history if available.
    **/
    
     
    function GoBack():Void;
    /**
        Instructs a HTML control to download and parse a HTML script using the passed URL.     Displays the Garry's Mod wiki page.
		
		Name | Description
		--- | ---
		`URL` | URL to open
		
		
		___
		### Lua Examples
		#### Example 1
		Displays the Garry's Mod wiki page.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "HTML Example" )
		frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
		frame:Center()
		frame:MakePopup()
		
		local html = vgui.Create( "HTML", frame )
		html:Dock( FILL )
		html:OpenURL( "wiki.garrysmod.com" )
		```
		
		#### Example 2
		Displays the default loading screen from the html folder.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "HTML Example" )
		frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
		frame:Center()
		frame:MakePopup()
		
		local html = vgui.Create( "HTML", frame )
		html:Dock( FILL )
		html:OpenURL( "asset://garrysmod/html/loading.html" )
		```
    **/
    
     
    function OpenURL(URL:String):Void;
    /**
        Allows you to set HTML code within a panel.
		
		Name | Description
		--- | ---
		`HTML code` | The code to set.
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local HTML = vgui.Create( "HTML", DPanel )
		HTML:SetHTML( "<p>Put HTML code here</p>" )
		HTML:SetSize( 390, 400 )
		```
    **/
    
     
    function SetHTML(code:String):Void;
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`objectName` | 
    **/
    @:deprecated("INTERNAL")
     
    function NewObject(objectName:String):Void;
    
}



#end