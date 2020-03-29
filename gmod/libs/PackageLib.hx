package gmod.libs;


/**
    The package library is a standard Lua library, it's mainly for use with the module system built into Lua.
**/
@:native("_G.package")extern class PackageLib {
    
    /**
        Sets a metatable for module with its __index field referring to the global environment, so that this module inherits values from the global environment. To be used as an option to module.
		
		Name | Description
		--- | ---
		`module` | The module table to be given a metatable
    **/
    
    public static function seeall(module:AnyTable):Void;
    
    

}



