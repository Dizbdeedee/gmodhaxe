package gmod.helpers;

import lua.*;

/**
 * Haxe makes functions inside a structure as if the function is for the object. This is not always desired behavior
 */
private typedef Workaround = {
   var key:Dynamic;
   var value : Dynamic ;
}

class PairTools {

    /**
        Uses `Lua.pairs`
    **/
    public inline static function keyValueIterator<A, B>(table:Table<A, B>):KeyValueIterator<A,B> {
        final p = Lua.pairs(table);
        final next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(table, i);
                i = res.index;
                return ({key: res.index, value: res.value } : Workaround);
            },
            hasNext: function() {
                return Lua.next(table, i).value != null;
            }
        }
    }
    /**
        Uses `Lua.pairs`
    **/
    public inline static function iterator<B>(table:Table<Dynamic, B>):Iterator<B> {
        final p = Lua.pairs(table);
        final next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(table, i);
                i = res.index;
                return res.value;
            },
            hasNext: function() {
                return Lua.next(table, i).value != null;
            }
        }
    }

    public static function ipairsKVIterator<A,B>(table:Table<A, B>):KeyValueIterator<Int,B> {
        var p = Lua.ipairs(table);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(table, i);
                i = res.index;
                return {key: res.index, value: res.value};
            },
            hasNext: function() {
                return next(table, i).value != null;
            }
        }
    }

    public static function ipairsIterator<Dynamic,B>(table:Table<Dynamic, B>):Iterator<B> {
        var p = Lua.ipairs(table);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(table, i);
                i = res.index;
                return res.value;
            },
            hasNext: function() {
                return next(table, i).value != null;
            }
        }
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
    public function iterator():Iterator<A> {
        var p = Lua.pairs(this);
        var next = p.next;
        var i = p.index;
        return {
            next: function() {
                var res = next(this, i);
                i = res.index;
                return res.index;
            },
            hasNext: function() {
                return Lua.next(this, i).value != null;
            }
        }
    }

    public function toTable():Table<A,B> {
        return cast this;
    }

}
