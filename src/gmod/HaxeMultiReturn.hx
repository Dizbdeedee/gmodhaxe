package gmod;
import haxe.DynamicAccess;
import lua.Table;
using lua.TableTools;

/**
    Use this with a typedef to add the ability to multireturn from a haxe function.
    This adds a bit of overhead in exchange for typed multireturns
    To have them in order, use a,b,c,d,e.... ect. as the keys for the structure
**/
abstract HaxeMultiReturn<T>(Dynamic) to T {
    @:from
    public inline static function multiReturn<T:Dynamic>(rtns:T):HaxeMultiReturn<T> {
        var tbl = Table.create();
        for (name => value in (rtns : DynamicAccess<Dynamic>)) {
            tbl[name.charCodeAt(0) - 96] = value;
        }
        return tbl.unpack();    
    }
}






