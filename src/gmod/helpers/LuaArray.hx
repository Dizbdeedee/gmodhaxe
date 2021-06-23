package gmod.helpers;
#if macro 
import haxe.macro.Context;
#end

#if lua
import lua.Lua;
using gmod.helpers.PairTools;
abstract LuaArray<Y>(lua.Table<Int,Y>) to lua.Table<Int,Y> from lua.Table<Int,Y> {

    @:op([])
    inline function get(n:Int):Y {
        return this[n];
    }

    @:op([])
    inline function set(n:Int,val:Y):Y {
        return this[n] = val;
    }
    
    public inline function new<Y>() {
        this = lua.Table.create();
    }

    /**
        Uses `Lua.ipairs`
    **/
    public inline function keyValueIterator():KeyValueIterator<Int,Y> {
        return this.ipairsKVIterator();
    }

    /**
        Uses `Lua.ipairs`
    **/
    public inline function iterator():Iterator<Y> {
        return this.ipairsIterator();
    }

    /**
        Uses `Lua.pairs`
    **/
    public inline function pairsKVIterator<X>():KeyValueIterator<X,Y> {
        return cast this.keyValueIterator();
    }

    /**
        Uses `Lua.pairs`
    **/
    public inline function pairsIterator():Iterator<Y> {
        return this.iterator();
    }
}

class LuaArrayFastIterator<V> {

    var i:Int;

    var tbl:LuaArrayFast<V>;

    var len:Int;
    
    public inline function new(x:LuaArrayFast<V>) {
        i = 1;
        tbl = x;
        len = tbl.length;
    }

    public inline function next() {
        return tbl[i++];
    }

    public inline function hasNext() {
        return i <= len;
    }
}

class LuaArrayFastKeyValueIterator<V> {
    var i:Int;

    var len:Int;

    var tbl:LuaArrayFast<V>;
    
    public inline function new(x:LuaArrayFast<V>) {
        i = 1;
        len = tbl.length;
        tbl = x;
    }

    public inline function next() {
        final result = {key : i, value : tbl[i]};
        i++;
        return result;
    }

    public inline function hasNext() {
        return i <= len;
    }
}

/**
    Faster iteration than ipairs over a lua array (hopefully). Must ensure length is a valid value to properly iterate
**/
@:transitive
abstract LuaArrayFast<V>(LuaArray<V>) to LuaArray<V> {

    
    public var length(get,set):Int;

    @:op([])
    inline function get(n:Int):V {
        return this[n];
    }

    @:op([])
    inline function set(n:Int,v:V):V {
        return this[n] = v;
    }


    inline function set_length(n:Int) {
        return untyped this.length = n;
    }

    inline function get_length() {
        return untyped this.length;
    }

    /**
        Update length by using lua length operator (which involves binary search)
    **/
    public inline function updateLength() {
        return length = untyped __lua__("#{0}",this);
    }

    public inline function add(val:V) {
        length++;
        set(length,val);
    }

    public inline function new() {
        this = lua.Table.create();
        untyped this.length = 0;
    }

    @:from
    public static inline function fromLuaArr<V>(x:LuaArray<V>):LuaArrayFast<V> {
        final x:LuaArrayFast<V> = cast x;
        x.updateLength();
        return cast x;
    }

    public inline function iterator():Iterator<V> {
        return new LuaArrayFastIterator(cast this);
    }

    public inline function keyValueIterator():KeyValueIterator<Int,V> {
        return new LuaArrayFastKeyValueIterator(cast this);
    }


}
#end
class __LuaArray {

    public static macro function createFromArray(x:ExprOf<Array<Dynamic>>) {
        return switch (x) {
			case {expr: EArrayDecl(values), pos: pos}:
                var id = 1;
                final indexes = values.map((val) -> 
                    macro luaArr[$v{id++}] = $val
                );
                
                macro {
                    var luaArr = lua.Table.create();
                    $a{indexes};
                };
            case Context.typeExpr(_) => {expr: TArrayDecl(values), t : type, pos : pos}: 
                var id = 1;
                trace(type);
                final indexes = values.map((val) -> 
                    macro luaArr[$v{id++}] = ${Context.getTypedExpr(val)}
                );
                
                
                final paramtype = switch (type) {
                    case TInst({get: _() => {name : "Array"}}, [param]):
                        param;
                    default:
                        Context.error("Nope...",pos);
                }
                var typepath = macro : gmod.helpers.LuaArray;
                typepath = switch (typepath) {
                    case TPath({pack: pack, name: name}):
                        TPath({pack : pack, name: name, params : [TPType(Context.toComplexType(paramtype))]});
                    default:
                        Context.error("Nope...",pos);
                }
                macro {
                    var luaArr:$typepath = lua.Table.create();
                    $a{indexes};
                };
                
			default:
				Context.error("Nope", Context.currentPos());
				throw "Garbage";
		}
        
    }
}