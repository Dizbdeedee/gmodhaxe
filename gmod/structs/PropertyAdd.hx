package gmod.structs;
/**
    Structure used for [properties](https://wiki.garrysmod.com/page/Category:properties). [Add](https://wiki.garrysmod.com/page/properties/Add).
**/
typedef PropertyAdd = {
    /**
        Called clientside when the property is clicked with these arguments:
    **/
    var Action : Function;
    /**
        Icon to show on opened menu for this item. Optional for simple properties and unused for toggle properties. 
		
		Default: nil
    **/
    var ?MenuIcon : String;
    /**
        Used clientside to decide whether this property should be shown for an entity. Gets these arguments:
    **/
    var Filter : Function;
    /**
        Called clientside when the property option has been created in the right-click menu. This is not called for toggle properties!
    **/
    var ?MenuOpen : Function;
    /**
        Same as MenuOpen, but also called for toggle properties and has different arguments. This is called immediately after MenuOpen, but nothing happens in between so you should only ever use one or the other.
    **/
    var ?OnCreate : Function;
    /**
        Whether to add a spacer before this property. This should generally be true for the first property in a group of properties. 
		
		Default: false
    **/
    var ?PrependSpacer : Bool;
    /**
        Required for toggle properties (clientside). Must return a boolean value to either check or uncheck the toggle property.
    **/
    var Checked : Function;
    /**
        Can be set to "toggle" to make this property a toggle property. 
		
		Default: "simple"
    **/
    var ?Type : String;
    /**
        Where in the list should the property be positioned, relative to other properties. 
		
		For reference, here are the default properties and their Order values:
    **/
    var Order : Float;
    /**
        Called serverside if the client sends a message in the 'Action' function (see above).
    **/
    var ?Receive : Function;
    /**
        Label to show on opened menu
    **/
    var MenuLabel : String;
    
}
