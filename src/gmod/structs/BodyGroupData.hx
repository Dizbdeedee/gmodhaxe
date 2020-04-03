package gmod.structs;
/**
    Table returned by [Entity](https://wiki.garrysmod.com/page/Category:Entity): [GetBodyGroups](https://wiki.garrysmod.com/page/Entity/GetBodyGroups).
**/
typedef BodyGroupData = {
    /**
        Name of the body group.
    **/
    var name : String;
    /**
        Amount of subgroups.
    **/
    var num : Float;
    /**
        Index of the body group.
    **/
    var id : Float;
    
}
