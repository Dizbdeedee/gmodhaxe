package gmod.helpers;

import lua.Lua;


@:forward
@:transitive
abstract StructuredTable<S,K,V>(S) to S  {

    /**
        Uses `Lua.pairs`
    **/
    public inline function keyValueIterator():KeyValueIterator<K,V> {
		final p = Lua.pairs(cast this);
		final next = p.next;
		var i = p.index;
		return {
			next: function() {
			var res = next(cast this, i);
			i = res.index;
			return {key: res.index, value: res.value };
			},
			hasNext: function() {
			return Lua.next(cast this, i).value != null;
			}
		}
    }
    /**
        Uses `Lua.pairs`
    **/
    public inline function iterator():Iterator<V> {
		final p = Lua.pairs(cast this);
		final next = p.next;
		var i = p.index;
		return {
			next: function() {
			var res = next(cast this, i);
			i = res.index;
			return res.value;
			},
			hasNext: function() {
			return Lua.next(cast this, i).value != null;
			}
		}
    }

    @:op([])
    inline function arrAccess(key:K) {
		return untyped this[key];
    }

    @:op([])
    inline function arrAcessSet(key:K,val:V) {
		return untyped this[key] = val;
    }

	@:to
    public inline function toTbl():lua.Table<K,V> {
		return cast this;
    }

    // @:from
    // public inline static function fromTbl<S,K,V>(x:lua.Table<K,V>):StructuredTable<S,K,V> {
	// 	return cast x;
    // }
    
}

@:forward
@:transitive
abstract StructuredLuaArray<S,V>(S) to S {

	public inline function ipairsKVIterator():KeyValueIterator<Int,V> {
        var p = Lua.ipairs(cast this);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(cast this, i);
                i = res.index;
                return {key: res.index, value: res.value};
            },
            hasNext: function() {
                return next(cast this, i).value != null;
            }
        }
    }

    public inline function ipairsIterator():Iterator<V> {
        var p = Lua.ipairs(cast this);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(cast this, i);
                i = res.index;
                return res.value;
            },
            hasNext: function() {
                return next(cast this, i).value != null;
            }
        }
    }

    @:op([])
    inline function arrAccess(key:Int) {
		return untyped this[key];
    }

    @:op([])
    inline function arrAcessSet(key:Int ,val:V) {
		return untyped this[key] = val;
    }

    @:to
    public inline function toTbl():lua.Table<Int,V> {
		return cast this;
    }

    // @:from
    // public inline static function fromTbl<S,V>(x:lua.Table<Int,V>):StructuredLuaArray<S,V> {
	// 	return cast x;
    // }
    
}



typedef AnyStructuredTable<S> = StructuredTable<S,Dynamic,Dynamic>;

typedef AnyStructuredLuaArray<S> = StructuredLuaArray<S,Dynamic>;