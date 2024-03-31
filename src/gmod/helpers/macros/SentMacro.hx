package gmod.helpers.macros;

import haxe.macro.Type.TypedExpr;
import haxe.Resource;
#if (macro)
import gmod.helpers.macros.Util;
import gmod.helpers.macros.template.*;
import gmod.helpers.macros.InitMacro;
import sys.FileSystem;
import sys.io.File;
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.TypedExprTools;
using Lambda;


private typedef Generate = {
    genName : String,
    ?entLuaType : String,
    funcs : Array<Field>,
    properties : Bool,
    esent : ESent,
    overridenInit : Bool,
    overridenThink : Bool,
    base : String
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
        if (cls.meta.has(":HaxeGenExtern")) return null;
        if (cls.meta.has(":Generated")) return null;
        switch [esent,Context.defined("server")] {
            case [Effect,true]:
                Context.error("Effects aren't on the server",cls.pos);
                return null;
            default:
        }
        var properties = null;
        var fields = Context.getBuildFields();
        var superType = cls.superClass.t.get();
        var overridenInit = false;
        var overridenThink = false;
        var fOverride:Array<Field> = [];
        for (field in fields) {
            switch [field.name,field.kind] {
                case ["properties",FVar(_, e)]:
                    if (!field.access.contains(Access.AStatic)) {
                        Context.error("Properties must be static!",field.pos);
                        return null;
                    }
                    if (!field.access.contains(Access.AFinal)) {
                        field.access.push(AFinal);
                    }
                    field.kind = switch (esent) {
                        case Swep:
                            FVar(Context.getType("gmod.helpers.swep.SwepBuild.SwepFields").toComplexType(),e);
                        case Sent:
                            FVar(Context.getType("gmod.helpers.sent.SentBuild.EntFields").toComplexType(),e);
                        default:
                            Context.error("Not implemented",Context.currentPos());
                            return null;
                    }
                    properties = true;
                case [name,FFun(f)]:
                    if (field.access == null) continue;
                    if (field.access.contains(Access.AOverride)) { //no...1
                        switch (name) {
                            case "Initialize" | "Init":
                                overridenInit = true;
                            case "Think":
                                overridenThink = true;
                        }
                        //:engineHook??
                        getDocsFromParent(field,superType);
                        fOverride.push(field);
                    }
                    if (field.meta.exists(f -> f.name == ":entExpose")) {
                        fOverride.push(field);
                    }
                default:
            }
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
            var type = findMeta(cls,":TYPE");
            switch (type) {
                case null:
                    Context.warning("no TYPE for ENT definition",cls.pos);
                    null;
                case {params : [{expr: EConst(CString(s, _))}]}:
                    s;
                default:
                    Context.warning("no TYPE for ENT definition",cls.pos);
                    null;
            }
        default:
            null;
        }
        cls.meta.add(":FirstPanel",[],Context.currentPos());
        var ourtype = Context.toComplexType(Context.getLocalType());
        var gmodParent = extractGmodParent(superType);
        var gen = PanelMacro.generateGmodSideExtern({target: cls,gmodParent: gmodParent,targetFields: fields});
        var gmodType = gen.link;
        var entClass = (macro : gmod.stringtypes.EntityClass<$gmodType>);
        var tp:Array<String> = TypePathHelper.fromComplexType(gen.rawClass);
        var strArr = tp.map((x) -> macro $v{x});
        cls.meta.add(":RealExtern",[macro $a{strArr}],Context.currentPos());
        var fieldStore = if (superType.findField("self") != null) {
            macro class {

                #if server
                public static function create():$gmodType {
                    return gmod.libs.EntsLib.Create(gclass);
                }
                #end

                public static inline final gclass:$entClass = $v{genName};

                public override function get_self():$gmodType {
                    return cast self;
                }
            }
        } else {
            macro class {
                #if server
                public static function create():$gmodType {
                    return gmod.libs.EntsLib.Create(gclass);
                }
                #end
                var self:Dynamic;

                public static inline final gclass:$entClass = $v{genName};

                @:keep
                final function new(x:Dynamic) {
                    self = x;
                }

                public function get_self():$gmodType {
                    return cast self;
                }
            }
        }
        replaceSelfInFields(fields,gmodType);
        switch [properties,esent] {
            case [null,Swep | Sent]:
                var props = macro class {static final properties = {}};
                fieldStore.fields.push(props.fields[0]);
                default:
            }
        final resultGClass = findMeta(superType,":gclass");
        final base = switch (resultGClass) {
            case null:
                Context.warning("Could not intepret gclass meta",cls.pos);
                "null";
            case {params : [{expr: EConst(CString(s, _))}]}:
                s;
            default:
                Context.warning("Could not intepret gclass meta",cls.pos);
                "null";
        }
        generate.push({
            genName : genName,
            entLuaType : entLuaType,
            funcs : fOverride,
            properties : properties,
            esent:esent,
            overridenThink: overridenThink,
            overridenInit: overridenInit,
            base : base
        });
        if (!onGenerate) {
            Context.onAfterGenerate(afterGenerate);
            onGenerate = true;
        }
        cls.meta.add(":keep",[],Context.currentPos());
        cls.meta.add(":gclass",[macro $v{genName}],Context.currentPos());
        cls.meta.add(":Generated",[],Context.currentPos());
        return fields.concat(fieldStore.fields);
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
        var temp = new haxe.Template(T_Sent_lua.sent);
        var baseStorage = InitMacro.baseEntFolder;
        if (baseStorage == null) {
            Context.warning("Failed to save entity lua files. Try restarting the language server.",Context.currentPos());
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
            var funcShouldAdd = gen.funcs.map((f) -> {
                Reflect.setField(f,"shouldAdd",switch [f.name,gen.esent] {
                    case ["Initialize",_]:
                        false;
                    case ["Init",Effect]:
                        false;
                    #if client
                    case ["Think",Swep | Sent]:
                        false;
                    #end
                    default:
                        true;
                });
                f;
            });
            var str = temp.execute({
                baseIdent : baseIdent,
                genName : gen.genName,
                client : Context.defined("client"),
                overridenThink : gen.overridenThink,
                overridenInit : gen.overridenInit,
                esent : gen.esent,
                exportName : exportName,
                entLuaType : gen.entLuaType,
                sent : gen.esent == Sent,
                sentSwep : switch gen.esent {
                    case Sent | Swep:
                        true;
                    default:
                        false;
                },
                funcs : funcShouldAdd,
                base : gen.base
            });

            FileSystem.createDirectory('$_baseStorage/${gen.genName}');
            #if client
            switch (gen.esent) {
            case Effect:
                File.saveContent('$_baseStorage/${gen.genName}/init.lua',str);
            case Swep | Sent:
                File.saveContent('$_baseStorage/${gen.genName}/cl_init.lua',str);
            }
            #elseif server
            File.saveContent('$_baseStorage/${gen.genName}/init.lua',str);
            #end
        }
    }
}

#end
