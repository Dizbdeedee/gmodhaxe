package gmod;

import lua.Lua;


@:forward
abstract StructuredTable<S,K,V>(S) from S to S {

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
    public inline function iterator<V>():Iterator<V> {
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

    @:from
    public inline static function fromTbl<S,K,V>(x:lua.Table<K,V>):StructuredTable<S,K,V> {
	return cast x;
    }
    
}

typedef AnyStructuredTable<S> = StructuredTable<S,Dynamic,Dynamic>;