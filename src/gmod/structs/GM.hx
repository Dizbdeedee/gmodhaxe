package gmod.structs;
/**
    Information about a gamemode, used in [GamemodeCreation](https://wiki.garrysmod.com/page/Gamemode_Creation). For list of hooks, see [GMHooks](https://wiki.garrysmod.com/page/Category:GM_Hooks). While some of the fields may be serverside or clientside only, it is recommended to provide them on both so addons could use their values.
**/
typedef GM = {
    /**
        The table of the base gamemode to derive from, set automatically by DeriveGamemode.
		
		**Note:** It is recommended to use DEFINE_BASECLASS when referencing the gamemode's BaseClass to prevent unintended behavior
		
		**Note:** DeriveGamemode modifies the main gamemode's BaseClass, which is shared with parent gamemodes. Because of this, in parent gamemodes the BaseClass can be incorrect, so for instance you need to use self.BaseClass.BaseClass in the 1st parent instead
    **/
    var BaseClass : AnyTable;
    /**
        The contact email associated with the gamemode.
    **/
    var Email : String;
    /**
        The name of the gamemode folder, automatically set.
    **/
    var FolderName : String;
    /**
        True if the gamemode is derived from sandbox.
    **/
    var IsSandboxDerived : Bool;
    /**
        Set this to true if your gamemode is team-based. Used to enable/disable the base gamemode team system.
    **/
    var TeamBased : Bool;
    /**
        The website associated with the gamemode.
    **/
    var Website : String;
    /**
        The name of the gamemode folder prepended with "gamemodes/" (such as "gamemodes/sandbox"), automatically set.
    **/
    var Folder : String;
    /**
        The fancy name of your gamemode.
    **/
    var Name : String;
    /**
        The name/contact info of the gamemode author.
    **/
    var Author : String;
    /**
        The name of the gamemode folder prepended with "gamemode_" (such as "gamemode_sandbox"), automatically set.
    **/
    var ThisClass : String;
    
}
