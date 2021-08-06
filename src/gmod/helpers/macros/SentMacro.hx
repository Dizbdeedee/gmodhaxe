package gmod.helpers.macros;

import gmod.helpers.macros.Util.getDocsFromParent;
import gmod.helpers.macros.Util.extractGmodParent;
import haxe.Resource;
#if (macro)
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
        switch [esent,Context.defined("server")] {
            case [Effect,true]:
                Context.error("Effects aren't on the server",cls.pos);
                return null;
            default:
        }
        var properties = null;
        var type = Context.toComplexType(Context.getLocalType());
        var fields = Context.getBuildFields();
        var superType = cls.superClass.t.get();
        var overridenInit = false;
        var overridenThink = false;
        var fOverride:Array<Field> = [];
        for (field in fields) {
            switch [field.name,field.kind] {
                case ["properties",FVar(_, e)]:
                    properties = true;
                case [name,FFun(f)]:
                    if (field.access == null) continue;
                    if (field.access.contains(Access.AOverride)) { //no...
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
        }

        switch [properties,esent] {
        case [null,Swep | Sent]:
            Context.error("No ent properties found",cls.pos);
            return null;
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
                    Context.warning("no TYPE for ENT definition",cls.pos);
                    return null;
                case _.expr() => {expr : TConst(TString(s))}:
                    s;
                default:
                    Context.warning("no TYPE for ENT definition",cls.pos);
                    return null;
            }
        default:
            null;
        }
        var superexpr = superType.meta.extract(":RealExtern")[0].params[0];
        cls.meta.add(":FirstPanel",[],Context.currentPos());
        cls.meta.add(":RealExtern",[superexpr],Context.currentPos());
        var ourtype = Context.toComplexType(Context.getLocalType());
        var gmodParent = extractGmodParent(superType);
        var gen = PanelMacro.generateGmodSideExtern({target: cls,gmodParent: gmodParent,targetFields: fields});
        var gmodType = gen.link.toComplexType();
        var entClass = (macro : gmod.stringtypes.EntityClass<$gmodType>);
        
        var fieldStore = if (superType.findField("self") != null) {
            macro class {
                #if server
                public static function create():$gmodType {
                    return gmod.libs.EntsLib.Create(gclass);
                }
                #end

                public static inline final gclass:$entClass = $v{cls.name};

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
                final self:Dynamic;

                public static inline final gclass:$entClass = $v{cls.name};

                final function new(x:Dynamic) {
                    self = x;
                }

                public function get_self():$gmodType {
                    return cast self;
                }
            }
        }
        final resultGClass = superType.findField("gclass",true);
        if (resultGClass == null) {
            Context.error("Cannot find gclass field",cls.pos);
            return null;
        }
        final base = switch (resultGClass.expr().expr) {
            case TConst(TString(s)):
                s;
            default:
                Context.error("Could not intepret gclass field",cls.pos);
                return null;
        }
        fields = fields.concat(fieldStore.fields);
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
        var temp = new haxe.Template(Resource.getString("gmodhaxe_sent"));
        var baseStorage = InitMacro.baseEntFolder;
        if (baseStorage == null) {
            Context.warning("Failed to save entity lua files",Context.currentPos());
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
