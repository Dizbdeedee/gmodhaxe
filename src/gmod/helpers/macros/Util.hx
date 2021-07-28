package gmod.helpers.macros;

import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;
import haxe.macro.Expr;
import haxe.macro.Context;
using StringTools;

final nato = [
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

function recurseCopy(curFolder:String,output:String,copyFilePred:(String) -> Bool) {
    for (name in FileSystem.readDirectory(curFolder)) {
        var curFile = Path.join([curFolder,name]);
        var otherFile = Path.join([output,name]);
        if (FileSystem.isDirectory(Path.join([curFolder,name]))) {
            FileSystem.createDirectory(otherFile);
            recurseCopy(Path.join([curFolder,name]),Path.join([output,name]),copyFilePred);
        } else {
            final curname = Path.withoutExtension(Path.withoutDirectory(curFile));
            if (copyFilePred(curname)) {
                File.copy(curFile,otherFile);
            }
        }
    }
}

function getValue(e:Expr):Dynamic {
    return switch (e.expr) {
        case EConst(CInt(v)): Std.parseInt(v);
        case EConst(CFloat(v)): Std.parseFloat(v);
        case EConst(CString(s)): s;
        case EConst(CIdent("true")): true;
        case EConst(CIdent("false")): false;
        case EConst(CIdent("null")): null;
        case EParenthesis(e1) | EUntyped(e1) | EMeta(_, e1): getValue(e1);
        case EObjectDecl(fields):
            var obj = {};
            for (field in fields) {
                Reflect.setField(obj, field.field, getValue(field.expr));
            }
            obj;
        case EArrayDecl(el): el.map(getValue);
        case EIf(econd, eif, eelse) | ETernary(econd, eif, eelse):
            if (eelse == null) {
                throw "If statements only have a value if the else clause is defined";
            } else {
                var econd:Dynamic = getValue(econd);
                econd ? getValue(eif) : getValue(eelse);
            }
        case EUnop(op, false, e1):
            var e1:Dynamic = getValue(e1);
            switch (op) {
                case OpNot: !e1;
                case OpNeg: -e1;
                case OpNegBits: ~e1;
                case _: throw 'Unsupported expression: $e';
            }
        case EBinop(op, e1, e2):
            var e1:Dynamic = getValue(e1);
            var e2:Dynamic = getValue(e2);
            switch (op) {
                case OpAdd: e1 + e2;
                case OpSub: e1 - e2;
                case OpMult: e1 * e2;
                case OpDiv: e1 / e2;
                case OpMod: e1 % e2;
                case OpEq: e1 == e2;
                case OpNotEq: e1 != e2;
                case OpLt: e1 < e2;
                case OpLte: e1 <= e2;
                case OpGt: e1 > e2;
                case OpGte: e1 >= e2;
                case OpOr: e1 | e2;
                case OpAnd: e1 & e2;
                case OpXor: e1 ^ e2;
                case OpBoolAnd: e1 && e2;
                case OpBoolOr: e1 || e2;
                case OpShl: e1 << e2;
                case OpShr: e1 >> e2;
                case OpUShr: e1 >>> e2;
                case _: throw 'Unsupported expression: $e';
            }
        default:
            var typeExpr = Context.typeExpr(e); // turns abstract fields into cast expr
            var untype = Context.getTypedExpr(typeExpr); //make it back into something we can already intrepret
            switch (untype) {
                case {expr: ECast(e, t), pos: pos}:
                    trace(getValue(e));
                    getValue(e);
                default:
                    throw 'Unsupported expression: $e';
            }
    }
}

//is this wise? no
function filter() {
    // Context.onAfterGenerate(() -> {
    //     Context.filterMessages((message) -> {
    //         return switch (message) {
    //             case Warning(msg, Context.getPosInfos(_) => pos2):
    //                 !((pos2.file.contains("erazor") || pos2.file.contains("hscript")) && msg.startsWith("Std.is"));
    //             default:
    //                 true;
    //         }
    //     });
    // });
}
