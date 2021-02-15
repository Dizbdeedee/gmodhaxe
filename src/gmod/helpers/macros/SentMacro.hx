package gmod.helpers.macros;

#if (macro)
import gmod.helpers.macros.InitMacro;
import sys.FileSystem;
import sys.io.File;
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.TypedExprTools;

private typedef Generate = {
    genName : String,
    ?entLuaType : String,
    funcs : Array<Field>,
    properties : {},
    esent : ESent,
    overridenInit : Bool,
    overridenThink : Bool
}

private enum ESent {
    Sent;
    Swep;
    Effect;
}

class SentMacro {

    static var generate:Array<Generate> = [];

    static var onGenerate = false;

    static function build(esent:ESent):Array<Field> {
        var cls = Context.getLocalClass().get();
        if (cls.meta.has(":PanelHelper")) return null;
        switch [esent,Context.defined("server")] {
            case [Effect,true]:
                throw "Effects aren't on the server...";
            default:
        }
        var properties = null;
        var type = Context.toComplexType(Context.getLocalType());
        var fields = Context.getBuildFields();
        var superType = cls.superClass.t.get();
        var overridenInit = false;
        var overridenThink = false;
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
                    field.meta.push({
                        name: ":engineHook",
                        pos: Context.currentPos()
                    });
                    fOverride.push(field);
                default:
                    if (field.meta.filter((f) -> return f.name == ":entExpose").length > 0) {
                        fOverride.push(field);
                    }
                }
            default:
            }
        }
        switch [properties,esent] {
        case [null,Swep | Sent]:
            throw "No ent properties found";
        default:
        }
        var genName = switch (cls.meta.extract(":expose")) {
            case [{params : [{expr : EConst(CString(s,_))}]}]:
                final newName = s.toLowerCase();
		final name = InitMacro.entLuaStorage + "." + newName;
		cls.meta.remove(":expose");
                cls.meta.add(":expose",[macro $v{name}],Context.currentPos());
		newName;
            default:
                final newName = cls.name.toLowerCase();
		final name = InitMacro.entLuaStorage + "." + newName;
                cls.meta.add(":expose",[macro $v{name}],Context.currentPos());
                newName;
        }
        var entLuaType = switch (esent) {
        case Sent:
            var type = cls.findField("TYPE",true);
            switch (type) {
                case null:
                    trace("no TYPE for ENT definition");
                    return null;
                case _.expr() => {expr : TConst(TString(s))}:
                    s;
                default:
                    trace("no TYPE for ENT definition");
                    return null;
            }
        default:
            null;
        }
        var superexpr = superType.meta.extract(":RealPanel")[0].params[0];
        cls.meta.add(":FirstPanel",[],Context.currentPos());
        cls.meta.add(":RealPanel",[superexpr],Context.currentPos());
        var ourtype = Context.toComplexType(Context.getLocalType());
        var superreal = switch (superexpr) {
        case {expr: EArrayDecl(arr)}:
            var pack = arr.map((e) -> e.getValue());
            var name = pack[arr.length - 1];
            pack.resize(arr.length - 1);
            TPath({pack : pack,name : name});
        default:
            trace("failed");
            return null;
        }
        var hxgen = (macro : gmod.HaxeGen<$superreal,$ourtype>);
        var panelclass = (macro : gmod.PanelClass<gmod.HaxeGen<$superreal,$ourtype>>);
        var classname = cls.name;
        var fieldstor = macro class {
            public final self:$superreal;

            final function new(x:$superreal) {
                self = x;
            }
        }
        if (!superType.meta.has(":FirstPanel")) {
            fields.push(fieldstor.fields[0]);
            fields.push(fieldstor.fields[1]);
        }
        generate.push({
            genName : genName,
            entLuaType : entLuaType,
            funcs : fOverride,
            properties : properties,
            esent:esent,
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
    
    public static function buildSent() {
        return build(Sent);
    }

    public static function buildSwep() {
        return build(Swep);
    }

    public static function buildEffect() {
        return build(Effect);
    }

    static function afterGenerate() {
        var baseStorage = InitMacro.baseEntFolder;
        if (baseStorage == null) {
            trace("no base storage to generate entity lua files");
            return;
        }
        var exportName = InitMacro.entLuaStorage;
        for (gen in generate) {
            var baseIdent:String;
            var _baseStorage:String;
            switch gen.esent {
            case Swep:
                _baseStorage = '$baseStorage/weapons';
                baseIdent = "SWEP";
            case Sent:
                _baseStorage = '$baseStorage/entities';
                baseIdent = "ENT";
            case Effect:
                _baseStorage = '$baseStorage/effects';
                baseIdent = "EFFECT";
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
            switch gen.esent {
            case Sent:
                filebuf.add('$baseIdent.Type = "${gen.entLuaType}"\n');
            default:
            }
            #if server
                filebuf.add("AddCSLuaFile(\"cl_init.lua\")\n");
            #end
            switch (gen.esent) {
            case Sent | Swep:
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
            case Effect:
                filebuf.add('\nfunction $baseIdent:Init(...)\n');
                filebuf.add('\tlocal ent = $exportName.${gen.genName}.new(self)\n');
                filebuf.add("\tself._gHaxeBurrow = ent\n");
                if (gen.overridenInit) {
                    filebuf.add("\tself._gHaxeBurrow:Init(...)\n");
                }
                filebuf.add('end\n\n');
            }
            for (field in gen.funcs) {
                switch [field.name,gen.esent] {
                case ["Initialize",_]:
                    continue;
                case ["Init",Effect]:
                    continue;
                #if client
                case ["Think",Swep | Sent]:
                    continue;
                #end
                default:
                }
                filebuf.add('function $baseIdent:${field.name}(...)\n');
                filebuf.add('\tself._gHaxeBurrow:${field.name}(...)\n');
                filebuf.add('end\n\n');
            }
            FileSystem.createDirectory('$_baseStorage/${gen.genName}');
            #if client
            switch (gen.esent) {
            case Effect:
                File.saveContent('$_baseStorage/${gen.genName}/init.lua',filebuf.toString());
            case Swep | Sent:
                File.saveContent('$_baseStorage/${gen.genName}/cl_init.lua',filebuf.toString());
            }
            #elseif server
            File.saveContent('$_baseStorage/${gen.genName}/init.lua',filebuf.toString());
            #end
        }
    }
}

#end
