package gmod.helpers.macros;

import haxe.ds.BalancedTree;
import gmod.helpers.macros.Util;
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

typedef GmodExtern = {
    link : haxe.macro.Type,
    rawClass : haxe.macro.Type
}

typedef GenerateGmod = {
    target : ClassType,
    targetFields : Array<Field>,
    gmodParent : TypePathHelper,
    ?markExpose : (meta:String) -> Bool,
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
    
    static function shouldProcessClassFunc(classField:ClassField) {
        return classField.meta.has(":hook");
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
                Context.error("Unhandled classFuncToField",classField.pos);
                throw null;
        }
        final name = classField.name;
        final func:Function = switch (funcReturn) {
            case TInst(_.get() => luaMR = {name : n} , _) if (n.endsWith("Return")):
                {
                    args : funcArgs,
                    ret : generateMultiReturn(luaMR), 
                    expr : null
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
            access: if (!classField.isPublic) [Access.APrivate] else [], //always a hook so mneh,
            meta : classField.meta.get().concat([{
                name: ":inheritDoc",
                pos: Context.currentPos()
            }])
        };
    }

    static function shouldGenGmodExtField(field:Field):Bool {
        return switch (field.kind) {
            case FFun({args : args, ret : ret}) if (
                args.exists((a) -> a.type == null) || ret == null):
                Context.warning("Cannot generate field without full type annotations",field.pos);
                false;
            case FVar(null, _) 
            | FProp(_, _, null, _):
                Context.warning("Cannot generate field without full type annotations",field.pos);
                false;
            default:
                true;
        }
    }

    static function genGmodExtFields(field:Field,superType:ClassType):Field {
        final over = superType.findField(field.name) != null;
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
            access: if (over) [AOverride] else []
        }
    }

    public static function generateGmodSideExtern(gen:GenerateGmod):GmodExtern {
        if (gen.markExpose == null) gen.markExpose = (name) -> return name == ":exposeGmod";
        final target = gen.target;
        final targetFields = gen.targetFields;
        final targetGmod = gen.gmodParent;
        final gmodExternName = '_Gmod${target.name}';
        final linkExternName = 'Gmod${target.name}';
        final curMod:TypePathHelper = Context.getLocalModule().split(".");        
        final parentPath:TypePath = targetGmod;
        if (typeExists(gmodExternName) || typeExists(linkExternName) ) { 
            return {link : Context.getType(linkExternName), rawClass: Context.getType(gmodExternName)};
        }
        final gmodExtern:TypeDefinition = macro class $gmodExternName extends $parentPath {

        };
        gmodExtern.pack = [];
        var fields = targetFields.filter((f) -> 
            f.meta.exists((m) -> gen.markExpose(m.name)));
        final gmodSuperType = try {
            targetGmod.toComplexType().toType().getClass();
        } catch (e) {
            Context.error("Failed to get gmodSuperType",Context.currentPos());
            return null;
        }
        final newFields = [for (f in fields)
            
            if (shouldGenGmodExtField(f)) {
                genGmodExtFields(f,gmodSuperType);
            }
        ];
        gmodExtern.fields = newFields;
        gmodExtern.isExtern = true;
        Context.defineType(gmodExtern);
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
        if (!typeExists(gmodExternName) || !(typeExists(linkExternName))) {
            Context.error("Failed to generate gmod externs",gen.target.pos);
            return null;
        }
        return {
            link : Context.getType(linkExternName),
            rawClass : Context.getType(gmodExternName)
        }
    }

    

    static function generateHaxeSideExtern(cls:ClassType,mType:MType,first=false) {
        var extendname;
        var newCls;
        var clsname = 'HaxeGenExtern_${cls.name}';
        switch (cls.superClass) {
            case null:
                extendname = null;
                newCls = macro class $clsname {
                    
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
        newCls.meta = cls.meta.get();
        newCls.isExtern = true;
        var rpPack = cls.pack.concat([cls.name]);
        var newarray = rpPack.map((str) -> macro $v{str});
        newCls.meta = newCls.meta.concat([{
            name: ":RealExtern",
            pos: Context.currentPos(),
            params: [macro $a{newarray}]
        }
        ,{ 
            name : ":native",
            pos : Context.currentPos(),
            params: [macro '{} or a'] //{prototype = {}} does not work... we've gone over this
        }
        ,{
            name: ":HaxeGenExtern",
            pos: Context.currentPos()
        },{
            name: ":GmodClassName",
            pos : Context.currentPos(),
            params : [macro $v{cls.name}]
        }]);
        newCls.fields = [
            for (clsField in cls.fields.get().concat(cls.statics.get()))
                if (clsField.kind.match(FMethod(_)) && shouldProcessClassFunc(clsField)) {
                    classFuncToField(clsField);
                }
        ];
        if (first) {
            newCls.meta.push({
                name: ":autoBuild",
                pos: Context.currentPos(),
                params: switch (mType) {
                    case Panel:
                        [macro gmod.helpers.macros.PanelMacroOverride.build()];
                    case Gamemode:
                        [macro gmod.helpers.macros.GamemodeMacro.build()];
                    case Sent:
                        [macro gmod.helpers.macros.SentMacro.buildSent()];
                    case Swep:
                        [macro gmod.helpers.macros.SentMacro.buildSwep()];
                    case Effect:
                        [macro gmod.helpers.macros.SentMacro.buildEffect()];
                    },
            });
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

