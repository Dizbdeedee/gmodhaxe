package gmod.helpers;
/**
    Enables @:gmodHook metadata for your class, if autoconfigure is not enabled

    Automatically configured @:gmodHook metadata conflicts with static imports. If you want to use static imports and @:gmodHook, add -D noGmodHook to your hxml file 
**/
@:autoBuild(gmod.helpers.macros.HookMacro.build())
interface HookMacro {}
