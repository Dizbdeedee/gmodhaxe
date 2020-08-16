package gmod.macros;
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

    public static var exportName:String;

    public static final serverName = "haxe_init";

    public static final clientName = "haxe_cl_init";

    #if macro

    static public function init() {
        Compiler.include("gmod.macros.include",true,null,null,true);
        Compiler.keep("gmod.macros.include",null,true);

        no.Spoon.bend("Sys",macro class {
            public static function time():Float {
                return gmod.Gmod.SysTime();
            }
        });
        #if (haxe >= "4.1.0")
            Compiler.includeFile("gmod/macros/include/LuaPatch.lua");
        #end
        #if (!display)
        if (!Context.defined("lua") || Context.defined("display_details") ) {
            return;
        }
        var addonName:String;
        if (Context.defined("addonName")) {
            addonName = Context.definedValue("addonName").toLowerCase();
            FileSystem.createDirectory('generated/${addonName}');
        } else {
            Context.warning("InitMacro : No \"-D addonName=your_addon_name_here\" defined in .hxml file. Will not generate folder structure",Context.currentPos());
            return;
        }
        if (Context.defined("gamemode")) {
            generateGamemodeFiles(addonName);
        } else {
            generateNonGamemodeFiles(addonName);
        }
        if (Context.defined("gmodAddonFolder") && (Context.defined("client") || Context.defined("loner"))) {
            Context.onAfterGenerate(updateAddonFolder);
        }
        #end
    }
    static function updateAddonFolder() {
        #if !display
        var gmodAddonFolder = Context.definedValue("gmodAddonFolder");
        var exists = FileSystem.exists(gmodAddonFolder);
        var abs = Path.isAbsolute(gmodAddonFolder);
        var isdir = FileSystem.isDirectory(gmodAddonFolder);
        switch ([exists,abs,isdir]) {
            case [true,true,true]:
                recurseCopy("generated",gmodAddonFolder);
            case [false,_,_]:
                Context.warning("gmodAddonFolder defined but does not exist",Context.currentPos());
            case [_,false,_]:
                Context.warning("gmodAddonFolder defined but is in invalid format",Context.currentPos());
            case [_,_,false]:
                Context.warning("gmodAddonFolder defined but is not a directory",Context.currentPos());
        }
        #end
    }

    static function luaPatch(?addonName:String) {
    }

    static function recurseCopy(curFolder:String,output:String) {
        #if !display
        for (name in FileSystem.readDirectory(curFolder)) {
            var curFile = Path.join([curFolder,name]);
            var otherFile = Path.join([output,name]);
            if (FileSystem.isDirectory(Path.join([curFolder,name]))) {
                FileSystem.createDirectory(otherFile);
                recurseCopy(Path.join([curFolder,name]),Path.join([output,name]));
            } else {
                File.copy(curFile,otherFile);
            }
        }
        #end
    }


    static function generateGamemodeFiles(addonName:String) {
        final gamemodeName = Context.definedValue("gamemode").toLowerCase();
        final game = 'generated/$addonName/gamemodes/$gamemodeName';
        exportName = '${gamemodeName}_HAXE_EXPORT';
        baseEntFolder = '$game/entities';
        final gmfolder = '$game/gamemode';
        if (!FileSystem.exists('$baseEntFolder/entities')) {
            FileSystem.createDirectory('$baseEntFolder/entities');
            FileSystem.createDirectory('$baseEntFolder/effects');
            FileSystem.createDirectory('$baseEntFolder/weapons');
        }
        if (!FileSystem.exists(gmfolder)) FileSystem.createDirectory(gmfolder);
        if (Context.defined("client")) {
            if (Context.defined("generateLuaInit")) {
                File.saveContent('$gmfolder/cl_init.lua',
                'local exports = include("$clientName.lua")
${gamemodeName}_HAXE = exports.__env
for i,p in pairs(exports) do
    if i ~= "__env" then
        _G[i] = p
    end
end');
            }
            Compiler.setOutput('$gmfolder/$clientName.lua');
            trace("generated client.lua");
        } else if (Context.defined("server")) {
            if (Context.defined("generateLuaInit")) {
                File.saveContent('$gmfolder/init.lua',
                'AddCSLuaFile("$clientName.lua")\nlocal exports = include("$serverName.lua")
${gamemodeName}_HAXE = exports.__env
for i,p in pairs(exports) do
    if i ~= "__env" then
        _G[i] = p
    end
end');
            }
            Compiler.setOutput('$gmfolder/$serverName.lua');
            trace("generated server.lua");
        }
    }

    static function generateNonGamemodeFiles(addonName:String) {
        exportName = '${addonName}_HAXE_EXPORT';
        baseEntFolder = 'generated/$addonName/lua';
        FileSystem.createDirectory('generated/$addonName/lua/$addonName');
        if (Context.defined("generateLuaInit")) {
            final initFile:String = 'if SERVER then AddCSLuaFile("$addonName/$clientName.lua") exports = include("$addonName/$serverName.lua") end
if CLIENT then local exports = include("$addonName/$clientName.lua") end
if exports.toGlobalTable ~= nil then
    for i,p in pairs(exports.toGlobalTable) do
        _G[i] = p
    end
end
${addonName}_HAXE = exports.__env
for i,p in pairs(exports) do
    if i ~= "__env" and i ~= "toGlobalTable" then
        _G[i] = p
    end
end
';
            FileSystem.createDirectory('generated/$addonName/lua/autorun/');
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
