package gmod;

import lua.*;

class PairTools {
        /**
            Uses `Lua.pairs`
        **/
        public static function keyValueIterator<A, B>(table:Table<A, B>):KeyValueIterator<A,B> {
            var p = Lua.pairs(table);
            var next = p.next;
            var i = p.index;
            return {
                next: function() {
                    var res = next(table, i);
                    i = res.index;
                    return {key: res.index, value: res.value};
                },
                hasNext: function() {
                    return Lua.next(table, i).value != null;
                }
            }
        }
        /**
            Uses `Lua.pairs`
        **/
        public static function iterator<A, B>(table:Table<A, B>):Iterator<B> {
            var p = Lua.pairs(table);
            var next = p.next;
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

        public static function ipairsIteratorKV<A,B>(table:Table<A, B>):KeyValueIterator<Int,B> {
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

        public static function ipairsIterator<A,B>(table:Table<A, B>):Iterator<B> {
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
}