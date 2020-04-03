package gmod.structs;
/**
    Table structure used by [undo](https://wiki.garrysmod.com/page/Category:undo). [Do_Undo](https://wiki.garrysmod.com/page/undo/Do_Undo).
**/
typedef Undo = {
    /**
        A table of entities to be removed by the undo
    **/
    var Entities : AnyTable;
    /**
        A custom undo text to show the client
    **/
    var CustomUndoText : String;
    /**
        The player responsible who owns the undo
    **/
    var Owner : Player;
    /**
        The name of the text to report to the player
    **/
    var Name : String;
    /**
        A table of {function_to_call, func_arg2, func_arg3}
    **/
    var Functions : AnyTable;
    
}
