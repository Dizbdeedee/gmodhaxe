package gmod.helpers.macros;

import haxe.macro.Type.ClassKind;
import haxe.macro.Expr;
import haxe.macro.Context;
import gmod.helpers.macros.Util;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools;
using haxe.macro.ComplexTypeTools;
using Lambda;
class PanelMacroOverride {


    

    static function shouldAdd(name:String) {
        return name == ":exposePanel" || name == ":exposeGmod" || name == ":hook";
    }

    
    public static function build():Array<Field> {
        #if macro
        var fields = Context.getBuildFields();
        var cls = Context.getLocalClass().get();
        if (cls.meta.has(":HaxeGenExtern")) {
            return null;
        }
        var parent = cls.superClass.t.get();
        var parentGmod:ComplexType = extractGmodParent(cls.superClass.t.get());
        final exprBuffer:Array<Expr> = [];
        exprBuffer.push(macro var PANEL = lua.Table.create());
        var overrideninit = false;
        for (field in fields) {
            switch (field.kind) {
                case FVar(t, e):
                case FFun(f):
                    
                    if (field.access != null && field.access.contains(Access.AOverride)) {
                        if (field.meta == null) {
                            field.meta = [];
                        }
                        var result = parent.findField(field.name);
                        if (result != null) {
                            field.meta = field.meta.concat(result.meta.get());
                        }
                        getDocsFromParent(field,parent);
                    }
                    if (field.meta != null && field.meta.exists(f -> shouldAdd(f.name))) {
                        field.meta.push({name: ":keep",pos : Context.currentPos()});
                        var name = field.name;
                        if (name == "Init") {
                            overrideninit = true;
                            var str = 'PANEL.$name = function(dis,...) dis._gHaxeBurrow = {0}.new(dis) dis._gHaxeBurrow:$name(...) end';
                            exprBuffer.push(macro untyped __lua__($v{str},$i{cls.name}));
                        } else {
                            var str = 'PANEL.$name = function(dis,...) return dis._gHaxeBurrow:$name(...) end';
                            exprBuffer.push(macro untyped __lua__($v{str}));
                        }
                    }
                default:
            }
        }
        if (!overrideninit) {
            exprBuffer.push(macro untyped __lua__("PANEL.Init = function (dis,...) dis._gHaxeBurrow = {0}.new(dis) end",$i{cls.name}));
        }
        
        var gmodParentClassName = parent.meta.extract(":GmodClassName")[0].params[0];
        exprBuffer.push(macro gmod.libs.VguiLib.Register($v{cls.name},PANEL,$gmodParentClassName));
        var extResult = PanelMacro.generateGmodSideExtern({target: cls,gmodParent: parentGmod,targetFields: fields,markExpose: shouldAdd});
        var gmodType = extResult.link.toComplexType();
        var gmodRaw = extResult.rawClass.toComplexType();
        var panelclass = (macro : gmod.stringtypes.PanelClass<$gmodType>);
        replaceSelfInFields(fields,gmodType);

        var fieldstor = if (parent.findField("self") != null) {
            macro class {
     
                static function register() {

                }
            
                public static inline final gclass:$panelclass = $v{cls.name};
                
                public static function create(?parent:gmod.gclass.Panel,?name:String):$gmodType {
                    return cast gmod.libs.VguiLib.Create(gclass,parent,name);
                }

                public override function get_self():$gmodType {
                    return cast self;
                }
                
                static function __init__() {
                    register();
                }

            }
        } else {
            macro class {

                static function register() {
    
                }
              
                public static inline final gclass:$panelclass = $v{cls.name};
                
                final self:Dynamic;
                
                @:keep
                final function new (x:Dynamic) {
                    self = x;
                }

                public function get_self():$gmodType {
                    return cast self;
                }

                public static function create(?parent:gmod.gclass.Panel,?name:String):$gmodType {
                    return cast gmod.libs.VguiLib.Create(gclass,parent,name);
                }

                static function __init__() {
                    register();
                }
            }
        }
        fieldstor.fields.iter(f -> 
            if (f.meta != null) 
                f.meta.push({name : ":notUser", pos : Context.currentPos()});
            else 
                f.meta = [{name : ":notUser", pos : Context.currentPos()}]
            );
        cls.meta.add(":UserPanel",[],Context.currentPos());
        var tp:Array<String> = TypePathHelper.fromComplexType(gmodRaw);
        var strArr = tp.map((x) -> macro $v{x});
        cls.meta.add(":RealExtern",[macro $a{strArr}],Context.currentPos());
        cls.meta.add(":GmodClassName",[macro $v{cls.name}],Context.currentPos());
        (fieldstor.fields[0].kind.getParameters()[0]:Function).expr = macro $b{exprBuffer};
        fields = fields.concat(fieldstor.fields);
        return fields;
        #else
        return null;
        #end
    }
    
}
