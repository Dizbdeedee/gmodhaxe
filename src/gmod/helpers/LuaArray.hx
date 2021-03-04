package gmod.helpers;
#if macro 
import haxe.macro.Context;
#end

#if lua
import lua.Lua;

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
    public function keyValueIterator():KeyValueIterator<Int,Y> {
        var p = Lua.ipairs(this);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(this, i);
                i = res.index;
                return {key: res.index, value: res.value};
            },
            hasNext: function() {
                return next(this, i).value != null;
            }
        }
    }

    /**
        Uses `Lua.ipairs`
    **/
    public function iterator():Iterator<Y> {
        var p = Lua.ipairs(this);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(this, i);
                i = res.index;
                return res.value;
            },
            hasNext: function() {
                return next(this, i).value != null;
            }
        }
    }

    /**
        Uses `Lua.pairs`
    **/
    public function pairsKVIterator<X>():KeyValueIterator<X,Y> {
        var p = Lua.pairs(this);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(this, i);
                i = res.index;
                return {key: cast res.index, value: res.value};
            },
            hasNext: function() {
                return Lua.next(this, i).value != null;
            }
        }
    }

    /**
        Uses `Lua.pairs`
    **/
    public function pairsIterator():Iterator<Y> {
        var p = Lua.pairs(this);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(this, i);
                i = res.index;
                return res.value;
            },
            hasNext: function() {
                return Lua.next(this, i).value != null;
            }
        }
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