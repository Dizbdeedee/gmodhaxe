package gmod.panels;
#if client

/**
    The DCheckBox is a checkbox. It allows you to get a boolean value from the user (true/false - yes/no)
**/
extern class DCheckBox extends DButton {
    /**
        Returns whether the state of the checkbox is being edited. This means whether the user is currently clicking (mouse-down) on the checkbox, and applies to both the left and right mouse buttons.
		
		`**Returns:** Whether the checkbox is being clicked.
    **/
    
     
    function IsEditing():Bool;
    /**
        Sets the checked state of the checkbox. Does not call the checkbox's DCheckBox:OnChange and Panel:ConVarChanged methods, unlike DCheckBox:SetValue.
		
		Name | Description
		--- | ---
		`checked` | Whether the box should be checked or not.
    **/
    
     
    function SetChecked(checked:Bool):Void;
    /**
        Gets the checked state of the checkbox.
		
		`**Returns:** Whether the box is checked or not.
    **/
    
     
    function GetChecked():Bool;
    /**
        Sets the checked state of the checkbox, and calls the checkbox's DCheckBox:OnChange and Panel:ConVarChanged methods.
		
		Name | Description
		--- | ---
		`checked` | Whether the box should be checked or not.
    **/
    
     
    function SetValue(checked:Bool):Void;
    /**
        Called when the "checked" state is changed.
		
		Name | Description
		--- | ---
		`bVal` | Whether the CheckBox is checked or not.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a metamethod on the DCheckBox class to print any changes to the console.
		
		```lua 
		function DCheckBox:OnChange(bVal)
		    if (bVal) then
		        print("Checked!")
		    else
		        print("Unchecked!")
		    end
		end
		```
		**Output:**
		
		All new checkboxes created will print Checked! or Unchecked! when their checked state is changed.
    **/
    
    @:hook 
    function OnChange(bVal:Bool):Void;
    /**
        Toggles the checked state of the checkbox, and calls the checkbox's DCheckBox:OnChange and Panel:ConVarChanged methods. This is called by DCheckBox:DoClick.
    **/
    
     
    function Toggle():Void;
    
}



#end