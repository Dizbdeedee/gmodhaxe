package gmod.macros;

import haxe.macro.Type.ClassKind;
import haxe.macro.Expr;
import haxe.macro.Context;
using haxe.macro.TypeTools;
class PanelMacroOverride {

    public static function build():Array<Field> {
        #if macro
        var fields = Context.getBuildFields();
        var cls = Context.getLocalClass().get();
        if (cls.meta.has(":PanelHelper")) {
            return null;
        }
        var exprAddToTable:Array<Expr> = [];
        var exprBuffer:Array<Expr> = [];
        var superType = switch (Context.getLocalClass().get().superClass) {
            case {params : p,t : _.get() => supercls}:
                supercls;
            default:
                return null;
        }
        
        var classname = cls.name;
        
        exprBuffer.push(macro var PANEL = lua.Table.create());
        var overrideninit = false;
        for (field in fields) {
            switch (field.kind) {
                case FFun(f):
                    if (field.access.indexOf(Access.AOverride) > -1 ||
                        field.meta.filter(f -> f.name == ":exposePANEL").length > 0
                        ) {
                        field.meta.push({name: ":keep",pos : Context.currentPos()});
                        var name = field.name;
                        if (name == "Init") {
                            overrideninit = true;
                            var str = 'PANEL.$name = function(dis,...) dis._gHaxeBurrow = {0}.new(dis) dis._gHaxeBurrow:$name(...) end';
                            exprBuffer.push(macro untyped __lua__($v{str},$i{classname}));
                        } else {
                            var str = 'PANEL.$name = function(dis,...) return dis:$name(...) end';
                            exprBuffer.push(macro untyped __lua__($v{str}));
                        }
                        
                    }
                default:
            }
        }
        if (!overrideninit) {
            exprBuffer.push(macro untyped __lua__("PANEL.Init = function (dis,...) dis.gHaxeBurrow = {0}.new(dis) end",$i{classname}));
        }
        var supername;
        switch (superType.params[0].t) {
            case TInst(_.get() => _.kind => KTypeParameter([TInst(_.get() => {name : n},_)]),_):
                supername = n;
            default:
        }
        // superType.params[0].name
        exprBuffer.push(macro gmod.libs.VguiLib.Register($v{classname},PANEL,$v{supername}));

        var pack = switch (supername) {
            case "Panel":
                "gclass";
            default:
                "panels";
        }
        var ourtype = Context.toComplexType(Context.getLocalType());
        var superreal = TPath({pack: ["gmod",pack],name : supername});
        var panelclass = (macro : gmod.PanelClass<gmod.HaxeGen<$superreal,$ourtype>>);
        
        var _cls = macro class Derka {

            public static function register() {

            }

            public static inline final gclass:$panelclass = $v{classname};

        }
    
        (_cls.fields[0].kind.getParameters()[0]:Function).expr = macro $b{exprBuffer};
        
        fields.push(_cls.fields[0]);
        fields.push(_cls.fields[1]);
        return fields;
        #else
        return null;
        #end
    }
    
}