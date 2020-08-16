package gmod.libs;

@:native("_G.baseclass") extern class BaseclassLib {

    static function Get(name:String):AnyTable;

    static function Set(name:String,tab:AnyTable):Void;

}
