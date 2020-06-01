package gmod;

/**
    Static extension on lua tables. instead of import, use `using TableTools`
**/
class TableTools {

    public static inline function length<X,Y>(table:Table<X,Y>):Int {
        return untyped __lua__("#{0}",table);
    }
}
