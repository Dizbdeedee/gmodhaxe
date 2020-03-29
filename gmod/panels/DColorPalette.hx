package gmod.panels;
#if client

/**
    The DColorPalette allows the player to select a color from a list of given colors. 
	
	This panel supports saving across sessions via the panel cookie system. Use Panel:SetCookieName to change "save files".
**/
extern class DColorPalette extends DIconLayout {
    /**
        Returns the ConVar name for the green channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the green channel of the color
    **/
    
     
    function GetConVarG():String;
    /**
        Called when the color is changed after clicking a new value.
		
		Name | Description
		--- | ---
		`newcol` | The new color of the DColorPalette
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DFrame with a color palette that prints values after being changed.
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( ScrW() - 100, ScrH() - 100 )
		frame:Center()
		frame:MakePopup()
		
		local palette = vgui.Create( "DColorPalette", frame )
		palette:Dock( FILL )
		
		function palette:OnValueChanged( newcol )
		    PrintTable( newcol )
		end
		```
		**Output:**
		
		The color chosen on the palette.
    **/
    
    @:hook 
    function OnValueChanged(newcol:AnyTable):Void;
    /**
        Saves the color of given button across sessions. 
		
		The color is saved as a panel cookie, see Panel:SetCookie and Panel:SetCookieName. 
		
		 It is expected that the amount of colors per palette (Panel:SetCookieName) is the same every time.
		
		Name | Description
		--- | ---
		`btn` | The button to save the color of. Used to get the ID of the button.
		`clr` | The color to save to this button's index
    **/
    
     
    function SaveColor(btn:Panel, clr:AnyTable):Void;
    /**
        Sets the ConVar name for the green channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the green channel of the color
    **/
    
     
    function SetConVarG(convar:String):Void;
    /**
        Called when a palette button has been pressed
		
		Name | Description
		--- | ---
		`pnl` | The DColorButton that was pressed.
    **/
    
    @:hook 
    function OnRightClickButton(pnl:Panel):Void;
    /**
        Returns the ConVar name for the alpha channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the alpha channel of the color
    **/
    
     
    function GetConVarA():String;
    /**
        Returns the size of each palette button. Set by DColorPalette:SetButtonSize.
		
		`**Returns:** The size of each palette button
    **/
    
     
    function GetButtonSize():Float;
    /**
        Roughly sets the number of colors that can be picked by the user. If the DColorPalette is exactly 6 rows tall, this function will set the number of colors shown per row in the palette.
		
		**Note:** DColorPalette:Reset or DColorPalette:ResetSavedColors must be called after this function to apply changes.
		
		Name | Description
		--- | ---
		`rows` | Scale for the range of colors that the user can pick. Default is 8.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates four DColorPalettes, each with a varying number of colors per row.
		
		```lua 
		local frame = vgui.Create( "DFrame" ) -- Create the window
		frame:SetSize( 350, 350 )
		frame:SetTitle( "SetNumRows Demonstration" )
		frame:Center()
		frame:MakePopup()
		
		local label = vgui.Create( "DLabel", frame ) -- Create the help text
		label:Dock( TOP )
		label:SetText( "Difference between SetNumRows( 4 ), SetNumRows( 8 ), SetNumRows( 16 ) and SetNumRows( 24 )" )
		label:SetWrap( true ) -- Enables text wrapping for lower resolutions
		label:SetAutoStretchVertical( true ) -- Needed for the text to show properly
		
		local pallette1 = vgui.Create( "DColorPalette", frame ) -- First DColorPalette with 4 colors per row
		pallette1:SetPos( 4, 60 )
		pallette1:SetNumRows( 4 )
		pallette1:SetSize( 40, 60 )
		pallette1:Reset()
		
		local pallette2 = vgui.Create( "DColorPalette", frame ) -- Second DColorPalette with 8 colors per row
		pallette2:SetPos( 4, 130 )
		pallette2:SetNumRows( 8 )
		pallette2:SetSize( 80, 60 )
		pallette2:Reset()
		
		local pallette3 = vgui.Create( "DColorPalette", frame ) -- Third DColorPalette with 16 colors per row
		pallette3:SetPos( 4, 200 )
		pallette3:SetNumRows( 16 )
		pallette3:SetSize( 160, 60 )
		pallette3:Reset()
		
		local pallette4 = vgui.Create( "DColorPalette", frame ) -- Fourth DColorPalette with 24 colors per row
		pallette4:SetPos( 4, 270 )
		pallette4:SetNumRows( 24 )
		pallette4:SetSize( 240, 60 )
		pallette4:Reset()
		```
    **/
    
     
    function SetNumRows(rows:Float):Void;
    /**
        Sets the size of each palette button. 
		
		This is best kept to such a number, where this equation would return a whole number: WidthOfColorPalette/ButtonSize=WholeNumber 
		
		 If not, there will be ugly whitespace on the right side of the panel.
		
		Name | Description
		--- | ---
		`size` | Sets the new size
    **/
    
     
    function SetButtonSize(size:Float):Void;
    /**
        ***Deprecated:** 
		
		Basically the same functionality as DColorPalette:OnValueChanged, you should use that instead!
		
		Name | Description
		--- | ---
		`clr` | The new color via the Color structure
		`btn` | The DColorButton that was pressed.
    **/
    @:deprecated("")
     
    function DoClick(clr:Color, btn:Panel):Void;
    /**
        Resets this entire color palette to a default preset one, without saving. 
		
		See DColorPalette:ResetSavedColors for version that also saves the changes.
    **/
    
     
    function Reset():Void;
    /**
        Sets the ConVar name for the blue channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the blue channel of the color
    **/
    
     
    function SetConVarB(convar:String):Void;
    /**
        Returns the number of rows of the palette, provided 6 colors fill each row. This value is equal to the number of colors in the DColorPalette divided by 6.
		
		`**Returns:** Number of rows of the DColorPalette.
    **/
    
     
    function GetNumRows():Float;
    /**
        ***INTERNAL** 
		
		Internal helper function for DColorPalette:UpdateConVars.
		
		Name | Description
		--- | ---
		`name` | The name of the console variable to set
		`key` | The key of the 3rd argument to set the convar to Possible values: "r", "g", "b", "a"
		`clr` | The Color structure to retrieve the info from.
    **/
    @:deprecated("INTERNAL")
     
    function UpdateConVar(name:String, key:String, clr:Color):Void;
    /**
        ***INTERNAL** 
		
		Updates all the console variables set by DColorPalette:SetConVarR and so on with given color. 
		
		Called internally when a palette color is clicked.
		
		Name | Description
		--- | ---
		`clr` | A Color structure
    **/
    @:deprecated("INTERNAL")
     
    function UpdateConVars(clr:Color):Void;
    /**
        Resets this entire color palette to a default preset one and saves the changes. 
		
		See DColorPalette:Reset for version that does not save the changes.
    **/
    
     
    function ResetSavedColors():Void;
    /**
        Returns the ConVar name for the blue channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the blue channel of the color
    **/
    
     
    function GetConVarB():String;
    /**
        Sets the ConVar name for the alpha channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the alpha channel of the color
    **/
    
     
    function SetConVarA(convar:String):Void;
    /**
        Returns the ConVar name for the red channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the red channel of the color
    **/
    
     
    function GetConVarR():String;
    /**
        ***INTERNAL** 
		
		Used internally to make sure changes on one palette affect other palettes with same name.
    **/
    @:deprecated("INTERNAL")
     
    function NetworkColorChange():Void;
    /**
        Sets the ConVar name for the red channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the red channel of the color
    **/
    
     
    function SetConVarR(convar:String):Void;
    /**
        ***Deprecated:** 
		
		Currently does nothing. Intended to "select" the color.
		
		Name | Description
		--- | ---
		`clr` | 
    **/
    @:deprecated("")
     
    function SetColor(clr:AnyTable):Void;
    /**
        Clears the palette and adds new buttons with given colors.
		
		Name | Description
		--- | ---
		`tab` | A number indexed table where each value is a Color structure
    **/
    
     
    function SetColorButtons(tab:Color):Void;
    
}



#end