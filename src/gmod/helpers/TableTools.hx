package gmod.helpers;

/**
    Static extension on lua tables. instead of import, use `using TableTools`
**/
class TableTools {

    public static inline function length(table:Table<Dynamic,Dynamic>):Int {
        return untyped __lua__("#{0}",table);
    }
}
