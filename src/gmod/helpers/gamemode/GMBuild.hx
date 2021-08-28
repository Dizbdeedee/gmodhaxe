package gmod.helpers.gamemode;

/**
    Information about a gamemode, used in [GamemodeCreation](https://wiki.garrysmod.com/page/Gamemode_Creation). For list of hooks, see [GMHooks](https://wiki.garrysmod.com/page/Category:GM_Hooks). While some of the fields may be serverside or clientside only, it is recommended to provide them on both so addons could use their values.
**/
typedef GamemodeFields = {
    /**
        The contact email associated with the gamemode.
    **/
    final ?Email : String;
    /**
        Set this to true if your gamemode is team-based. Used to enable/disable the base gamemode team system.
    **/
    final ?TeamBased : Bool;
    /**
        The website associated with the gamemode.
    **/
    final ?Website : String;
    /**
        The fancy name of your gamemode.
    **/
    final ?Name : String;
    /**
        The name/contact info of the gamemode author.
    **/
    final ?Author : String;
}

@:genericBuild(gmod.helpers.macros.PanelMacro.buildGamemode())
class GMBuild<T:gmod.gamemode.GM> {

}
