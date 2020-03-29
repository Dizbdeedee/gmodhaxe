package gmod.enums;
/**
    Enumerations used by game.SetGlobalState and game.GetGlobalState. 
	
	Serverside only.
**/
@:native("_G")
extern enum abstract GLOBAL(Int) {
    /**
        The global state is dead and is no longer active. It will be cleared.
    **/
    var GLOBAL_DEAD;
    /**
        Initial state, the global state is off.
    **/
    var GLOBAL_OFF;
    /**
        The global state is enabled.
    **/
    var GLOBAL_ON;
    
}