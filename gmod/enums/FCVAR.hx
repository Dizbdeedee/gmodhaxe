package gmod.enums;
/**
    Enumerations used by concommand.Add, CreateClientConVar and CreateConVar.
**/
@:native("_G")
extern enum abstract FCVAR(Int) {
    /**
        Set automatically on all ConVars and console commands created by the server Lua state. Reported as "lua_server" by cvarlist
    **/
    var FCVAR_LUA_SERVER;
    /**
        Forces the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) to only have printable characters ( No control characters ) Reported as "print" by cvarlist
    **/
    var FCVAR_PRINTABLEONLY;
    /**
        [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) is defined by the game DLL.This flag is set automatically Reported as "sv" by cvarlist
    **/
    var FCVAR_GAMEDLL;
    /**
        Don't log the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) changes to console/log files/users Reported as "log" by cvarlist
    **/
    var FCVAR_UNLOGGED;
    /**
        The server is allowed to execute this command on clients. Reported as "server_can_execute" by cvarlist
    **/
    var FCVAR_SERVER_CAN_EXECUTE;
    /**
        Prevents the server from querying value of this [ConVar](https://wiki.garrysmod.com/page/Category:ConVar)
    **/
    var FCVAR_SERVER_CANNOT_QUERY;
    /**
        No flags
    **/
    var FCVAR_NONE;
    /**
        If this is set, the convar will become anonymous and won't show up in the 'find' results.
    **/
    var FCVAR_UNREGISTERED;
    /**
        Tells the engine to never print this variable as a string. Reported as "numeric" by cvarlist
    **/
    var FCVAR_NEVER_AS_STRING;
    /**
        For serverside [ConVars](https://wiki.garrysmod.com/page/Category:ConVar), notifies all players with blue chat text when the value gets changed Reported as "nf" by cvarlist
    **/
    var FCVAR_NOTIFY;
    /**
        Requires sv_cheats to be enabled to change the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) or run the command Reported as "cheat" by cvarlist
    **/
    var FCVAR_CHEAT;
    /**
        Executing the command or changing the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) is only allowed in singleplayer Reported as "sp" by cvarlist
    **/
    var FCVAR_SPONLY;
    /**
        [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) is defined by the client DLL.This flag is set automatically Reported as "cl" by cvarlist
    **/
    var FCVAR_CLIENTDLL;
    /**
        Force the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) to be recorded by demo recordings. Reported as "demo" by cvarlist
    **/
    var FCVAR_DEMO;
    /**
        Save the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) value into config.cfg Reported as "a" by cvarlist, except Lua ConVars
    **/
    var FCVAR_ARCHIVE;
    /**
        For serverside [ConVars](https://wiki.garrysmod.com/page/Category:ConVar), it will send its value to all clients. The [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) with the same name must also exist on the client! Reported as "rep" by cvarlist
    **/
    var FCVAR_REPLICATED;
    /**
        Makes the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) not changeable while connected to a server or in singleplayer
    **/
    var FCVAR_NOT_CONNECTED;
    /**
        Makes the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) value hidden from all clients ( For example sv_password ) Reported as "prot" by cvarlist
    **/
    var FCVAR_PROTECTED;
    /**
        Set automatically on all ConVars and console commands created by the client Lua state. Reported as "lua_client" by cvarlist
    **/
    var FCVAR_LUA_CLIENT;
    /**
        For clientside commands, sends the value to the server Reported as "user" by cvarlist
    **/
    var FCVAR_USERINFO;
    /**
        Opposite of FCVAR_DEMO, ensures the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) is not recorded in demos Reported as "norecord" by cvarlist
    **/
    var FCVAR_DONTRECORD;
    /**
        IVEngineClient::ClientCmd is allowed to execute this command Reported as "clientcmd_can_execute" by cvarlist
    **/
    var FCVAR_CLIENTCMD_CAN_EXECUTE;
    /**
        Save the [ConVar](https://wiki.garrysmod.com/page/Category:ConVar) value into config.cfg on XBox
    **/
    var FCVAR_ARCHIVE_XBOX;
    
}