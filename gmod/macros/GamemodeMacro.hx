package gmod.macros;

#if (macro)

import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.ExprTools.ExprArrayTools;

class GamemodeMacro {
    public static function build():Array<Field> {
        var fields = Context.getBuildFields(); 
        var cls = Context.getLocalClass().get();
        var type = Context.getLocalType();
        var complextype = Context.toComplexType(type);
        var inst = haxe.macro.Type.TInst(cls.superClass.t,cls.superClass.params);
        var superType = Context.toComplexType(inst);
        var exprBuffer:Array<Expr> = [];
        for (field in fields) {
            switch (field.kind) {
                case FFun(f):
                    if (field.access.indexOf(Access.AOverride) > -1) {
                        field.access.remove(Access.APublic);
                        var name = field.name;
                        var str = '{0}.$name = function(GM,...) return {1}:$name(...) end';
                        exprBuffer.push(macro untyped __lua__($v{str},self,this));
                    }
                default:

            }
        }
        var constructer:Function = {
            args : [{name : "self",
                    type : superType
            }],
            ret : null,
            expr : macro $b{exprBuffer}
        }
        var newField:Field = {
            name:"new",
            access:[Access.APublic],
            kind : FieldType.FFun(constructer),
            pos : Context.currentPos()
        }
        fields.push(newField);
        var curClass = switch (complextype) {
            case TPath(p):
                p;
            default:
                throw "";
                null;
        }
        var ename = cls.name;
        var initGameFunc:Function = {
            expr : macro {
                var GM = untyped __lua__("GM");
                var inst = new $curClass(GM);
                Reflect.setField($i{ename},"GAMEMODE",inst);
                return inst;
            },
            args : [],
            ret: complextype,
        }
        var initGameField:Field = {
            name : "initaliseGamemode",
            kind : FieldType.FFun(initGameFunc),
            access: [Access.APublic,Access.AStatic],
            pos : Context.currentPos(),
            doc : "Initalises the gamemode, so you can access your gamemode via the GAMEMODE var\n\nThe current gamemodes hooks will be overriden when this method is called"    
        }
        var gamemodeField:Field = {
            name : "GAMEMODE",
            access:[Access.APublic,Access.AStatic],
            kind :FieldType.FProp("default","never",complextype),
            pos : Context.currentPos(),
            doc : "Current gamemode. Make sure to intialise using gamemodetools first!"
        }
        fields.push(initGameField);
        fields.push(gamemodeField);
        cls.meta.add(":keep",[],Context.currentPos());
        return fields;
    }
}
#end