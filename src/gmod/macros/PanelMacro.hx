package gmod.macros;

import haxe.macro.Compiler;
import haxe.macro.CompilationServer;
#if (macro)
import haxe.macro.Type.ClassType;
using StringTools;
import haxe.macro.Type.ClassField;
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools.ExprArrayTools;
using haxe.macro.MacroStringTools;
using haxe.macro.Tools;

private typedef Generate = {
    genName : String,
    entLuaType : String,
    funcs : Array<Field>,
}
#end

private enum MType {
    Panel;
    Sent;
    Gamemode;
    Swep;
    Effect;
}

class PanelMacro {
    #if macro
    static var generate:Map<String,Bool> = [];

    static var onGenerate = false;

    static var multireturnMap:Map<String,ComplexType> = [];

    static function classFieldToField(x:ClassField):Field {
        return {
            name: x.name,
            kind: FieldType.FVar(Context.toComplexType(x.type)),
            pos: Context.currentPos(),
            doc : x.doc,
        }
    }

    static function generateMultiReturn(cls:ClassType):ComplexType {
        var name = cls.name;
        if (multireturnMap.exists(name)) return multireturnMap.get(name);
        var anon:TypeDefinition = {
        pack: [],
        name: 'A_$name',
        pos: Context.currentPos(),
        kind: TypeDefKind.TDStructure,
        fields : []
        }
        var fieldArray = [];
        for (clsfield in cls.fields.get()) {
            fieldArray.push(classFieldToField(clsfield));
        }
        anon.fields = fieldArray;
        var complextype = TPath({pack : ["gmod"],name : "HaxeMultiReturn",
                    params : [TPType(TPath({pack : [],name : 'A_$name'})) ]});
        multireturnMap.set(cls.name,complextype);
        generates.set('A_$name',anon);
        return complextype;
    }

    @:allow(PanelMacroOverride)
    static function getSuperFields2(c:ClassType):Map<String,ClassField> {
        var superFields = [];
        var curClass = c;
        var map:Map<String,ClassField> = [];
        for (i in 0...10) {
            var superC = curClass.superClass;
            var fields = curClass.fields.get();
            superFields.push(fields);
            if (superC != null) {
                curClass = superC.t.get();
            } else {
                break;
            }
        }
        for (fieldAr in superFields) {
            for (field in fieldAr) {
                if (!map.exists(field.name)) {
                    map.set(field.name,field);
                }
            }
        }
        return map;

    }

    static function argToFuncArg(x:{name: String,opt : Bool,t: haxe.macro.Type}):FunctionArg {
        var arg:FunctionArg = {
            name: x.name,
            opt: x.opt,
            type : Context.toComplexType(x.t)
        }
        return arg;
    }

    public static function cleanClassFuncToField(x:ClassField):Field {
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
                throw "unhandled yet...";
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
            access: []
        }
        return field;
    }
    static function classVarToField(x:ClassField):Field {
        return switch (x.expr()) {
        case null:
            null;
        case {expr : TConst(TString(s))}:
            {
            name : x.name,
            kind : FVar(x.type.toComplexType(),macro $v{s}),
            pos : Context.currentPos(),
            access : [Access.AStatic,Access.AInline]
            };
        default:
            throw "hmm";
        };
    }
    static function classFuncToField(x:ClassField):Field {
        var _args:Array<FunctionArg> = [];
        var exprArgs = [];
        var _ret:haxe.macro.Type;
        switch x.type {
            case TFun(args, ret):
                exprArgs = [];    
                for (arg in args) {
                    _args.push(argToFuncArg(arg));
                    exprArgs.push(macro $i{arg.name});
                }
                _ret = ret;
            case y:
                trace(x);
                throw "unhandled yet...";
        }
        var name = x.name;
        var isHook = x.meta.has(":hook");
        var func:Function = switch (_ret) {
            case TAbstract(_.get().name => "Void", params):
                var expr;    
                if (isHook) {
                    expr = null;  // macro {}
                } else {
                    return null;
                }
                {   
                    args : _args,
                    ret :  Context.toComplexType(_ret),
                    expr : expr
                };
            case TInst(_.get() => luaMR = {name : n} , _) if (isHook && n.endsWith("Return")):
                {
                    args : _args,
                    ret : generateMultiReturn(luaMR),
                    expr :null
                }
            default:
                var expr;    
                if (isHook) {
                    expr = null; //macro return null
                } else {
                    return null;
                }
                {
                    args : _args,
                    ret :  Context.toComplexType(_ret),
                    expr : expr
                };
        }
        var access:Array<Access> = switch (isHook) {
            case false:
                [Access.AFinal,Access.APublic]; //add override here if we revert...
            default:
                [];
        }
        var field:Field = {
            kind : FieldType.FFun(func),
            name : x.name,
            pos : Context.currentPos(),
            doc : x.doc,
            access: access
        }
        return field;
    }
    static var x = 0;
    static function generateNewClass(cls:ClassType,mType:MType,first=false) {
        var super;
        var extendname;
        var newCls;
        var clsname = 'PanelHelper_${cls.name}';
        switch (cls.superClass) {
        case null:
            extendname = null;
            newCls = macro class $clsname {//extends panelhelper
                
            }
        case {t: _.get() => superType}:
            if (!generate.exists(superType.name)) {
                generateNewClass(superType,mType);
            }
            extendname = 'PanelHelper_${superType.name}';
            var path:TypePath = {pack : [],name : extendname,params: [TPType((macro : T))]};
            newCls = macro class $clsname extends $path {
            }
        }
        newCls.meta.push({
            name: ":PanelHelper",
            pos: Context.currentPos()
        });
        newCls.isExtern = true;
        var rpPack = cls.pack.copy();
        rpPack.push(cls.name);
        var newarray = [];
        for (str in rpPack) {
           newarray.push(macro $v{str});
        }
        newCls.meta.push({
            name: ":RealPanel",
            pos: Context.currentPos(),
            params: [macro $a{newarray}]
        });
        newCls.meta.push({
            name : ":native",
            pos : Context.currentPos(),
            params: [macro '{} or a'] //change to x if dump=pretty
        });
        newCls.params = [{name: "T",constraints: [TPath({pack : cls.pack,name : cls.name})]}];
        for (clsfield in cls.fields.get().concat(cls.statics.get())) {

            switch (clsfield.kind) {
            case FMethod(_):
                var newfield = classFuncToField(clsfield);
                if (newfield != null) {
                    newCls.fields.push(newfield);
                }
            case FVar(_,_):

                var newfield = classVarToField(clsfield);
                if (newfield != null) {
                    newCls.fields.push(newfield);
                }
            }
        }
        if (first) {
            newCls.meta.push({
                name: ":autoBuild",
                pos: Context.currentPos(),
                params: switch (mType) {
                    case Panel:
                        [macro gmod.macros.PanelMacroOverride.build()];
                    case Gamemode:
                        [macro gmod.macros.GamemodeMacro.build()];
                    case Sent:
                        [macro gmod.macros.SentMacro.buildSent()];
                    case Swep:
                        [macro gmod.macros.SentMacro.buildSwep()];
                    case Effect:
                        [macro gmod.macros.SentMacro.buildEffect()];
                    },
            });
        }
        generates.set('PanelHelper_${cls.name}',newCls);
        if (!generated) {
            Context.onTypeNotFound(callback);
            generated = true;
        }
        generate.set(cls.name,true);
    }

    static var generates:Map<String,haxe.macro.Expr.TypeDefinition> = [];

    static var generated = false;

    static function callback(x:String) {
        return generates.get(x);
    }

    static function build(x:MType):ComplexType {
        var type = Context.getLocalType();
        var cls = switch (type) {
            case TInst(_,[TInst(_.get() => c,_)])://
                c;
            default:
                trace("Couldn't find this panel");
                return null;
        }
        generateNewClass(cls,x,true);
        var tp2:TypePath = {pack : cls.pack,name : cls.name}
        var tp:TypePath = {pack : [],name : 'PanelHelper_${cls.name}',params : 
        [TPType(TPath(
           tp2 
        ))]} 
        var rtn = TPath(tp);
        return rtn; 
    }

    public static function buildGamemode():ComplexType {
        return build(Gamemode);
    }

    public static function buildSent():ComplexType {
        return build(Sent);
    }

    public static function buildPanel():ComplexType {
        return build(Panel);
    }

    public static function buildSwep():ComplexType {
        return build(Swep);
    }

    public static function buildEffect():ComplexType { //?
        return build(Effect);
    }

    #end
}

