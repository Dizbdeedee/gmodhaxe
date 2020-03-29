package gmod.panels;
#if client

/**
    The DNumSlider allows you to create a slider, allowing the user to slide it to set a value, or changing the value in the box.
**/
extern class DNumSlider extends Panel {
    /**
        Sets the minimum value for the slider
		
		Name | Description
		--- | ---
		`min` | The value to set as minimum for the slider.
		
		
		___
		### Lua Examples
		#### Example 1
		An example usage of the function
		
		```lua 
		--This creates the frame.
		local Frame = vgui.Create( "DFrame" )
		Frame :Center() -- or Frame:SetPos( x, y )
		Frame:SetSize( 300, 150 )
		Frame:SetTitle( "Test" )
		Frame:SetVisible( true )
		Frame:SetDraggable( true )
		Frame:ShowCloseButton( true )
		Frame:MakePopup()
		--Here we create the slider.
		local DermaSlider = vgui.Create( "DNumSlider", Frame )
		DermaSlider:SetPos( 25, 85 )
		DermaSlider:SetWide( 275 )
		DermaSlider:SetMin( 0 ) -- Or 3 for second image
		DermaSlider:SetMax( 5 )
		DermaSlider:SetValue( 0.5 )
		DermaSlider:SetDecimals( 2 )
		```
    **/
    
     
    function SetMin(min:Float):Void;
    /**
        Called when the value of the slider is changed, through code or changing the slider.
		
		Name | Description
		--- | ---
		`value` | The new value of the DNumSlider
    **/
    
    @:hook 
    function OnValueChanged(value:Float):Void;
    /**
        Resets the slider to the default value, if one was set by DNumSlider:SetDefaultValue. 
		
		This function is called by the DNumSlider when user middle mouse clicks on the draggable knob of the slider.
    **/
    
     
    function ResetToDefaultValue():Void;
    /**
        Sets the maximum value for the slider.
		
		Name | Description
		--- | ---
		`max` | The value to set as maximum for the slider.
    **/
    
     
    function SetMax(max:Float):Void;
    /**
        Returns true if either the DTextEntry, the DSlider or the DNumberScratch are being edited.
		
		`**Returns:** Whether or not the DNumSlider is being edited by the player.
    **/
    
     
    function IsEditing():Bool;
    /**
        ***INTERNAL** 
		
		Called when the value has been changed. This will also be called when the user manually changes the value through the text panel. This is an internal function. Override DNumSlider:OnValueChanged instead.
		
		Name | Description
		--- | ---
		`value` | The value the slider has been changed to.
    **/
    @:deprecated("INTERNAL")
     
    function ValueChanged(value:Float):Void;
    /**
        Returns the default value of the slider, if one was set by DNumSlider:SetDefaultValue
		
		`**Returns:** The default value of the slider
    **/
    
     
    function GetDefaultValue():Float;
    /**
        Returns the DTextEntry component of the slider.
		
		`**Returns:** The DTextEntry.
    **/
    
     
    function GetTextArea():Panel;
    /**
        Sets the value of the DNumSlider.
		
		Name | Description
		--- | ---
		`val` | The value to set.
    **/
    
     
    function SetValue(val:Float):Void;
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`x` | 
		`y` | 
		
		
		Name | Description
		--- | ---
		`a` | 
		`b` | The second passed argument.
    **/
    @:deprecated("INTERNAL")
     
    function TranslateSliderValues(x:Float, y:Float):DNumSliderTranslateSliderValuesReturn;
    /**
        Sets the minimum and the maximum value of the slider.
		
		Name | Description
		--- | ---
		`min` | The minimum value of the slider.
		`max` | The maximum value of the slider.
    **/
    
     
    function SetMinMax(min:Float, max:Float):Void;
    /**
        Returns the minimum value of the slider
		
		`**Returns:** The minimum value of the slider
    **/
    
     
    function GetMin():Float;
    /**
        Returns the range of the slider, basically maximum value - minimum value.
		
		`**Returns:** The range of the slider
    **/
    
     
    function GetRange():Float;
    /**
        Calls DLabel:SetDark on the DLabel part of the DNumSlider.
		
		Name | Description
		--- | ---
		`dark` | 
    **/
    
     
    function SetDark(dark:Bool):Void;
    /**
        Returns the maximum value of the slider
		
		`**Returns:** The maximum value of the slider
    **/
    
     
    function GetMax():Float;
    /**
        Returns the amount of numbers after the decimal point.
		
		`**Returns:** 0 for whole numbers only, 1 for one number after the decimal point, etc.
    **/
    
     
    function GetDecimals():Float;
    /**
        Sets the console variable to be updated when the value of the slider is changed.
		
		Name | Description
		--- | ---
		`cvar` | The name of the ConVar to be updated.
    **/
    
     
    function SetConVar(cvar:String):Void;
    /**
        Returns the value of the DNumSlider
		
		`**Returns:** The value of the slider.
    **/
    
     
    function GetValue():Float;
    /**
        Sets the desired amount of numbers after the decimal point.
		
		Name | Description
		--- | ---
		`decimals` | 0 for whole numbers only, 1 for one number after the decimal point, etc.
    **/
    
     
    function SetDecimals(decimals:Float):Void;
    /**
        ***INTERNAL** 
    **/
    @:deprecated("INTERNAL")
     
    function UpdateNotches():Void;
    /**
        Sets the default value of the slider, to be used by DNumSlider:ResetToDefaultValue or by middle mouse clicking the draggable knob of the slider.
		
		Name | Description
		--- | ---
		`default` | The new default value of the slider to set
    **/
    
     
    function SetDefaultValue(_default:Float):Void;
    
}


@:multiReturn extern class DNumSliderTranslateSliderValuesReturn {
var a:Float;
var b:Float;

}

#end