package gmod.helpers.macros;

#if macro
import haxe.macro.Expr.Function;
import haxe.macro.Expr.FieldType;
import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;
import haxe.macro.Compiler;
import haxe.macro.Expr.Position;
import haxe.macro.Context;
import haxe.macro.Expr.TypeDefinition;
using haxe.macro.TypeTools;
using StringTools;

#end



class InitMacro {

    public static var baseEntFolder:String;

    public static var entLuaStorage:String;

    
    public static var buildIdent:String;

    public static final serverName = "haxe_init";

    public static final clientName = "haxe_cl_init";
    #if macro
    
    #if (haxe >= "4.2.0")
    static final pos = Context.makePosition({min : 0, max: 0, file : "gmodhaxe - InitMacro.hx"});
    #else
    static extern inline final pos(get,never):Position;

    static function get_pos() {
        return Context.currentPos();
    }
    #end

    static final nato = [
        "Alpha", 
        "Bravo", 
        "Charlie", 
        "Delta", 
        "Echo", 
        "Foxtrot", 
        "Golf", 
        "Hotel", 
        "India", 
        "Juliett", 
        "Kilo", 
        "Lima", 
        "Mike", 
        "November", 
        "Oscar", 
        "Papa", 
        "Quebec", 
        "Romeo", 
        "Sierra", 
        "Tango", 
        "Uniform", 
        "Victor", 
        "Whiskey", 
        "Xray", 
        "Yankee", 
        "Zulu"
    ];

    static public function init() {
        Compiler.include("gmod.helpers.macros.include",true,null,null,true);
        Compiler.keep("gmod.helpers.macros.include",null,true);
        var buildident = Math.floor(Math.random() * 729);
        buildIdent = nato[Math.floor(buildident / 27)] + " " + nato[buildident % 27];
        no.Spoon.bend("Sys",macro class {
            public static function time():Float {
                return gmod.Gmod.SysTime();
            }
        });
        
        
        #if (haxe >= "4.2.0")
        no.Spoon.bend("haxe.format.JsonParser",macro class {
            public static inline function parse(str:String):Dynamic {
                return new haxe.format.JsonParser(str).doParse();
            }
        });
        #end
        Compiler.addGlobalMetadata("","@:build(gmod.helpers.macros.HookMacro.build())");

        var x:TypeDefinition = {
            pack : ["gmod","helpers","macros"],
            name : "StoredInfo",
            pos: pos,
            kind : TDAlias(macro : Math),
            fields : []
        }
        
        try {
            Context.getType("gmod.helpers.macros.StoredInfo");
        } catch (e) {
            no.Spoon.replace('gmod.gclass.Vector',macro : gmod.helpers.types.Vector);
            no.Spoon.replace('gmod.gclass.Angle',macro : gmod.helpers.types.Angle);
            Context.defineType(x);
        }
        
        if (Context.defined("server")) {
            Sys.putEnv("gmodhaxe_notCopy",clientName);
        } else if (Context.defined("client")) {
            Sys.putEnv("gmodhaxe_notCopy",serverName);
        }
        #if (haxe >= "4.1.0")
            Compiler.includeFile("gmod/helpers/macros/include/PrintPatch.lua");
        #end
        Compiler.addMetadata(":using(gmod.helpers.PairTools)","lua.Table");
        Compiler.addMetadata(":using(gmod.helpers.TableTools)","lua.Table");
        #if (!display)
        if (!Context.defined("lua") || Context.defined("display_details") ) {
            return;
        }
        var addonName:String;
        if (Context.defined("addonName")) {
            addonName = Context.definedValue("addonName").toLowerCase();
            FileSystem.createDirectory('generated/${addonName}');
        } else {
            Context.warning("InitMacro : No \"-D addonName=your_addon_name_here\" defined in .hxml file. Will not generate folder structure",pos);
            return;
        }
        Sys.putEnv("gmodhaxe_addonName", addonName);
        if (Context.defined("gmodAddonFolder")) {
            Sys.putEnv("gmodhaxe_gmodAddonFolder",Context.definedValue("gmodAddonFolder"));
        }
        
        if (Context.defined("gamemode")) {
            generateGamemodeFiles(addonName);
        } else {
            generateNonGamemodeFiles(addonName);
        }
        Sys.putEnv("gmodhaxe_buildIdent",Std.string(buildident));
        if (Context.defined("printBuildIdent")) {
            Sys.putEnv("gmodhaxe_printIdent","yes");
        }
        Sys.putEnv("gmodhaxe_output",Compiler.getOutput());
        #end
    }

    static function generateGamemodeFiles(addonName:String) {
        final gamemodeName = Context.definedValue("gamemode").toLowerCase();
        final game = 'generated/$addonName/gamemodes/$gamemodeName';
        entLuaStorage = '__${gamemodeName}_ents';
        baseEntFolder = '$game/entities';
        final gmfolder = '$game/gamemode';
        if (!FileSystem.exists('$baseEntFolder/entities')) {
            FileSystem.createDirectory('$baseEntFolder/entities');
            FileSystem.createDirectory('$baseEntFolder/effects');
            FileSystem.createDirectory('$baseEntFolder/weapons');
        }
        if (!FileSystem.exists(gmfolder)) FileSystem.createDirectory(gmfolder);
        if (Context.defined("client")) {
            if (!Context.defined("noGenInit")) {
                File.saveContent('$gmfolder/cl_init.lua',
                'local exports = include("$clientName.lua")');
            }
            Compiler.setOutput('$gmfolder/$clientName.lua');
        } else if (Context.defined("server")) {
            if (!Context.defined("noGenInit")) {
                File.saveContent('$gmfolder/init.lua',
                'AddCSLuaFile("$clientName.lua")\nlocal exports = include("$serverName.lua")');
            }
            Compiler.setOutput('$gmfolder/$serverName.lua');
        }
    }

    static function generateNonGamemodeFiles(addonName:String) {
        entLuaStorage = '__${addonName}_ents';
        baseEntFolder = 'generated/$addonName/lua';
        FileSystem.createDirectory('generated/$addonName/lua/$addonName');
        final initFile:String = 'local exports if SERVER then AddCSLuaFile("$addonName/$clientName.lua") exports = include("$addonName/$serverName.lua") end
if CLIENT then exports = include("$addonName/$clientName.lua") end';
        FileSystem.createDirectory('generated/$addonName/lua/autorun/');
        if (!Context.defined("noGenInit")) {
            File.saveContent('generated/$addonName/lua/autorun/haxe_init_$addonName.lua',initFile);
        }
        if (Context.defined("client")) {
            trace("generated non gamemode client.lua");
            Compiler.setOutput('generated/$addonName/lua/$addonName/$clientName.lua');
        } else if (Context.defined("server")) {
            trace("generated non gamemode server.lua");
            Compiler.setOutput('generated/$addonName/lua/$addonName/$serverName.lua');
        }
    }

#end
}
