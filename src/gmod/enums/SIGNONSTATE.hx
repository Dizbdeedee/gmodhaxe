package gmod.enums;

@:native("_G")
extern enum abstract SIGNONSTATE(Int) {
    var SIGNONSTATE_NONE;
    var SIGNONSTATE_CHALLENGE;
    var SIGNONSTATE_CONNECTED;	
    var SIGNONSTATE_NEW;
    var SIGNONSTATE_PRESPAWN;
    var SIGNONSTATE_SPAWN;
    var SIGNONSTATE_FULL;
    var SIGNONSTATE_CHANGELEVEL;
}