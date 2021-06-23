package gmod.helpers.macros;

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
                    if (field.access.indexOf(Access.AOverride) > -1
                        || field.meta.filter(f -> f.name == ":exposeGM").length > 0
                        ) {
                        var name = field.name;
                        var str = 'GM.$name = function(GM,...) return {0}:$name(...) end';
                        exprBuffer.push(macro untyped __lua__($v{str},this));
                    }
                default:
            }
        }
        var superClass = cls.superClass.t.get();
        if (superClass.meta.has("gamemodeName")) {
            var supername = superClass.meta.extract("gamemodeName")[0].params[0].getValue();
            exprBuffer.push(macro Gmod.DeriveGamemode($v{supername}));
        }
        exprBuffer.push(macro self = untyped __lua__("GM"));
        exprBuffer.push(macro untyped instance = this);
        var constructer:Function = {
            args : [],
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
        var self:Field = {
            name : "self",
            access:[Access.AFinal],
            kind : FieldType.FVar(superType),
            pos : Context.currentPos(),
            doc : "Underlying gamemode table"
        }
        var curInstance:Field = {
            name : "instance",
            doc : "Currently active instance of haxe gamemode object",
            access : [Access.APublic,Access.AStatic],
            kind : FieldType.FProp("default","never",complextype),
            pos : Context.currentPos()
        }
        fields.push(self);
        fields.push(curInstance);
        cls.meta.add(":keep",[],Context.currentPos());
        return fields;
    }
}
#end
