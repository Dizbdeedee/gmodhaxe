package gmod.macros;

#if (macro)
import gmod.macros.InitMacro;
import sys.FileSystem;
import sys.io.File;
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;

private typedef Generate = {
    genName : String,
    ?entLuaType : String,
    funcs : Array<Field>,
    properties : {},
    weapon : Bool,
    effect : Bool,
    overridenInit : Bool,
    overridenThink : Bool
}


class SentMacro {

    static var generate:Array<Generate> = [];
    static var onGenerate = false;
    public static function build(?weapon:Bool=false,?effect:Bool=false):Array<Field> {
        switch [effect,Context.defined("server")] {
            case [true,true]:
                throw "Effects aren't on the server...";
            default:
        }
        var properties = null;
        var cls = Context.getLocalClass().get();
        var type = Context.toComplexType(Context.getLocalType());
        var fields = Context.getBuildFields();
        var overridename;
        var overridenInit = false;
        var overridenThink = false;
        
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
        var _ent = cls.findField("self");
        if (_ent == null) {
            throw "No self found";
        }
        var entType = Context.toComplexType(_ent.type);
        var fOverride:Array<Field> = [];
        var exprBuffer = macro {}
        for (field in fields) {
            switch [field.name,field.kind] {
                case ["properties",FVar(_, e)]:
                    try {
                        properties = e.getValue();
                    } catch (x:Dynamic) {
                        trace("Unable to get the value of properties");
                        return null;
                    }
                case [name,FFun(f)]:
                    switch (field.access) {
                        case [Access.AStatic]:
                        case [Access.AOverride]:
                            switch name {
                            case "Initialize" | "Init":
                                overridenInit = true;
                            case "Think":
                                overridenThink = true;
                            }
                            fOverride.push(field);
                        default:
                            if (field.meta.filter((f) -> return f.name == ":entExpose").length > 0) {
                                fOverride.push(field);
                            }
                    }
                default:
            }
        }
        if (properties == null && effect == false) {
            trace("No ent propeties found");
            return null;
        }

        var curEnt:FunctionArg = {
            name : "curEnt",
            type : entType,
        }
        var constructerFunc:Function = {
            args: [curEnt],
            expr : macro {untyped self = curEnt;},
            ret : null,
        }
        fields.push({
            name : "new",
            pos : Context.currentPos(),
            kind : FieldType.FFun(constructerFunc),
            access : [Access.APrivate]
        });
        var genName;
        if (!cls.meta.has(":expose")) {
            var newName = '${cls.name.toLowerCase()}';
            cls.meta.add(":expose",[macro $v{newName}],Context.currentPos());
            genName = newName;
        } else {
            var expr = cls.meta.extract(":expose")[0].params[0];
            switch (expr.expr) {
                case EConst(CString(s, _)):
                    genName = s.toLowerCase();
                default:
                    genName = cls.name.toLowerCase();
            }
        }
        var entLuaType;
        switch ([weapon,effect]) {
        case [false,false]:
            var type = cls.findField("TYPE");
            entLuaType = switch (type.expr().expr) {
                case TConst(TString(s)):
                    s;
                default:
                    throw "no TYPE for ENT definition";
            }
        default:
        }
        generate.push({
            genName : genName,
            entLuaType : entLuaType,
            funcs : fOverride,
            properties : properties,
            weapon:weapon,
            effect:effect,
            overridenThink: overridenThink,
            overridenInit: overridenInit
        });
        if (!onGenerate) {
            Context.onAfterGenerate(afterGenerate);
            onGenerate = true;
        }
        cls.meta.add(":keep",[],Context.currentPos());
        return fields;
    }
    
    
    static function afterGenerate() {
        var baseStorage = InitMacro.baseEntFolder;
        if (baseStorage == null) {
            trace("no base storage to generate entity lua files");
            return;
        }
        
        var exportName = InitMacro.exportName;
        for (gen in generate) {
            var baseIdent:String;
            var _baseStorage:String;
            switch [gen.weapon,gen.effect] {

            case [true,false]:
                _baseStorage = '$baseStorage/weapons';
                baseIdent = "SWEP";
            case [false,false]:
                _baseStorage = '$baseStorage/entities';
                baseIdent = "ENT";
            case [false,true]:
                _baseStorage = '$baseStorage/effects';
                baseIdent = "EFFECT";
            default:
                throw "enums didn't work....";
            }
            var filebuf = new StringBuf();
            var dyn:haxe.DynamicAccess<Dynamic> = cast gen.properties;
            function insertKV(key:String,val:Dynamic,?table = "") {
                if (Reflect.isObject(val) && Type.getClass(val) == null) {
                    filebuf.add('$key = {\n');
                    var structIterate:haxe.DynamicAccess<Dynamic> = val;
                    for (key_2 => val_2 in structIterate) {
                        insertKV(key_2,val_2,",");
                    }
                    filebuf.add('}$table\n');                    
                } else if (Std.is(val,String)) {
                    filebuf.add('$key = "$val"$table\n');
                } else {
                    filebuf.add('$key = $val$table\n');
                }
            }
            for (key => val in dyn) {
                insertKV('$baseIdent.$key',val);
            }
            switch [gen.weapon,gen.effect] {
            case [false,false]:
                filebuf.add('$baseIdent.Type = "${gen.entLuaType}"\n');
            default:
            }
            
            #if server
                filebuf.add("AddCSLuaFile(\"cl_init.lua\")\n");
            #end
            if (!gen.effect) {
                #if client
                    filebuf.add('\nfunction $baseIdent:Think()\n');
                    filebuf.add('\tif (not self._gHaxeInit) then\n');
                    filebuf.add('\t\tself:Initialize()\n');
                    filebuf.add('\tend\n');
                    if (gen.overridenThink) {
                        filebuf.add('\tself._gHaxeBurrow:Think()\n');
                    }
                    filebuf.add('end\n\n');
                #end
                filebuf.add('\nfunction $baseIdent:Initialize()\n');
                filebuf.add('\tlocal ent = $exportName.${gen.genName}.new(self)\n');
                filebuf.add("\tself._gHaxeBurrow = ent\n");
                if (gen.overridenInit) {
                    filebuf.add("\tself._gHaxeBurrow:Initialize()\n");
                }
                #if client
                    filebuf.add("\tself._gHaxeInit = true\n");
                #end
                filebuf.add('end\n\n');
            } else {
                filebuf.add('\nfunction $baseIdent:Init(...)\n');
                filebuf.add('\tlocal ent = $exportName.${gen.genName}.new(self)\n');
                filebuf.add("\tself._gHaxeBurrow = ent\n");
                if (gen.overridenInit) {
                    filebuf.add("\tself._gHaxeBurrow:Init(...)\n");
                }
                filebuf.add('end\n\n');
            }
            for (field in gen.funcs) {
                switch (field.name) {
                    case "Initialize": 
                        continue;
                    case "Init":
                        if (gen.effect) {
                            continue;
                        }
                    #if client
                    case "Think":
                        if (!gen.effect) {
                            continue;
                        }
                    #end
                    default:
                }
                filebuf.add('function $baseIdent:${field.name}(...)\n');
                filebuf.add('\tself._gHaxeBurrow:${field.name}(...)\n');
                filebuf.add('end\n\n');
            }
            FileSystem.createDirectory('$_baseStorage/${gen.genName}');
            #if client
            if (gen.effect) {
                File.saveContent('$_baseStorage/${gen.genName}/init.lua',filebuf.toString());
            } else {
                File.saveContent('$_baseStorage/${gen.genName}/cl_init.lua',filebuf.toString());
            }
            #elseif server
            File.saveContent('$_baseStorage/${gen.genName}/init.lua',filebuf.toString());
            #end
        }
    }
}

#end
