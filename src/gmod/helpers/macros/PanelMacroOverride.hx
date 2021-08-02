package gmod.helpers.macros;

import haxe.macro.Type.ClassKind;
import haxe.macro.Expr;
import haxe.macro.Context;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools;
import gmod.helpers.macros.Util;
class PanelMacroOverride {

    public static function generateBaseClass(superFields:Dynamic):TypeDefinition { //classfield
        return null;
    }

    public static function genericBuild():ComplexType {
        // var fieldstor = macro class $classname extends $superComp2 {
        //     public static function register() {

        //     }

        //     public static inline final gclass:$panelclass = $v{classname};
        //     public final self:$gmodType;//TODO possibly improve self

        //     final function new (x:Dynamic) {
        //        self = cast x;
        //     }

        //     public static function create(?parent:gmod.gclass.Panel,?name:String):$gmodType {
        //         return cast gmod.libs.VguiLib.Create(gclass,parent,name);
        //     }

        
        // }
        return (macro : Math);
    }

    public static function build():Array<Field> {
        #if macro
        var fields = Context.getBuildFields();
        var cls = Context.getLocalClass().get();
        if (cls.meta.has(":HaxeGenExtern") || cls.meta.has(":NO")) {
            trace("!NO!");
            return null;
        }
        var exprAddToTable:Array<Expr> = [];
        var exprBuffer:Array<Expr> = [];
        var panelType = extractClassType(Context.getType("gmod.panels.DFrame"));
        var superComp:ComplexType = PanelMacro.build2(panelType);
        var superType = extractClassType(Context.resolveType(superComp,Context.currentPos()));
    
        
        // switch (cls.superClass) {
        //     case {params : p,t : _.get() => supercls}:
        //         supercls;
        //     default:
        //         return null;
        // }
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
            exprBuffer.push(macro untyped __lua__("PANEL.Init = function (dis,...) dis._gHaxeBurrow = {0}.new(dis) end",$i{classname}));
        }
        cls.meta.add(":UserPanel",[],Context.currentPos());
        var ourtype = Context.toComplexType(Context.getLocalType());
        var gmodType = PanelMacro.generateGmodSideExtern({target: cls,gmodParent: superreal,targetFields: fields});
        var panelclass = (macro : gmod.stringtypes.PanelClass<$gmodType>);
        var classname = cls.name;
        final superComp2 = extractPath(superComp);
        var fieldstor = macro class $classname extends $superComp2 {
            public static function register() {

            }

            public static inline final gclass:$panelclass = $v{classname};
            public final self:$gmodType;//TODO possibly improve self

            final function new (x:Dynamic) {
               self = cast x;
            }

            public static function create(?parent:gmod.gclass.Panel,?name:String):$gmodType {
                return cast gmod.libs.VguiLib.Create(gclass,parent,name);
            }

        
        }
        // fieldstor.meta.push({name: ":NO",pos : Context.currentPos()});
        (fieldstor.fields[0].kind.getParameters()[0]:Function).expr = macro $b{exprBuffer};
        fieldstor.fields = fieldstor.fields.concat(fields);
        // trace('userPanel $classname');
        // fields.push(fieldstor.fields[0]);
        // fields.push(fieldstor.fields[1]);
        // if (!superType.meta.has(":UserPanel")) {
        //     // trace('adding to $classname');
        //     fields.push(fieldstor.fields[2]);
        //     fields.push(fieldstor.fields[3]);
        //     fields.push(fieldstor.fields[4]);
        //     // fields.push(fieldstor.fields[5]);
        // }
        
        cls.exclude();
        fields = [];
        trace("lole!");
        if (!typeExists(cls.name)) {
            Context.defineType(fieldstor);

        }
        trace("blah");
        return fields;
        #else
        return null;
        #end
    }
    
}
