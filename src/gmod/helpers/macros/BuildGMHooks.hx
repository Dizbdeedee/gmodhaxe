package gmod.helpers.macros;

#if macro
import haxe.macro.Expr.ComplexType;
import haxe.macro.Type.ClassField;

import haxe.macro.Context;
using haxe.macro.TypeTools;

#end

class BuildGMHooks {

    #if macro

    static function generateTFun(field:ClassField) {
        var finalArgs:Array<ComplexType>;
        var finalRet:ComplexType;
        switch (field.type) {
            case TFun(args, ret):
                finalArgs = args.map((data) -> {
                    TNamed(data.name,data.t.toComplexType());
                });
                finalRet = ret.toComplexType();
            default:
                throw "Not a TFun";
        }
        return TFunction(finalArgs,finalRet);
    }
    public static function build() {
        final fields = Context.getBuildFields();
        final gmType = Context.getType("gmod.gamemode.GM");
        final gmCls = switch (gmType) {
            case TInst(_.get() => cls, _):
                cls;
            default:
                Context.error("Not a TInst",Context.currentPos());
                throw "nope";
        }
        for (field in gmCls.fields.get()) {
            final complex:ComplexType = generateTFun(field);
            fields.push({
                name : field.name,
                pos: field.pos,
                kind: FVar(macro : gmod.stringtypes.GMHook<$complex> ,null),
                doc: field.doc
            });
        }
        return fields;
    }

    #end
}