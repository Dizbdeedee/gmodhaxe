package gmod.structs;
/**
    Table structure used by [matproxy](https://wiki.garrysmod.com/page/Category:matproxy). [Add](https://wiki.garrysmod.com/page/matproxy/Add).
**/
typedef MatProxyData = {
    /**
        The name of the material proxy
    **/
    var name : String;
    /**
        The function used to get variables from the ".vmt". Called once per each ".vmt". Arguments are:
    **/
    var init : Function;
    /**
        The function used to apply the proxy. This is called every frame while any materials with this proxy are used in world. Arguments are:
    **/
    var bind : Function;
    
}
