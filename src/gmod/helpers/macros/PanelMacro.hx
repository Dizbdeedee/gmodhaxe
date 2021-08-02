package gmod.helpers.macros;

import haxe.ds.BalancedTree;
import gmod.helpers.macros.Util.typeExists;
import gmod.helpers.macros.Util.arrToTypePath;
import gmod.helpers.macros.Util.arrToTypePath;
import gmod.helpers.macros.Util.arrToTypePath;
import haxe.macro.Type.TypedExpr;
import haxe.macro.Compiler;
import haxe.macro.CompilationServer;
#if (macro)
import haxe.macro.Type.ClassType;
using StringTools;
import haxe.macro.Type.ClassField;
import haxe.macro.Context;
import haxe.macro.Expr;
import gmod.helpers.macros.Util.TypePathHelper;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools.ExprArrayTools;
using haxe.macro.MacroStringTools;
using haxe.macro.Tools;
using Lambda;

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

typedef GenerateGmod = {
    target : ClassType,
    targetFields : Array<Field>,
    gmodParent : TypePathHelper,
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
        final name = cls.name;
        if (multireturnMap.exists(name)) return multireturnMap.get(name);
        final anon:TypeDefinition = {
            pack: [],
            name: 'A_$name',
            pos: Context.currentPos(),
            kind: TypeDefKind.TDStructure,
            fields : []
        }
        final fieldArray = cls.fields.get().map(classFieldToField);
        anon.fields = fieldArray;
        var complextype = TPath({pack : ["gmod","helpers"],name : "HaxeMultiReturn",
                    params : [TPType(TPath({pack : [],name : 'A_$name'})) ]});
        multireturnMap.set(cls.name,complextype);
        generatedStorage.set('A_$name',anon);
        return complextype;
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

    static function shouldProcessClassFunc(classField:ClassField) {
        return classField.meta.has(":hook");
    }

    static function shouldProcessClassVar(classField:ClassField) {
        return classField.expr() != null;
    }

    static function classFuncToField(classField:ClassField):Field {
        var funcArgs:Array<FunctionArg> = [];
        var exprArgs = [];
        var funcReturn:haxe.macro.Type;
        switch classField.type {
            case TFun(args, ret):
                exprArgs = [];    
                funcArgs = args.map(argToFuncArg);
                exprArgs = args.map((arg) -> macro $i{arg.name});
                funcReturn = ret;
            case y:
                trace(classField);
                throw "unhandled yet...";
        }
        final name = classField.name;
        final func:Function = switch (funcReturn) {
            case TInst(_.get() => luaMR = {name : n} , _) if (n.endsWith("Return")):
                {
                    args : funcArgs,
                    ret : generateMultiReturn(luaMR),
                    expr :null
                }
            case ret:
                {
                    args : funcArgs,
                    ret :  Context.toComplexType(ret),
                    expr : null
                };
        }
        return {
            kind : FieldType.FFun(func),
            name : classField.name,
            pos : Context.currentPos(),
            doc : classField.doc,
            access: if (!classField.isPublic) [Access.APrivate] else [] //always a hook so mneh
        };
    }

    static function genGmodExtFields(field:Field):Field {
        final newKind = switch (field.kind) {
            case FFun(f):
                FFun({
                    args : f.args,
                    params: f.params,
                    ret: f.ret,
                    expr : null
                });
            case FVar(t, e):
                FVar(t,null);
            case FProp(get, set, t, e):
                FProp(get,set,t,null);
        }
        return {
            kind : newKind,
            doc: field.doc,
            meta: field.meta,
            name: field.name,
            pos: Context.currentPos(),
            access: []
        }
    }

    public static function generateGmodSideExtern(gen:GenerateGmod):haxe.macro.Type {
        final target = gen.target;
        final targetFields = gen.targetFields;
        final targetGmod = gen.gmodParent;
        final gmodExternName = '_Gmod${target.name}';
        final linkExternName = 'Gmod${target.name}';
        final curMod:TypePathHelper = Context.getLocalModule().split(".");        
        
        // final linkedDerka = TPath({pack : [], name : gmodExternName});
        final parentPath:TypePath = targetGmod;
        if (typeExists(gmodExternName) || typeExists(linkExternName) ) { //|| typeExists(linkExternName)) {
            return Context.getType(linkExternName);
        }
        final gmodExtern:TypeDefinition = macro class $gmodExternName extends $parentPath {

        };

        gmodExtern.pack = [];
        var fields = targetFields.filter((f) -> 
            f.meta.exists((m) -> m.name == ":exposeGmod"));
        final newFields = fields.map(genGmodExtFields);
        gmodExtern.fields = newFields;
        gmodExtern.isExtern = true;
        trace(gmodExtern.pack);

        trace("generating...");
        Context.defineType(gmodExtern);
        trace("generating link...");
        final gmodType = Context.getType(gmodExternName).toComplexType();
        final otherType = Context.getLocalType().toComplexType();
        final linkType = (macro : gmod.helpers.GLinked<$gmodType,$otherType>);
        Context.defineType({
            pack: [],
            name: linkExternName,
            pos: Context.currentPos(),
            kind: TDAlias(linkType),
            fields: []
        });
        trace("generated");
        if (!typeExists(gmodExternName) || !(typeExists(linkExternName))) {
            throw "Oh haahaa.....";
        }
        return Context.getType(linkExternName);
    }

    

    static function generateHaxeSideExtern(cls:ClassType,mType:MType,first=false) {
        var extendname;
        var newCls;
        var clsname = 'HaxeGenExtern_${cls.name}';
        switch (cls.superClass) {
            case null:
                extendname = null;
                newCls = macro class $clsname {//extends HaxeGenExtern
                    
                }
            case {t: _.get() => superType}:
                if (!generate.exists(superType.name)) {
                    generateHaxeSideExtern(superType,mType);
                }
                extendname = 'HaxeGenExtern_${superType.name}';
                var path:TypePath = {pack : [],name : extendname};
                newCls = macro class $clsname extends $path {
                }
        }
        newCls.isExtern = true;
        var rpPack = cls.pack.concat([cls.name]);
        var newarray = rpPack.map((str) -> macro $v{str});
        newCls.meta = newCls.meta.concat([{
            name: ":RealExtern",
            pos: Context.currentPos(),
            params: [macro $a{newarray}]
        },{
            name : ":native",
            pos : Context.currentPos(),
            params: [macro '{} or a'] //{prototype = {}} does not work... we've gone over this
        },{
            name: ":HaxeGenExtern",
            pos: Context.currentPos()
        }]);
        // newCls.params = [{name: "T",constraints: [TPath({pack : cls.pack,name : cls.name})]}];
        newCls.fields = [
            for (clsField in cls.fields.get().concat(cls.statics.get()))
                if (clsField.kind.match(FMethod(_)) && shouldProcessClassFunc(clsField)) {
                    classFuncToField(clsField);
                } else if (clsField.kind.match(FVar(_,_)) && shouldProcessClassVar(clsField)) {
                    classVarToField(clsField);
                }
        ];
        if (first) {
            newCls.meta.push({
                name : ":autoBuild",
                pos : Context.currentPos(),
                params : [macro Macros.generateAll()]
            });
            // newCls.meta.push({
            //     name: ":autoBuild",
            //     pos: Context.currentPos(),
            //     params: switch (mType) {
            //         case Panel:
            //             [macro gmod.helpers.macros.PanelMacroOverride.build()];
            //         case Gamemode:
            //             [macro gmod.helpers.macros.GamemodeMacro.build()];
            //         case Sent:
            //             [macro gmod.helpers.macros.SentMacro.buildSent()];
            //         case Swep:
            //             [macro gmod.helpers.macros.SentMacro.buildSwep()];
            //         case Effect:
            //             [macro gmod.helpers.macros.SentMacro.buildEffect()];
            //         },
            // });
        }
        generatedStorage.set('HaxeGenExtern_${cls.name}',newCls);
        generate.set(cls.name,true);
    }

    static var generatedStorage:Map<String,haxe.macro.Expr.TypeDefinition> = [];

    static var generated = false;

    static function enableNotFound() {
        if (!generated) {
            Context.onTypeNotFound((clsName) -> {
                return if (generatedStorage.exists(clsName)) {
                    trace('Retrieved $clsName');
                    generatedStorage.get(clsName);
                } else {
                    null;
                }
            });
            generated = true;
        }
    }

    static function build(x:MType):ComplexType {
        enableNotFound();
        var type = Context.getLocalType();
        var cls = switch (type) {
            case TInst(_,[TInst(_.get() => c,_)])://
                c;
            default:
                trace("Couldn't find this panel");
                return null;
        }
        generateHaxeSideExtern(cls,x,true);
        var tp2:TypePath = {pack : cls.pack,name : cls.name}
        var tp:TypePath = {pack : [],name : 'HaxeGenExtern_${cls.name}'} 
        var rtn = TPath(tp);
        return rtn; 
    }

    public static function build2(panel:ClassType):ComplexType {
        enableNotFound();
        generateHaxeSideExtern(panel,Panel,true);
        var tp2:TypePath = {pack : panel.pack,name : panel.name}
        var tp:TypePath = {pack : [],name : 'HaxeGenExtern_${panel.name}'} 
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

