package gmod.helpers.macros;



#if (macro)

import haxe.macro.Context;
import haxe.macro.Expr;
import gmod.helpers.macros.Util;
using haxe.macro.ExprTools;
using haxe.macro.ExprTools.ExprArrayTools;
using haxe.macro.ComplexTypeTools;
using haxe.macro.TypeTools;
using Lambda;

class GamemodeMacro {

    static function shouldExpose(name:String) {
        return name == ":exposeGM" || name == ":exposeGmod" || name == ":hook";
    }

    public static function build():Array<Field> {
        PanelMacro.enableNotFound();
        var fields = Context.getBuildFields();
        var cls = Context.getLocalClass().get();
        if (!Context.defined("gamemode")) {
            Context.warning("Attempt to generate a gamemode without -D gamemode defined",cls.pos);
            return null;
        }
        var gamemodeName = Context.definedValue("gamemode");
        var type = Context.getLocalType();
        var complextype = Context.toComplexType(type);
        var inst = haxe.macro.Type.TInst(cls.superClass.t,cls.superClass.params);
        var superType = Context.toComplexType(inst);
        var exprBuffer:Array<Expr> = [];
        var superClass = cls.superClass.t.get();
        final resultGClass = findMeta(superClass,":gamemodeName");
        final base = switch (resultGClass) {
            case null:
                Context.warning("Could not intepret gamemodeName meta",cls.pos);
                "null";
            case {params : [{expr: EConst(CString(s, _))}]}:
                s;
            default:
                Context.warning("Could not intepret gamemodeName meta",cls.pos);
                "null";
        }
        if (base != "null") {
            exprBuffer.push(macro gmod.Gmod.DeriveGamemode($v{base}));
        }
        var gmodParent = extractGmodParent(superClass);
        var gen = PanelMacro.generateGmodSideExtern({
            target: cls,
            targetFields: fields,
            gmodParent: gmodParent,
            markExpose: shouldExpose
        });
        var gmodType = gen.link;
        var propertiesDefined = false;
        var newExpr = [];
        for (field in fields) {
            if (field.name == "new") {
                switch (field.kind) {
                    case FFun({expr: {expr : EBlock(exprs)}}):
                        newExpr = exprs;
                    default:
                        Context.error("GamemodeMacro: Invalid new function structure",Context.currentPos());
                }
            }
            switch (field.kind) {
                case FVar(_, e) if (field.name == "properties"):
                    if (!field.access.contains(Access.AStatic)) {
                        Context.error("Properties must be static!",field.pos);
                        return null;
                    }
                    if (!field.access.contains(Access.AFinal)) {
                        field.access.push(AFinal);
                    }
                    field.kind = FVar(Context.getType("gmod.helpers.gamemode.GMBuild.GamemodeFields").toComplexType(),e);
                    propertiesDefined = true;

                case FFun(f):
                    if (field.access.contains(AOverride) || field.meta.exists(f -> shouldExpose(f.name))) {
                        var name = field.name;
                        var str = 'GM.$name = function(GM,...) return {0}:$name(...) end';
                        exprBuffer.push(macro untyped __lua__($v{str},this));
                        getDocsFromParent(field,superClass);
                    }


                default:
            }
        }
        if (!propertiesDefined) {
            fields.push({name: "properties",access: [AFinal,AStatic],pos: Context.currentPos(), kind: FVar(macro : {}, macro null)});
        }
        exprBuffer = exprBuffer.concat(blockToExprArr(macro {
            self = untyped __lua__("GM");
            untyped instance = this;
            if (properties != null) {

                for (ind in Reflect.fields(properties)) {
                    Reflect.setField(self,ind,Reflect.field(properties,ind));
                }

            }
        }));
        exprBuffer = exprBuffer.concat(newExpr);
        final fieldStore = macro class {

            public static inline final gclass:String = $v{gamemodeName}; //

            public static var instance(default,never):$gmodType;

            final self:$gmodType;

            public function get_self():$gmodType {
                return cast self;
            }

            // public final function new() $b{exprBuffer}

        }
        fields.iter((f) -> {
            switch (f) {
                case {name : "new", kind : FFun(func = {expr : e})}:
                    func.expr = {expr: EBlock(exprBuffer), pos: Context.currentPos()};
                default:
            }
        });

        cls.meta.add(":keep",[],Context.currentPos());
        return fields.concat(fieldStore.fields);
    }
}
#end
