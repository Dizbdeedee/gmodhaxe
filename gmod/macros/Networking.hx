package gmod.macros;
#if tink_core
import haxe.macro.Expr.ComplexType;
import haxe.macro.Type.FieldKind;
import haxe.macro.Expr.TypeParam;
#if (macro)
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools.ExprArrayTools;
using haxe.macro.TypedExprTools;
import haxe.macro.Expr.ComplexType;
#end

private typedef ServerMessages = {
    name : String,
    type: ComplexType,
    param : TypeParam
}
class Networking {
    #if macro
    public static function build():Array<Field> {
        var fields = Context.getBuildFields();
        var serverMessages:Array<ServerMessages> = [];
        for (field in fields) {
            switch(field.kind) {
                case FVar(TPath({name : "NetMessageServer", params : params}), _):
                    var param = params[0];
                    switch (param) {
                        case TPType(t):
                            serverMessages.push({
                                name : field.name,
                                type : t,
                                param : param
                            });
                        default:
                    }
                default:
            }
        }
        var initExpr:Array<Expr> = [];
        for (msg in serverMessages) {
            var signal = (macro : tink.CoreApi.Signal);
            var signalTrigger = (macro : tink.CoreApi.SignalTrigger);
            (signal.getParameters()[0] : TypePath).params = [msg.param];
            (signalTrigger.getParameters()[0] : TypePath).params = [msg.param];
            if (Context.defined("server")) {
                var funcArg:FunctionArg = {
                    name : "data",
                    type : msg.type,
                }
                var player:FunctionArg = {
                    name : "player",
                    type : (macro : gmod.gclass.Player)
                }
                var sendFuncExpr:Function = {
                    args:  [funcArg,player],
                    expr : writeNetConstructer(msg.type,msg.name),
                    ret : null
                }
                var sendFunc:Field = {
                    name : 'send${msg.name}',
                    kind : FieldType.FFun(sendFuncExpr),
                    pos : Context.currentPos(),
                    access: [Access.AStatic,Access.APublic]
                }
                fields.push(sendFunc);
            } else if (Context.defined("client")) {
                var recvFuncExpr:Function = {
                    args:  [],//player
                    // expr : null,
                    expr : writeNetReciever(msg.type,msg.name),
                    ret : null
                }
                var recvFunc:Field = {
                    name : 'recv${msg.name}',
                    kind : FieldType.FFun(recvFuncExpr),
                    pos : Context.currentPos(),
                    access : [Access.AStatic]
                }
                fields.push(recvFunc);
            }
            if (Context.defined("server")) {
                initExpr.push(macro gmod.libs.UtilLib.AddNetworkString($v{msg.name}));
            }
            if (Context.defined("client")) {
                var clientSignal:Field = {
                    name : '${msg.name}Signal',
                    kind : FieldType.FVar(signal),
                    pos : Context.currentPos(),
                    access: [Access.APublic,Access.AStatic]
                }
                var clientTriggerSignal:Field = {
                    name : '${msg.name}SignalTrigger',
                    kind : FieldType.FVar(signalTrigger),
                    pos : Context.currentPos(),
                    access: [Access.AStatic]
                }
                var sigtrig = '${msg.name}SignalTrigger';
                var sig = '${msg.name}Signal';
                var exdee:TypePath = ((macro : tink.CoreApi.SignalTrigger)).getParameters()[0];
                initExpr.push(macro $i{sigtrig} = new $exdee());
                initExpr.push(macro $i{sig} = $i{sigtrig}.asSignal());
                initExpr.push(macro gmod.libs.NetLib.Receive($v{msg.name},$i{'recv${msg.name}'}));
                fields.push(clientSignal);
                fields.push(clientTriggerSignal);
            }
        }
        var initMessagesFunc:Function = {
            args: [],
            expr : macro $b{initExpr},
            ret : null
        }
        var initMessages:Field = {
            name : "initMessages",
            kind : FieldType.FFun(initMessagesFunc),
            pos : Context.currentPos(),
            access : [Access.APublic,Access.AStatic],
            doc : "Call as early as possible to setup network messages. Must be called on both the server and client"
        }
        fields.push(initMessages);
        return fields;
    }

    static function writeNetConstructer(anon:ComplexType,name:String):Expr {
        var resolved = Context.resolveType(anon,Context.currentPos());
        var macArray:Array<Expr> = [];
        macArray.push(macro gmod.libs.NetLib.Start($v{name}));
        var entity = Context.resolveType((macro : gmod.gclass.Entity),Context.currentPos());
        var string = Context.resolveType((macro : String),Context.currentPos());
        var vector = Context.resolveType((macro : gmod.gclass.Vector),Context.currentPos());
        var angle = Context.resolveType((macro : gmod.gclass.Angle),Context.currentPos());
        var int = Context.resolveType((macro : Int),Context.currentPos());
        var float = Context.resolveType((macro : Float),Context.currentPos());
        var table = Context.resolveType((macro : lua.Table.AnyTable),Context.currentPos());
        var bool = Context.resolveType((macro : Bool),Context.currentPos());
        var twoWayUni = (x:haxe.macro.Type,y:haxe.macro.Type) -> x.unify(y) && y.unify(x);
        switch (resolved) {
            case TType(_.get() => {type : TAnonymous(_.get() => anon)},_) :
                for (field in anon.fields) {
                    var name = field.name;
                    switch (field.type) {
                        case twoWayUni(_,entity) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteEntity(data.$name));
                        case twoWayUni(_,string) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteString(data.$name));
                        case twoWayUni(_,int) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteInt(data.$name,32));
                        //NOTE Only one way checked, assumes writetable will be able to handle whatevers put in
                        case _.unify(table) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteTable(data.$name));
                        case twoWayUni(_,float) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteFloat(data.$name));
                        case twoWayUni(_,vector) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteVector(data.$name));
                        case twoWayUni(_,angle) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteAngle(data.$name));
                        case twoWayUni(_,bool) => true:
                            macArray.push(macro gmod.libs.NetLib.WriteBool(data.$name));
                        default:
                            trace('could not generate constructer field:${field.name}');
                    }
                }
            default:
                trace(resolved);
        }
        macArray.push(macro gmod.libs.NetLib.Send(player));
        return macro $b{macArray};
    }

    static function writeNetReciever(anon:ComplexType,name2:String):Expr {
        var resolved = Context.resolveType(anon,Context.currentPos());
        var mac:Array<ObjectField> = [];
        var entity = Context.resolveType((macro : gmod.gclass.Entity),Context.currentPos());
        var string = Context.resolveType((macro : String),Context.currentPos());
        var vector = Context.resolveType((macro : gmod.gclass.Vector),Context.currentPos());
        var angle = Context.resolveType((macro : gmod.gclass.Angle),Context.currentPos());
        var int = Context.resolveType((macro : Int),Context.currentPos());
        var float = Context.resolveType((macro : Float),Context.currentPos());
        var table = Context.resolveType((macro : lua.Table.AnyTable),Context.currentPos());
        var bool = Context.resolveType((macro : Bool),Context.currentPos());
        var twoWayUni = (x:haxe.macro.Type,y:haxe.macro.Type) -> x.unify(y) && y.unify(x);
        switch (resolved) {
            case TType(_.get() => {type : TAnonymous(_.get() => anon)},_) :
                for (field in anon.fields) {
                    var name = field.name;
                    trace(name);
                    switch (field.type) {
                        case twoWayUni(_,int) => true:
                            mac.push({field : name, expr : macro {gmod.libs.NetLib.ReadInt(32);}});
                        case twoWayUni(_,string) => true:
                            mac.push({field : name, expr : macro {gmod.libs.NetLib.ReadString();}});
                        case _.unify(table) => true:
                            mac.push({field : name, expr : macro {cast gmod.libs.NetLib.ReadTable();}});
                        case twoWayUni(_,float) => true:
                            mac.push({field : name, expr : macro {gmod.libs.NetLib.ReadFloat();}});
                        case twoWayUni(_,vector) => true:
                            mac.push({field : name, expr : macro {gmod.libs.NetLib.ReadVector();}});
                        case twoWayUni(_,angle) => true:
                            mac.push({field : name, expr : macro {gmod.libs.NetLib.ReadAngle();}});
                        case twoWayUni(_,bool) => true:
                            mac.push({field : name, expr : macro {gmod.libs.NetLib.ReadBool();}});
                        case twoWayUni(_,entity) => true:
                            mac.push({field : name, expr : macro {gmod.libs.NetLib.ReadEntity();}});
                        default:
                            trace('could not generate reciever field:${field.name}');
                            trace(field.type.toString());
                    }
                }
            default:
                trace(resolved);
        }
        var objdecl = EObjectDecl(mac);
        var objdel2:Expr = {
            expr : objdecl,
            pos : Context.currentPos(),
        }
        var triggername = '${name2}SignalTrigger';
        var mac2 = macro {$i{triggername}.trigger($e{objdel2});};
    
        return mac2;
    }
    #end
}
#end