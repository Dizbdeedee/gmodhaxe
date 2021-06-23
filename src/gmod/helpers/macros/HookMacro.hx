package gmod.helpers.macros;
#if macro
import haxe.macro.Expr.Field;
import haxe.macro.Context;
using Lambda;
using StringTools;
#end

#if macro
class HookMacro {

    public static function build():Array<Field> {
        final fields = Context.getBuildFields();
        var addExpr = false;
        var initField = null;
        var initExpr:Array<haxe.macro.Expr> = [];
        var module = Context.getLocalModule();
        for (field in fields) {
            final meta = field.meta.find((meta) -> meta.name == ":gmodHook");
            if (meta == null) continue;
            if (field.name == "__init__") {
                initField = field;
            }
            switch (meta.params) {
                case [expr = {expr: EConst(CIdent(ident)), pos : pos}, {expr: EConst(CString(str)), pos: _}]:
                    addExpr = true;
                    try {
                        Context.typeExpr(expr);
                        initExpr.push(macro gmod.libs.HookLib.Add($e{expr},$v{str},$i{field.name}));
                    } catch (e) {
                        initExpr.push(macro gmod.libs.HookLib.Add(gmod.stringtypes.Hook.GMHook.$ident,$v{str},$i{field.name}));
                    }
                case [expr = {expr : _, pos : pos}, {expr : EConst(CString(str))}]:
                    addExpr = true;
                    initExpr.push(macro gmod.libs.HookLib.Add($e{expr},$v{str},$i{field.name}));
                case [expr = {expr: EConst(CIdent(ident)), pos : pos}]:
                    final mangleName = "haxe_" + Context.getLocalModule().replace(".","_") + "_" + field.name;
                    
                    addExpr = true;
                    try {
                        Context.typeExpr(expr);
                        initExpr.push(macro gmod.libs.HookLib.Add($e{expr},$v{mangleName},$i{field.name}));
                    } catch (e) {
                        initExpr.push(macro gmod.libs.HookLib.Add(gmod.stringtypes.Hook.GMHook.$ident,$v{mangleName},$i{field.name}));
                    }
                case [expr = {expr: _, pos: pos}]:
                    final mangleName = "haxe_" + Context.getLocalModule().replace(".","_") + "_" + field.name;
                    addExpr = true;
                    initExpr.push(macro gmod.libs.HookLib.Add($e{expr},$v{mangleName},$i{field.name}));
                default:
                    trace("Invalid gmodHook expression...");
            }
        }
        return if (addExpr) {
            if (initField == null) {
                fields.push({
                    name: "__init__",
                    access: [AStatic],
                    kind: FFun({
                        args: [],
                        expr : {
                            expr: EBlock(initExpr),
                            pos: Context.currentPos()
                        }
                    }),
                    pos: Context.currentPos(),
                });
            } else {
                switch (initField.kind) {
                    case FFun({expr: ur = {expr: EBlock(arr), pos: _}}):
                        ur.expr = EBlock(arr.concat(initExpr));
                    default:
                        throw "urr...";
                }
            }
            fields;   
        } else {
            null;
        }
    }
    

}
#end