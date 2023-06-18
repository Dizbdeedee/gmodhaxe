package gmod.helpers.macros;

import haxe.macro.Compiler;
import gmod.helpers.macros.Util.typeExists;
#if macro
import haxe.macro.Type.ClassField;

import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;
using haxe.macro.PositionTools;
using StringTools;
class Networking {

    static var netID = 0;

    static var test = 0;

    static var generatedStorage:Map<String,haxe.macro.Expr.TypeDefinition> = [];

    static var generated = false;

    static function enableNotFound() {
        if (!generated) {
            Context.onTypeNotFound((clsName) -> {
                return if (generatedStorage.exists(clsName)) {
                    generatedStorage.get(clsName);
                } else {
                    null;
                }
            });
            generated = true;
        }
    }

    public static function build(client:Bool):ComplexType {
        enableNotFound();
        var type = Context.getLocalType();
        final tpathresult = if (client) {
            clientchoose(type);
        } else {
            serverchoose(type);
        }
        return tpathresult;
    }

    static function setupbuild(buildname:String,generate:() -> haxe.macro.Expr.TypeDefinition) {
        generatedStorage.set(buildname,generate());
        return TPath({name : buildname,pack: []});
    }

    static function serverchoose(type:haxe.macro.Type) {
        return switch (type) {
            case TInst(_,[TInst(_.get() => {kind : KExpr(_.getValue() => s) },_), anon = _.follow() => TAnonymous(_.get() => {fields : fields})]):
                var netName = s;
                setupbuild(netName,() -> buildanon(netName,anon,fields));
            case TInst(_,[anon = _.follow() => TAnonymous(_.get() => {fields : fields})]):
                var netName = '${Context.getLocalModule()}_${Context.signature(anon)}';
                netName = netName.replace(".","_");
                setupbuild(netName,() -> buildanon(netName,anon,fields));
            #if hxbit
            case TInst(_,[TInst(_.get() => {kind : KExpr(_.getValue() => s) },_), hxClass = TInst(_.get() => {name : clsString,module : clsModule},_)]):
                final netName = s;
                final str = clsModule + "." + clsString;
                final clsPath = str.split(".");
                setupbuild(netName,() -> buildhxbit(netName,hxClass,clsPath));
            case TInst(_,[hxClass = TInst(_.get() => {name : clsString,module : clsModule},_)]):
                var netName = '${Context.getLocalModule()}_${Context.signature(hxClass)}';
                netName = netName.replace(".","_");
                final str = clsModule + "." + clsString;
                final clsPath = str.split(".");
                setupbuild(netName,() -> buildhxbit(netName,hxClass,clsPath));
            #end
            default:
                Context.error("Could not generate server net message", Context.currentPos());
                null;
        }
    }
    static function clientchoose(type:haxe.macro.Type) {
        return switch (type) {
            case TInst(_,[TInst(_.get() => {kind : KExpr(_.getValue() => s) },_), anon = _.follow() => TAnonymous(_.get() => {fields : fields})]):
                var netName = s;
                setupbuild(netName,() -> buildanonclient(netName,anon,fields));
            case TInst(_,[anon = _.follow() => TAnonymous(_.get() => {fields : fields})]):
                var netName = '${Context.getLocalModule()}_${Context.signature(anon)}';
                netName = netName.replace(".","_");
                setupbuild(netName,() -> buildanonclient(netName,anon,fields));
            // #if hxbit
            // case TInst(_,[TInst(_.get() => {kind : KExpr(_.getValue() => s) },_), hxClass = TInst(_.get() => {name : clsString,module : clsModule},_)]):
            //     final netName = s;
            //     final str = clsModule + "." + clsString;
            //     final clsPath = str.split(".");
            //     setupbuild(netName,() -> buildhxbit(netName,hxClass,clsPath));
            // case TInst(_,[hxClass = TInst(_.get() => {name : clsString,module : clsModule},_)]):
            //     var netName = '${Context.getLocalModule()}_${Context.signature(hxClass)}';
            //     netName = netName.replace(".","_");
            //     final str = clsModule + "." + clsString;
            //     final clsPath = str.split(".");
            //     setupbuild(netName,() -> buildhxbit(netName,hxClass,clsPath));
            // #end
            default:
                Context.error("Could not generate client net message",Context.currentPos());
                null;
        }
    }

    public static function buildanonclient(netName:String,anon:haxe.macro.Type,fields) {
        var type = Context.getLocalType();
        var complexAnon = Context.toComplexType(anon);
        var cls = macro class $netName {
            #if client
            public function send(data:$complexAnon,?unreliable=false) {

            }
            #end
            #if server
            #if tink_core
            public var signal(default,never):tink.CoreApi.Signal<$complexAnon>;

            var signalTrigger = new tink.CoreApi.SignalTrigger<$complexAnon>();
            #else
            var recievers:Map<String,(data:$complexAnon) -> Void> = new Map();

            public function addReceiver(ident:String,recv:(data:$complexAnon) -> Void) {
                recievers.set(ident,recv);
            }

            public function removeReceiver(ident:String) {
                recievers.remove(ident);
            }
            #end
            function receive(len:Int,plyrSent:gmod.gclass.Player) {

            }
            #end
            public function new(?recvs:Array<(data:$complexAnon) -> Void>) {
                #if server
                #if tink_core
                untyped signal = signalTrigger.asSignal();
                #end
                var i = 0;
                for (recv in recvs) {
                    #if tink_core
                    signal.handle(recv);
                    #else
                    addReciever(Std.toString(i++),recv);
                    #end
                }
                gmod.libs.NetLib.Receive($v{netName},receive);
                gmod.libs.UtilLib.AddNetworkString($v{netName});
                #end
            }
        }
        #if client
        var sendExpr = genSendExpr(anon,netName,fields,false,true);
        (cls.fields[0].kind.getParameters()[0]:Function).expr = sendExpr;
        #end
        #if server
        #if tink_core
        (cls.fields[2].kind.getParameters()[0]:Function).expr = genRecvExpr(anon,fields,true);
        #else
        (cls.fields[3].kind.getParameters()[0]:Function).expr = genRecvExpr(anon,fields,true);
        #end
        #end
        return cls;
    }


    static function buildanon(netName:String,anon:haxe.macro.Type,fields) {
        var complexAnon = Context.toComplexType(anon);
        var definedClass = macro class $netName {
            #if server

            public function send(data:$complexAnon,recv:gmod.gclass.Player,?unreliable=false) {

            }

            public function sendTable(data:$complexAnon,recv:lua.Table<Dynamic,gmod.gclass.Player>,?unreliable=false) {

            }

            public function sendFilter(data:$complexAnon,recv:gmod.gclass.CRecipientFilter,?unreliable=false) {

            }

            public function broadcast(data:$complexAnon,?unreliable=false) {

            }
            #end
            #if client
            #if tink_core
            public var signal(default,never):tink.CoreApi.Signal<$complexAnon>;

            var signalTrigger = new tink.CoreApi.SignalTrigger<$complexAnon>();
            #else
            var recievers:Map<String,(data:$complexAnon) -> Void> = new Map();

            public function addReceiver(ident:String,recv:(data:$complexAnon) -> Void) {
                recievers.set(ident,recv);
            }

            public function removeReceiver(ident:String) {
                recievers.remove(ident);
            }
            #end
            function receive() {

            }
            #end
            public function new() {
                #if client
                #if tink_core
                untyped signal = signalTrigger.asSignal();

                #end
                gmod.libs.NetLib.Receive($v{netName},receive);
                #end
                #if server
                gmod.libs.UtilLib.AddNetworkString($v{netName});
                #end
            }
        }

        #if server
        var sendExpr = genSendExpr(anon,netName,fields);
        (definedClass.fields[0].kind.getParameters()[0]:Function).expr = sendExpr;
        (definedClass.fields[1].kind.getParameters()[0]:Function).expr = sendExpr;
        (definedClass.fields[2].kind.getParameters()[0]:Function).expr = sendExpr;
        (definedClass.fields[3].kind.getParameters()[0]:Function).expr = genSendExpr(anon,netName,fields,true);
        #end
        #if client
        #if tink_core
        (definedClass.fields[2].kind.getParameters()[0]:Function).expr = genRecvExpr(anon,fields);
        #else
        (definedClass.fields[3].kind.getParameters()[0]:Function).expr = genRecvExpr(anon,fields);
        #end
        #end
        return definedClass;
    }



    static function buildhxbit(netName:String,sClass:haxe.macro.Type,clsPath:Array<String>) {
        final exprSClass:Expr = macro $p{clsPath};
        var complexSClass = Context.toComplexType(sClass);
        // trace(complexSClass);
        var cls = macro class $netName {
            var seralizer:hxbit.Serializer;
            var init:Bool = false;

#if server
            public function send(data:$complexSClass,recv:gmod.gclass.Player,?unreliable=false) {
                if (!init) return;
                final bytes = seralizer.serialize(data);
                gmod.libs.NetLib.Start($v{netName},unreliable);
                gmod.libs.NetLib.WriteData(bytes.toString(),bytes.length);
                gmod.libs.NetLib.Send(recv);
            }

            public function sendTable(data:$complexSClass,recv:lua.Table<Dynamic,gmod.gclass.Player>,?unreliable=false) {
                if (!init) return;
                final bytes = seralizer.serialize(data);
                gmod.libs.NetLib.Start($v{netName},unreliable);
                gmod.libs.NetLib.WriteData(bytes.toString(),bytes.length);
                gmod.libs.NetLib.Send(recv);
            }

            public function sendFilter(data:$complexSClass,recv:gmod.gclass.CRecipientFilter,?unreliable=false) {
                if (!init) return;
                final bytes = seralizer.serialize(data);
                gmod.libs.NetLib.Start($v{netName},unreliable);
                gmod.libs.NetLib.WriteData(bytes.toString(),bytes.length);
                gmod.libs.NetLib.Send(recv);
            }

            public function broadcast(data:$complexSClass,?unreliable=false) {
                if (!init) return;
                final bytes = seralizer.serialize(data);
                gmod.libs.NetLib.Start($v{netName},unreliable);
                gmod.libs.NetLib.WriteData(bytes.toString(),bytes.length);
                gmod.libs.NetLib.Broadcast();
            }
#end
#if client
#if tink_core
            public final signal:tink.CoreApi.Signal<$complexSClass>;

            final signalTrigger = new tink.CoreApi.SignalTrigger<$complexSClass>();
#else
            var recievers:Map<String,(data:$complexSClass) -> Void> = new Map();

            public function addReceiver(ident:String,recv:(data:$complexSClass) -> Void) {
                recievers.set(ident,recv);
            }

            public function removeReceiver(ident:String) {
                recievers.remove(ident);
            }
#end
            function receive() {
                final bytString = gmod.libs.NetLib.ReadData(gmod.libs.NetLib.BytesLeft().bytes);
                final bytes = haxe.io.Bytes.ofString(bytString);
                final result = seralizer.unserialize(bytes,$exprSClass);
                #if tink_core
                signalTrigger.trigger(result);
                #else
                for (recv in recievers) {
                    recv(result);
                }
                #end
            }
#end
            public function new(?recvs:Array<(data:$complexSClass) -> Void>) {
                gmod.libs.NetLib.Receive($v{netName},() -> {
                    trace("RECIEVED MESSAGE BEFORE INIT!!! OH GOD");
                });
                gmod.libs.TimerLib.Simple(0,() -> {
                    seralizer = new hxbit.Serializer();
                    init = true;
                    #if client
                    gmod.libs.NetLib.Receive($v{netName},receive);
                    #end
                });
                #if client
                untyped signal = signalTrigger.asSignal();
                @:privateAccess tink.CoreApi.Callback.depth;
                for (recv in recvs) {
                    #if tink_core
                    signal.handle(recv);
                    #end
                }
                #end
                #if server
                gmod.libs.UtilLib.AddNetworkString($v{netName});
                #end
            }
        }
        return cls;
    }

    static function genSendExpr(anon:haxe.macro.Type,name:String,fields:Array<ClassField>,?broadcast=false,?client=false):Expr {
        var macArray:Array<Expr> = [];
        macArray.push(macro gmod.libs.NetLib.Start($v{name},unreliable));
        var entity = Context.resolveType((macro : gmod.gclass.Entity),Context.currentPos());
        var string = Context.resolveType((macro : String),Context.currentPos());
        var vector = Context.resolveType((macro : gmod.gclass.Vector),Context.currentPos());
        var angle = Context.resolveType((macro : gmod.gclass.Angle),Context.currentPos());
        var int = Context.resolveType((macro : Int),Context.currentPos());
        var float = Context.resolveType((macro : Float),Context.currentPos());
        var table = Context.resolveType((macro : lua.Table.AnyTable),Context.currentPos());
        var bool = Context.resolveType((macro : Bool),Context.currentPos());
        var twoWayUni = (x:haxe.macro.Type,y:haxe.macro.Type) -> x.unify(y) && y.unify(x);
        for (field in fields) {
            var name = field.name;
            switch (field.type) {
                case twoWayUni(_,entity) => true:
                    macArray.push(macro gmod.libs.NetLib.WriteEntity(data.$name));
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
                case twoWayUni(_,string) => true:
                    macArray.push(macro gmod.libs.NetLib.WriteString(data.$name));
                default:
                    trace('could not generate constructer field:${field.name}');
                    trace(field.type.toString());
            }
        }
        if (broadcast) {
            macArray.push(macro gmod.libs.NetLib.Broadcast());
        } else if (client) {
            macArray.push(macro gmod.libs.NetLib.SendToServer());
        } else {
            macArray.push(macro gmod.libs.NetLib.Send(recv));
        }
        return macro $b{macArray};
    }

    static function genRecvExpr(anon:haxe.macro.Type,fields:Array<ClassField>,?client=false):Expr {
        var recvAnon:Array<ObjectField> = [];
        var entity = Context.resolveType((macro : gmod.gclass.Entity),Context.currentPos());
        var string = Context.resolveType((macro : String),Context.currentPos());
        var vector = Context.resolveType((macro : gmod.gclass.Vector),Context.currentPos());
        var angle = Context.resolveType((macro : gmod.gclass.Angle),Context.currentPos());
        var int = Context.resolveType((macro : Int),Context.currentPos());
        var float = Context.resolveType((macro : Float),Context.currentPos());
        var table = Context.resolveType((macro : lua.Table.AnyTable),Context.currentPos());
        var bool = Context.resolveType((macro : Bool),Context.currentPos());
        var twoWayUni = (x:haxe.macro.Type,y:haxe.macro.Type) -> x.unify(y) && y.unify(x);
        for (field in fields) {
            var name = field.name;
            if (name == "_sentPlayer") continue;
            switch (field.type) {
                case twoWayUni(_,int) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadInt(32)});
                case _.unify(table) => true:
                    recvAnon.push({field : name, expr : macro cast gmod.libs.NetLib.ReadTable()});
                case twoWayUni(_,float) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadFloat()});
                case twoWayUni(_,vector) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadVector()});
                case twoWayUni(_,angle) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadAngle()});
                case twoWayUni(_,bool) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadBool()});
                case twoWayUni(_,entity) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadEntity()});
                case twoWayUni(_,string) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadString()});
                default:
                    trace('could not generate reciever field:${field.name}');
                    trace(field.type.toString());
            }
        }
        if (client) {
            recvAnon.push({field : "_sentPlayer", expr : macro plyrSent});
        }
        var objdel:Expr = {
            expr : EObjectDecl(recvAnon),
            pos : Context.currentPos(),
        }
        #if tink_core
        var finalExpr= macro {signalTrigger.trigger($e{objdel});};
        #else
        var finalExpr = macro {
            var data = $e{objdel};
            for (recv in recievers) {
                recv(data);
            }
        };
        #end
        return finalExpr;
    }
}
#end
