package gmod.panels;
#if client

/**
    The DCheckBoxLabel is a DCheckBox with a DLabel next to it. It allows you to get a boolean value from the user (true/false - yes/no)
**/
extern class DCheckBoxLabel extends DPanel {
    /**
        ***Deprecated:** You really should be using DCheckBoxLabel: SetTextColor instread
		
		Sets the color of the DCheckBoxLabel's text to the bright text color defined in the skin.
		
		Name | Description
		--- | ---
		`bright` | true makes the text bright.
    **/
    @:deprecated("You really should be using DCheckBoxLabel: SetTextColor instread")
     
    function SetBright(bright:Bool):Void;
    /**
        Sets the indentation of the element on the X axis.
		
		Name | Description
		--- | ---
		`ident` | How much in pixels to move the content to the right
    **/
    
     
    function SetIndent(ident:Float):Void;
    /**
        Sets the checked state of the checkbox. Does not call DCheckBoxLabel:OnChange or Panel:ConVarChanged, unlike DCheckBoxLabel:SetValue.
		
		Name | Description
		--- | ---
		`checked` | Whether the box should be checked or not.
    **/
    
     
    function SetChecked(checked:Bool):Void;
    /**
        Gets the checked state of the checkbox. This calls the checkbox's DCheckBox:GetChecked function.
		
		`**Returns:** Whether the box is checked or not.
    **/
    
     
    function GetChecked():Bool;
    /**
        Sets the checked state of the checkbox, and calls DCheckBoxLabel:OnChange and the checkbox's Panel:ConVarChanged methods.
		
		Name | Description
		--- | ---
		`checked` | Whether the box should be checked or not (1 or 0 can also be used).
    **/
    
     
    function SetValue(checked:Bool):Void;
    /**
        Gets the indentation of the element on the X axis.
		
		`**Returns:** How much the content is moved to the right in pixels
    **/
    
     
    function GetIndent():Float;
    /**
        Sets the text color for the DCheckBoxLabel.
		
		Name | Description
		--- | ---
		`color` | The text color. Uses the Color structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a DCheckBoxLabel and changes the text color to red.
		
		```lua 
		local LabelBox = vgui.Create( "DCheckBoxLabel" )
		LabelBox:SetTextColor( Color(255,0,0) )
		```
    **/
    
     
    function SetTextColor(color:Color):Void;
    /**
        ***Deprecated:** You really should be using DCheckBoxLabel: SetTextColor instread
		
		Sets the text of the DCheckBoxLabel to be dark colored.
		
		Name | Description
		--- | ---
		`darkify` | True to be dark, false to be default
    **/
    @:deprecated("You really should be using DCheckBoxLabel: SetTextColor instread")
     
    function SetDark(darkify:Bool):Void;
    /**
        Sets the font of the text part of the DCheckBoxLabel.
		
		Name | Description
		--- | ---
		`font` | Font name
    **/
    
     
    function SetFont(font:String):Void;
    /**
        Called when the "checked" state is changed.
		
		Name | Description
		--- | ---
		`bVal` | Whether the checkbox is checked or unchecked.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a a DCheckBoxLabel that prints to the console when ticked/unticked
		
		```lua 
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 300, 100 )
		Frame:SetPos( 200, 200 )
		
		local LabelBox = vgui.Create( "DCheckBoxLabel", Frame )
		LabelBox:SetPos( 10, 40 )
		LabelBox:SetText( "This is a DLabel" )
		function LabelBox:OnChange( val )
		    if val then
		        print( "The box has been ticked!" )
		    else
		        print( "The box has been unticked!" )
		    end
		end
		```
		**Output:**
		
		The box has been ticked!
    **/
    
    @:hook 
    function OnChange(bVal:Bool):Void;
    /**
        Sets the console variable to be set when the checked state of the DCheckBoxLabel changes.
		
		Name | Description
		--- | ---
		`convar` | The name of the convar to set
    **/
    
     
    function SetConVar(convar:String):Void;
    /**
        Toggles the checked state of the DCheckBoxLabel.
    **/
    
     
    function Toggle():Void;
    
}



#end