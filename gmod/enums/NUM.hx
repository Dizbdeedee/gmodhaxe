package gmod.enums;
#if server
/**
    Various count enums.
	**Note:** These only exist serverside.
**/
@:native("_G")
extern enum abstract NUM(Int) {
    /**
        Amount of [HULL_Enums](https://wiki.garrysmod.com/page/Enums/HULL).
    **/
    var NUM_HULLS;
    /**
        Amount of [CLASS_Enums](https://wiki.garrysmod.com/page/Enums/CLASS). Used by [Add_NPC_Class](https://wiki.garrysmod.com/page/Global/Add_NPC_Class).
    **/
    var NUM_AI_CLASSES;
    
}
#end