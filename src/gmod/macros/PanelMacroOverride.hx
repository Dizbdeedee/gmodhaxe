package gmod.macros;

import haxe.macro.Type.ClassKind;
import haxe.macro.Expr;
import haxe.macro.Context;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools;
class PanelMacroOverride {

    public static function generateBaseClass(superFields:Dynamic):TypeDefinition { //classfield
        return null;
    }

    public static function build():Array<Field> {
        #if macro
        var fields = Context.getBuildFields();
        var cls = Context.getLocalClass().get();
        if (cls.meta.has(":PanelHelper")) {
            return null;
        }
        var exprAddToTable:Array<Expr> = [];
        var exprBuffer:Array<Expr> = [];
        var superType = switch (cls.superClass) {
            case {params : p,t : _.get() => supercls}:
                supercls;
            default:
                return null;
        }
        exprBuffer.push(macro var PANEL = lua.Table.create());
        var overrideninit = false;
        var classname = cls.name;
        for (field in fields) {
            switch (field.kind) {
                case FFun(f):
                    if (field.access.contains(Access.AOverride) ||
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
        cls.meta.add(":FirstPanel",[],Context.currentPos());
        var ourtype = Context.toComplexType(Context.getLocalType());
        var superreal = switch (superType.meta.extract(":RealPanel")) {
        case  [{params : [expr = {expr: EArrayDecl(arr)}]}]:
            var pack = arr.map((e) -> e.getValue());
            var name = pack[arr.length - 1];
            pack.resize(arr.length - 1);
            cls.meta.add(":RealPanel",[expr],Context.currentPos());
            TPath({pack : pack,name : name});
        default:
            trace("failed");
            return null;
        }
        var hxgen = (macro : gmod.HaxeGen<$superreal,$ourtype>);
        var panelclass = (macro : gmod.PanelClass<gmod.HaxeGen<$superreal,$ourtype>>);
        var classname = cls.name;
        var fieldstor = macro class {
            public static function register() {

            }
            //public final BaseClass:
            public static inline final gclass:$panelclass = $v{classname};
            public final self:$superreal;//TODO possibly improve self

            final function new (x:$superreal) {
               self = x;
            }
        }
        (fieldstor.fields[0].kind.getParameters()[0]:Function).expr = macro $b{exprBuffer};
        fields.push(fieldstor.fields[0]);
        fields.push(fieldstor.fields[1]);
        if (!superType.meta.has(":FirstPanel")) {
            fields.push(fieldstor.fields[2]);
            fields.push(fieldstor.fields[3]);
        }
        return fields;
        #else
        return null;
        #end
    }
    
}
