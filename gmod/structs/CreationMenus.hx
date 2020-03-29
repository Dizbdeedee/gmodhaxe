package gmod.structs;
/**
    Table that maintains information on the creation menu tabs. Each key of the table represents the name of the tab. See [spawnmenu](https://wiki.garrysmod.com/page/Category:spawnmenu). [AddCreationTab](https://wiki.garrysmod.com/page/spawnmenu/AddCreationTab) and [spawnmenu](https://wiki.garrysmod.com/page/Category:spawnmenu). [GetCreationTabs](https://wiki.garrysmod.com/page/spawnmenu/GetCreationTabs).
**/
typedef CreationMenus = {
    /**
        The function used to generate the content of the tab.
    **/
    var Function : Function;
    /**
        The icon material that will accompany the title of the tab.
    **/
    var Icon : String;
    /**
        The order in which a tab will be displayed relative to the other tabs.
    **/
    var Order : Float;
    /**
        The tooltip to be shown with the tab.
    **/
    var Tooltip : String;
    
}
