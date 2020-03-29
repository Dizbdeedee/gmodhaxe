package gmod.structs;
/**
    The TOOL table is used in Sandbox tool creation. You can find a list of callbacks on the TOOL Hooks page and a list of methods on the Tool Functions page. Do note that some of the fields below have no effect on server-side operations. 
	
	The tool information box drawn on the HUD while your tool is selected has 2 values that are set by language.Add. "tool.[tool mode].name" - The tool name (Note this is NOT the same as TOOL.Name) "tool.[tool mode].desc" - The tool description 
	
	 Ensure that all tool file names are entirely lowercase. Including capital letters can lead to unintended behavior.
**/
typedef TOOL = {
    /**
        A key-value ( convar name-default value ) table containing the client-side convars to create. All convars will be prefixed with the filename of the tool. You can later use Tool:GetClientNumber or Tool:GetClientInfo to retrieve these values.
    **/
    var ClientConVar : AnyTable;
    /**
        Class name of the tool. (name of the .lua file) 
		
		This is set automatically.
    **/
    var Mode : String;
    /**
        The tool menu category under which the tool should be listed. 
		
		Default: "New Category"
    **/
    var ?Category : String;
    /**
        The function that is called to build the context menu for your tool. It has one argument, namely the context menu's base panel to which all of your custom panels are going to be parented to. 
		
		While it might sound like a hook, it isn't - you won't receive a self argument inside the function.
    **/
    var BuildCPanel : Function;
    /**
        Same as above, but created server-side instead.
    **/
    var ServerConVar : AnyTable;
    /**
        The console command to execute upon being selected in the Q menu. 
		
		Default: "gmod_toolmode [tool]"
    **/
    var ?Command : String;
    /**
        The name of the tool in the Q menu. Common practice is to set this to "#tool.[lua filename].name" to match the name displayed in the tool information box. 
		
		Default: "#[tool mode]"
    **/
    var ?Name : String;
    /**
        Allows you to override the tool usage information shown when the tool is equipped. See Tool Information Display for more information.
    **/
    var Information : AnyTable;
    /**
        If set to false, the tool won't be added to the tool menu and players will have to access it by other means. 
		
		Default: true
    **/
    var ?AddToMenu : Bool;
    
}
