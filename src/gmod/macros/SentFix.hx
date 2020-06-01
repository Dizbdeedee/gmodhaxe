package gmod.macros;
#if macro

import haxe.macro.Context;
import haxe.macro.Type;
using haxe.macro.TypeTools;
import gmod.macros.PanelMacro;
import haxe.macro.Expr.TypeDefinition;
import haxe.macro.Expr;
#end

class SentFix {

    #if macro


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
