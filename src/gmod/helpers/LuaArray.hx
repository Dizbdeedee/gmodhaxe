package gmod.helpers;

import lua.Lua;

abstract LuaArray<Y>(lua.Table<Int,Y>) to lua.Table<Int,Y> from lua.Table<Int,Y> to lua.Table<Dynamic,Dynamic> {

    @:op([])
    inline function get(n:Int):Y {
        return this[n];
    }

    @:op([])
    inline function set(n:Int,val:Y):Y {
        return this[n] = val;
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
