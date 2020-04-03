package gmod;

import gmod.libs.GlobalLib;


@:native("__lua_Boot")
class Patch {

    /**
        Needed to print gmod types
        @see lua.Boot
    **/
    @:access(lua.Boot)
    static function __string_rec(o:Dynamic,s:String = "") {
        if (s.length >= 5)
            return "<...>";
        return switch (untyped __type__(o)) {
            case "nil": "null";
            case "number": {
                    if (o == std.Math.POSITIVE_INFINITY)
                        "Infinity";
                    else if (o == std.Math.NEGATIVE_INFINITY)
                        "-Infinity";
                    else if (o == 0)
                        "0";
                    else if (o != o)
                        "NaN";
                    else
                        untyped tostring(o);
                }
            case "boolean": untyped tostring(o);
            case "string": o;
            case "userdata": {
                    var mt = lua.Lua.getmetatable(o);
                    if (mt != null && mt.__tostring != null) {
                        lua.Lua.tostring(o);
                    } else {
                        "<userdata>";
                    }
                }
            case "function": "<function>";
            case "thread": "<thread>";
            case "table": {
                    if (o.__enum__ != null)
                       lua.Boot.printEnum(o, s);
                    else if (o.toString != null && !lua.Boot.isArray(o))
                        o.toString();
                    else if (lua.Boot.isArray(o)) {
                        var o2:Array<Dynamic> = untyped o;
                        if (s.length > 5)
                            "[...]"
                        else
                            '[${[for (i in o2) __string_rec(i, s + 1)].join(",")}]';
                    } else if (o.__class__ != null)
                        lua.Boot.printClass(o, s + "\t");
                    else {
                        var fields:Iterator<String> = lua.Boot.fieldIterator(o);
                        var buffer:Table<Int, String> = Table.create();
                        var first = true;
                        Table.insert(buffer, "{ ");
                        for (f in fields) {
                            if (first)
                                first = false;
                            else
                                Table.insert(buffer, ", ");
                            Table.insert(buffer, '${Std.string(f)} : ${untyped __string_rec(o[f], s + "\t")}');
                        }
                        Table.insert(buffer, " }");
                        Table.concat(buffer, "");
                    }
                };
            default:
                switch (GlobalLib.TypeID(o)) {
                    case TYPE_NONE:
                        throw "Invalid type";
                    case _:
                        untyped tostring(o);
                }
        }
    }
}