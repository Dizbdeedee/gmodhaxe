package gmod.macros;

import gmod.macros.InitMacro;
import sys.FileSystem;
import haxe.iterators.StringKeyValueIteratorUnicode;
import haxe.rtti.CType.Classdef;
import haxe.macro.Type.Ref;
import sys.io.File;
import haxe.macro.Type.ClassType;
#if (macro)
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
class SentMacro {
    static var generate:Array<Generate> = [];
    static var onGenerate = false;

    static function getSuperType(cls:ClassType) {
        var refGet = cls.superClass.t.get();
        if (refGet.isExtern) {
            return cls.superClass;
        } else {
            return getSuperType(refGet);
        }
    }

    public static function build():Array<Field> {
        var cls = Context.getLocalClass().get();
        var type = Context.toComplexType(Context.getLocalType());
        var fields = Context.getBuildFields();
        var overridename;
        if (cls.meta.has(":expose")) {
            var param = cls.meta.extract(":expose")[0].params[0];
            switch(param.expr) {
                case EConst(c):
                    switch (c) {
                        case CString(s, kind):
                            overridename = s;
                        default:
                    
                    }
                default:
            }
        } else {
            overridename = cls.name;
        }
        var _ent =  Context.getType("gmod.types.Entity");
        var entType = Context.toComplexType(_ent);
        var fOverride:Array<Field> = [];
        var exprBuffer = macro {}
        for (field in fields) {
            if (field.access.indexOf(AOverride) > -1) {
                fOverride.push(field);
                
            }
        }
        var curEnt:FunctionArg = {
            name : "curEnt",
            type : entType,
        }
        var constructerFunc:Function = {
            args: [curEnt],
            expr : macro {Reflect.setField(this,"self",curEnt);},
            ret : null,
        }

        var self:Field = {
            name : "self",
            kind : FProp("default","never",entType),
            pos : Context.currentPos()
        }
        fields.push(self);
        fields.push({
            name : "new",
            pos : Context.currentPos(),
            kind : FieldType.FFun(constructerFunc),
            access : [Access.APrivate]
        });
        var genName;
        if (!cls.meta.has(":expose")) {
            var newname = '${cls.name}';
            cls.meta.add(":expose",[macro $v{cls.name}],Context.currentPos());
            genName = newname.toLowerCase();
        } else {
            var expr = cls.meta.extract(":expose")[0].params[0];
            switch (expr.expr) {
                case EConst(CString(s, _)):
                    genName = s.toLowerCase();
                default:
                    genName = cls.name.toLowerCase();
            }
        }
        var field = cls.findField("TYPE",true);
        var entLuaType = switch (field.expr().expr) {
            case TConst(TString(s)):
                s;
            default:
                throw "no TYPE for ENT definition";
        }
        generate.push({genName : genName,entLuaType : entLuaType,funcs : fOverride});
        if (!onGenerate) {
            Context.onAfterGenerate(afterGenerate);
        }
        cls.meta.add(":keep",[],Context.currentPos());
        return fields;
    }
    
    static function afterGenerate() {
        #if !display
        var baseStorage = InitMacro.baseEntFolder;
        if (baseStorage == null) {
            trace("no base storage");
            return;
        }
        var exportName = InitMacro.exportName;
        trace("generating entitity files");
        for (gen in generate) {
            var filebuf = new StringBuf();
            filebuf.add('ENT.Type = "${gen.entLuaType}"\n');
            filebuf.add('ENT.Base = "base_entity"\n');
            #if server
                filebuf.add("AddCSLuaFile(\"cl_init.lua\")\n");
            #end
            #if client
                filebuf.add('\nfunction ENT:Think(...)\n');
                filebuf.add('\tif (not self._gHaxeInit) then\n');
                filebuf.add('\t\tself._gHaxeBurrow:Initalize()\n');
                filebuf.add('\tend\n');
                filebuf.add('\tself._gHaxeBurrow:Think(...)\n');
                filebuf.add('end\n\n');
            #end
            filebuf.add('\nfunction ENT:Initialize(...)\n');
            filebuf.add('\tlocal ent = $exportName.${gen.genName}.new(self)\n');
            filebuf.add("\tself._gHaxeBurrow = ent\n");
            filebuf.add("\tself._gHaxeBurrow:Initialize()\n");
            #if client
                filebuf.add("\tself._gHaxeInit = true\n");
            #end
            filebuf.add('end\n\n');
            for (field in gen.funcs) {
                switch (field.name) {
                    case "Initialize": 
                        continue;               
                    #if client
                    case "Think":
                        continue;
                    #end
                    default:
                }
                filebuf.add('function ENT:${field.name}(...)\n');
                filebuf.add('\tself._gHaxeBurrow:${field.name}(...)\n');
                filebuf.add('end\n\n');
            }
            FileSystem.createDirectory('$baseStorage/entities/${gen.genName}');
            #if client
                File.saveContent('$baseStorage/entities/${gen.genName}/cl_init.lua',filebuf.toString());
            #elseif server
                File.saveContent('$baseStorage/entities/${gen.genName}/init.lua',filebuf.toString());
            #end
        }
        #end
    }
}

#end