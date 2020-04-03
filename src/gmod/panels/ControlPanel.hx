package gmod.panels;
#if client

/**
    Used by the context menu in sandbox.
**/
extern class ControlPanel extends DForm {
    /**
        ***Deprecated:** It is recommended to use DForm's members instead.
		
		Adds a control to the control panel.
		
		Name | Description
		--- | ---
		`type` | The control type to add. The complete list is: header textbox label checkbox/toggle slider propselect matselect ropematerial button numpad color combobox listbox materialgallery
		`controlinfo` | Each control takes their own table structure. You may search "AddControl" on GitHub for examples. Here is a full list of each type and the table members it requires: header description textbox: label (def: "Untitled") command label: text checkbox, toggle (same thing): label (def: "Untitled") command help (boolean, if true assumes label is a language string ("#tool.toolname.stuff") and adds ".help" at the end) slider: type (optional string, if equals "float" then 2 digits after the decimal will be used, otherwise 0) label (def: "Untitled") command min (def: 0) max (def: 100) help (boolean, see above) propselect: (data goes directly to PropSelect's :ControlValues(data)) matselect: (data goes directly to MatSelect's :ControlValues(data)) ropematerial: convar (notice: NOT called command this time!) button: label / text (if label is missing will use text. Def: "No Label") command numpad: command command2 label label2 color: label red (convar) green (convar) blue (convar) alpha (convar) combobox: menubutton (if doesn't equal "1", becomes a listbox) folder options (optional, ha) cvars (optional) listbox: height (if set, becomes DListView, otherwise is CtrlListBox) label (def: "unknown") options (optional) materialgallery: width (def: 32) height (def: 32) rows (def: 4) convar options
    **/
    @:deprecated("It is recommended to use DForm's members instead.")
     
    function AddControl(type:String, controlinfo:AnyTable):Void;
    /**
        Returns this control panel.
		
		`**Returns:** The same control panel the function is being called on.
    **/
    
     
    function GetEmbeddedPanel():ControlPanel;
    /**
        Sets control values of the control panel.
		
		Name | Description
		--- | ---
		`data` | A two-membered table: boolean closed - Sets if the control panel should be unexpanded. string label - The text to display inside the control's label.
    **/
    
     
    function ControlValues(data:AnyTable):Void;
    /**
        Creates a MatSelect panel and adds it as an item.
		
		Name | Description
		--- | ---
		`convar` | Calls MatSelect: SetConVar with this value.
		`options` | If specified, calls MatSelect: AddMaterial(key, value) for each table entry. If the table key is a number, the function will instead be called with the value as both arguments.
		`autostretch` | If specified, calls MatSelect: SetAutoHeight with this value.
		`width` | If specified, calls MatSelect: SetItemWidth with this value.
		`height` | If specified, calls MatSelect: SetItemHeight with this value.
		
		
		`**Returns:** The created MatSelect panel.
    **/
    
     
    function MatSelect(convar:String, ?options:AnyTable, ?autostretch:Bool, ?width:Float, ?height:Float):MatSelect;
    /**
        Adds an item by calling DForm:AddItem.
		
		Name | Description
		--- | ---
		`panel` | Panel to add as an item to the control panel.
    **/
    
     
    function AddPanel(panel:Panel):Void;
    /**
        Calls the given function with this panel as the only argument. Used by the spawnmenu to populate the control panel.
		
		Name | Description
		--- | ---
		`func` | A function that takes one argument: ControlPanel panelToPopulate
    **/
    
     
    function FillViaFunction(func:Function):Void;
    
}



#end