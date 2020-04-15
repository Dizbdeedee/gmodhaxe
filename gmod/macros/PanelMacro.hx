package gmod.macros;

#if (macro)
import haxe.macro.Type.ClassType;
import haxe.macro.Type.ClassField;
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools.ExprArrayTools;

private typedef Generate = {
    genName : String,
    entLuaType : String,

    funcs : Array<Field>,
}
#end
class PanelMacro {
    #if macro
    static var generate:Map<String,Bool> = [];
    static var onGenerate = false;
    
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

    static function classFuncToField(x:ClassField):Field {
        
        var _args:Array<FunctionArg> = [];
        var exprArgs = [];
        var _ret:haxe.macro.Type;
        switch (x.type) {
            case TFun(args, ret):
                exprArgs = [];    
                for (arg in args) {
                    _args.push(argToFuncArg(arg));
                    exprArgs.push(macro $i{arg.name});
                }
                
                _ret = ret;
            default:
                throw "unhandled yet...";
        }
        var name = x.name;
        var isHook = x.meta.has(":hook");
        var func:Function = switch (_ret) {
            case TAbstract(_.get().name => "Void", params):
                var expr;    
                if (isHook) {
                    // expr = macro return untyped self.$name($a{exprArgs});
                    
                    expr = macro {}
                } else {
                    return null;
                    // expr = macro self.$name($a{exprArgs});
                }
                {   
                    args : _args,
                    ret :  Context.toComplexType(_ret),
                    expr : expr
                };
            default:
                var expr;    
                if (isHook) {
                    expr = macro return null;
                    // expr = macro return untyped self.$name($a{exprArgs});
                } else {
                    return null;
                    // expr = macro return self.$name($a{exprArgs});
                }
                {
                    args : _args,
                    ret :  Context.toComplexType(_ret),
                    expr : expr
                };
        }
        if (isHook) {

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
    static function generateNewClass(cls:ClassType) {
        if (generate.exists(cls.name)) {return;}
        var super;
        var extendname;
        var newCls;
        var clsname = 'PanelHelper_${cls.name}';
        switch (cls.superClass) {
        case null:
            extendname = null;
            newCls = macro class $clsname extends gmod.macros.PanelHelper<T> {
                
            }

        case {t: _.get() => superType}:
            if (!generate.exists(superType.name)) {
                generateNewClass(superType);
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


        
        var pack = switch (cls.name) {
            case "Panel":
                "gclass";
            default:
                "panels";
        }
        newCls.params = [{name: "T",constraints: [TPath({pack : ["gmod",pack],name : cls.name})]}];
        for (clsfield in cls.fields.get()) {
            switch (clsfield.kind) {
            case FMethod(_):
                var newfield = classFuncToField(clsfield);
                if (newfield != null) {
                    newCls.fields.push(newfield);
                } 
            default:
            }
        }
        Context.defineType(newCls);
        generate.set(cls.name,true);
        
    }
    public static function build():ComplexType {
        var type = Context.getLocalType(); 
        var cls;
        switch (type) {
            case TInst(_,[TInst(_.get() => c,_)])://
                // trace(c);
                cls = c;
            default:
                trace("Couldn't find this panel");
                return null;
        }
        generateNewClass(cls);
        
        // return (macro : PanelHelper_)
        var tp2:TypePath = {pack : ["gmod","panels"],name : cls.name}
        var tp:TypePath = {pack : [],name : 'PanelHelper_${cls.name}',params : 
        [TPType(TPath(
           tp2 
        ))]} 
        var rtn = TPath(tp);
        return rtn; 
    }
    #end
}

