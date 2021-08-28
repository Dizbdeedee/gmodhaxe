package gmod.helpers.macros;
#if macro

import haxe.macro.Context;
import haxe.macro.Type;
using haxe.macro.TypeTools;
import gmod.helpers.macros.PanelMacro;
import haxe.macro.Expr.TypeDefinition;
import haxe.macro.Expr;
#end

class SentFix {

    #if macro

    static function cleanClassFuncToField(x:ClassField):Field {
        var args:Array<FunctionArg> = [];
        var exprArgs = [];
        var ret:haxe.macro.Type;
        switch (x.type) {
            case TFun(oldArgs, oldRet):
                exprArgs = [];
                for (oldArg in oldArgs) {
                    args.push(argToFuncArg(oldArg));
                    exprArgs.push(macro $i{oldArg.name});
                }
                ret = oldRet;
            default:
                Context.error("Unhandled cleanClassFuncToField",x.pos);
                throw null;
        }
        var func:Function = {
            args : args,
            ret : Context.toComplexType(ret),
            expr : null
        }
        var field:Field = {
            kind : FieldType.FFun(func),
            name : x.name,
            pos : Context.currentPos(),
            doc : x.doc,
            access: [],
            meta: x.meta.get().concat([{
                name: ":inheritDoc",
                pos: Context.currentPos()
            }])
        }
        return field;
    }



    static function generate(cls:ClassType,name:String,_extend:ComplexType):TypeDefinition {
        var extend = switch (_extend) {
            case TPath(tp):
                tp;
            default:
                throw "Need type path";
        };
        var newCls = macro class $name extends $extend {

        };
        newCls.isExtern = true;
        for (clsfield in cls.fields.get()) {
            switch (clsfield.kind) {
            case FMethod(_):
                var newfield = PanelMacro.cleanClassFuncToField(clsfield);
                if (newfield != null) {
                    newCls.fields.push(newfield);
                }
            default:
            }
        }
        return newCls;
    }

    public static function build():ComplexType {
        var typ = Context.getLocalType();
        return switch (typ) {
            case TInst(_, [TInst(_.get() => {name : "NPC"},_)]):
                var td = generate(Context.getType("gmod.sent.ENT").getClass(),"ENTNPC",macro : gmod.gclass.NPC);
                Context.defineType(td);
                macro : ENTNPC;
            case TInst(_, [TInst(_.get() => {name : "NextBot"},_)]):
                var td = generate(Context.getType("gmod.sent.ENT").getClass(),"ENTNextbot",macro : gmod.gclass.NextBot);
                Context.defineType(td);
                macro : ENTNextbot;
            default:
                macro : gmod.sent.ENT;

        }
    }
    #end
}
