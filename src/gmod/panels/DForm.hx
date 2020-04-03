package gmod.panels;
#if client

/**
    An easy form with functions to quickly add form elements
**/
extern class DForm extends DCollapsibleCategory {
    /**
        Adds a DCheckBoxLabel onto the DForm
		
		Name | Description
		--- | ---
		`label` | The label to be set next to the check box
		`convar` | The console variable to change when this is changed
		
		
		`**Returns:** The created DCheckBoxLabel
    **/
    
     
    function CheckBox(label:String, convar:String):Panel;
    /**
        Sets the title (header) name of the DForm. This is Label until set.
		
		Name | Description
		--- | ---
		`name` | The new header name.
    **/
    
     
    function SetName(name:String):Void;
    /**
        Adds one or two items to the DForm. If this method is called with only one argument, it is added to the bottom of the form. If two arguments are passed, they are placed side-by-side at the bottom of the form. 
		
		Internally, this function is used by the various DForm functions to, for example, add labels to the left of buttons.
		
		Name | Description
		--- | ---
		`left` | Left-hand element to add to the DForm.
		`right` | Right-hand element to add to the DForm.
    **/
    
     
    function AddItem(left:Panel, ?right:Panel):Void;
    /**
        Adds a DListBox onto the DForm
		
		Name | Description
		--- | ---
		`label` | The label to set on the DListBox
		
		
		Name | Description
		--- | ---
		`a` | The created DListBox
		`b` | The created DLabel
    **/
    
     
    function ListBox(label:String):DFormListBoxReturn;
    /**
        Creates a DPanelSelect and docks it to the top of the DForm.
		
		`**Returns:** The created DPanelSelect.
    **/
    
     
    function PanelSelect():Panel;
    /**
        Adds a DLabel onto the DForm. Unlike DForm:Help, this is indented and is colored blue, depending on the derma skin.
		
		Name | Description
		--- | ---
		`help` | The help message to be displayed.
		
		
		`**Returns:** The created DLabel
    **/
    
     
    function ControlHelp(help:String):Panel;
    /**
        Adds a DLabel onto the DForm as a helper
		
		Name | Description
		--- | ---
		`help` | The help message to be displayed
		
		
		`**Returns:** The created DLabel
    **/
    
     
    function Help(help:String):Panel;
    /**
        Adds a DButton onto the DForm
		
		Name | Description
		--- | ---
		`text` | The text on the button
		`concmd` | The concommand to run when the button is clicked
		`concmd args` | The arguments to pass on to the concommand when the button is clicked
		
		
		`**Returns:** The created DButton
    **/
    
     
    function Button(text:String, concmd:String, args:Rest<Dynamic>):Panel;
    /**
        ***Deprecated:** 
		
		Does nothing.
    **/
    @:deprecated("")
     
    function Rebuild():Void;
    /**
        Adds a DNumSlider onto the DForm
		
		Name | Description
		--- | ---
		`label` | The label of the DNumSlider
		`convar` | The console variable to change when the slider is changed
		`min` | The minimum value of the slider
		`max` | The maximum value of the slider
		`decimals` | The number of decimals to allow on the slider. (Optional)
		
		
		`**Returns:** The created DNumSlider
    **/
    
     
    function NumSlider(label:String, convar:String, min:Float, max:Float, ?decimals:Float):Panel;
    /**
        Adds a DComboBox onto the DForm
		
		Name | Description
		--- | ---
		`title` | Text to the left of the combo box
		`convar` | Console variable to change when the user selects something from the dropdown.
		
		
		Name | Description
		--- | ---
		`a` | The created DComboBox
		`b` | The created DLabel
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( ScrW() / 2, ScrH() / 2 )
		frame:MakePopup()
		
		local form = frame:Add("DForm")
		form:Dock( FILL )
		form:DockMargin( 5, 5, 5, 5 )
		
		local combobox, label = form:ComboBox( "test", "sv_accelerate" )
		combobox:AddChoice( "10" ) -- 10 will be used as convar value
		combobox:AddChoice( "1000", 100 ) -- 100 will be used as convar value
		```
    **/
    
     
    function ComboBox(title:String, convar:String):DFormComboBoxReturn;
    /**
        Adds a DTextEntry to a DForm
		
		Name | Description
		--- | ---
		`label` | The label to be next to the text entry
		`convar` | The console variable to be changed when the text entry is changed
		
		
		Name | Description
		--- | ---
		`a` | The created DTextEntry
		`b` | The created DLabel
    **/
    
     
    function TextEntry(label:String, convar:String):DFormTextEntryReturn;
    /**
        Adds a DNumberWang onto the DForm
		
		Name | Description
		--- | ---
		`label` | The label to be placed next to the DNumberWang
		`convar` | The console variable to change when the slider is changed
		`min` | The minimum value of the slider
		`max` | The maximum value of the slider
		`decimals` | The number of decimals to allow in the slider (Optional)
		
		
		Name | Description
		--- | ---
		`a` | The created DNumberWang
		`b` | The created DLabel
    **/
    
     
    function NumberWang(label:String, convar:String, min:Float, max:Float, ?decimals:Float):DFormNumberWangReturn;
    
}


@:multiReturn extern class DFormTextEntryReturn {
var a:Panel;
var b:Panel;

}
@:multiReturn extern class DFormNumberWangReturn {
var a:Panel;
var b:Panel;

}
@:multiReturn extern class DFormListBoxReturn {
var a:Panel;
var b:Panel;

}
@:multiReturn extern class DFormComboBoxReturn {
var a:Panel;
var b:Panel;

}

#end