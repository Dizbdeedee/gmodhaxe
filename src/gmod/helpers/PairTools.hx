package gmod.helpers;

import lua.*;
import lua.Lua;

/**
 * Haxe makes functions inside a structure as if the function is for the object. This is not always desired behavior
 */
private typedef Workaround = {
   var key:Dynamic;
   var value : Dynamic ;
}



/**
    Pairs iterator
**/
class LuaPIterator<V> {

    var tbl:lua.Table<Dynamic,V>;

    var lnext:(x:lua.Table<Dynamic,V>,ind:Dynamic) -> NextResult<Dynamic, V>;

    var nextV:V;

    var i:Dynamic;

    public inline function new(x:lua.Table<Dynamic,V>) {
        tbl = x;
        final p = Lua.pairs(x);
        lnext = p.next;
        final init = lnext(tbl,p.index);
        nextV = init.value;
        i = init.index;
    }

    public inline function next() {
        final v = nextV;
        final nextResult = lnext(tbl,i);
        i = nextResult.index;
        nextV = nextResult.value;
        return v;
    }

    public inline function hasNext() {
        return nextV != null;
    }


}
/**
    Ipairs iterator
**/
class LuaIPIterator<V> {
    var tbl:lua.Table<Dynamic,V>;

    var lnext:(x:lua.Table<Dynamic,V>,ind:Int) -> NextResult<Int, V>;

    var nextV:V;

    var i:Int;

    public inline function new(x:lua.Table<Dynamic,V>) {
        tbl = x;
        final p = Lua.ipairs(x);
        lnext = p.next;
        final init = lnext(tbl,p.index);
        nextV = init.value;
        i = init.index;
    }

    public inline function next() {
        final v = nextV;
        final nextResult = lnext(tbl,i);
        i = nextResult.index;
        nextV = nextResult.value;
        return v;
    }

    public inline function hasNext() {
        return nextV != null;
    }

}

/**
    Key value pairs iterator
**/
class LuaKVPIterator<K,V> {

    var tbl:lua.Table<K,V>;

    var lnext:(x:lua.Table<K,V>,ind:K) -> NextResult<K, V>;

    var nextV:V;

    var nextI:Dynamic;

    public inline function new(x:lua.Table<K,V>) {
        tbl = x;
        final p = Lua.pairs(x);
        lnext = p.next;
        final init = lnext(tbl,p.index);
        nextV = init.value;
        nextI = init.index;
    }

    public inline function next() {
        final v = nextV;
        final i = nextI;
        final nextResult = lnext(tbl,nextI);
        nextI = nextResult.index;
        nextV = nextResult.value;
        return {key : i, value : v};
    }

    public inline function hasNext() {
        return nextV != null;
    }
    
}
/**
    Key value ipairs iterator
**/
class LuaKVIPIterator<V> {
    var tbl:lua.Table<Dynamic,V>;

    var lnext:(x:lua.Table<Dynamic,V>,ind:Int) -> NextResult<Int, V>;

    var nextV:V;

    var nextI:Int;

    public inline function new(x:lua.Table<Dynamic,V>) {
        tbl = x;
        final p = Lua.ipairs(x);
        lnext = p.next;
        final init = lnext(tbl,p.index);
        nextV = init.value;
        nextI = init.index;
    }

    public inline function next() {
        final v = nextV;
        final i = nextI;
        final nextResult = lnext(tbl,nextI);
        nextI = nextResult.index;
        nextV = nextResult.value;
        return {key : i, value : v};
    }

    public inline function hasNext() {
        return nextV != null;
    }
}

/**
    Lua KeyTable pairs iterator
**/
class LuaKeyTablePIterator<K> {
    var tbl:lua.Table<K,Dynamic>;

    var lnext:(x:lua.Table<K,Dynamic>,ind:K) -> NextResult<K, Dynamic>;

    var nextV:Dynamic;

    var nextI:K;

    public inline function new(x:lua.Table<K,Dynamic>) {
        tbl = x;
        final p = Lua.pairs(x);
        lnext = p.next;
        final init = lnext(tbl,p.index);
        nextV = init.value;
        nextI = init.index;
    }

    public inline function next() {
        final i = nextI; 
        final nextResult = lnext(tbl,nextI);
        nextI = nextResult.index;
        nextV = nextResult.value;
        return i;
    }

    public inline function hasNext() {
        return nextV != null;
    }
}

class PairTools {

    /**
        Uses `Lua.pairs`
    **/
    public inline static function keyValueIterator<A, B>(table:Table<A, B>):KeyValueIterator<A,B> {
        return new LuaKVPIterator(cast table);
    }
    /**
        Uses `Lua.pairs`
    **/
    public inline static function iterator<B>(table:Table<Dynamic, B>):Iterator<B> {
        return new LuaPIterator(cast table);
    }

    public inline static function ipairsKVIterator<A,B>(table:Table<A, B>):KeyValueIterator<Int,B> {
        return new LuaKVIPIterator(cast table);
    }

    public inline static function ipairsIterator<Dynamic,B>(table:Table<Dynamic, B>):Iterator<B> {
        return new LuaIPIterator(cast table);
    }

    /**
     * Turns a lua table into a KeyTable, where the keys become the default iterator
     * There are no actual changes to the table, and it is just an abstract.
     * Useful for lambda functions.
    **/
    public static inline function keys<A,B>(table:Table<A,B>):KeyTable<A,B> {
        return cast table;
    }

}

/**
   A table where the keys are the iterator priority.
   It's just an abstract, so there are no actual changes.
**/
abstract KeyTable<A,B>(Table<A,B>) {
    /**
        Uses `Lua.pairs`
    **/
    public inline function iterator():Iterator<A> {
        return new LuaKeyTablePIterator(this);
        // var p = Lua.pairs(this);
        // var next = p.next;
        // var i = p.index;
        // return {
        //     next: function() {
        //         var res = next(this, i);
        //         i = res.index;
        //         return res.index;
        //     },
        //     hasNext: function() {
        //         return Lua.next(this, i).value != null;
        //     }
        // }
    }

    public function toTable():Table<A,B> {
        return cast this;
    }

}
