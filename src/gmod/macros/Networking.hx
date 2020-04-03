package gmod.macros;

import haxe.macro.Type.ClassField;
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;
using haxe.macro.PositionTools;

class Networking {
    
    public static function build():ComplexType {
        var type = Context.getLocalType();
        var netName:String;
        var anon:haxe.macro.Type;
        var fields:Array<ClassField>;
        
        switch (type) {
            case TInst(_,[TInst(_.get() => {kind : KExpr(_.getValue() => s) },_), tdef = _.follow() => a = TAnonymous(_.get() => {fields : f})]):
                netName = s;
                fields = f;
                anon = tdef;
            default:
                trace("Could not generate net message");
                return null;
        }
        var complexAnon = Context.toComplexType(anon);
        var clsName = 'NETMESSAGE_$netName';
        var cls = macro class $clsName {
            #if server

            public function send(data:$complexAnon,recv:gmod.gclass.Player,?unreliable=false) {

            }

            public function sendTable(data:$complexAnon,recv:lua.Table<Dynamic,gmod.gclass.Player>,?unreliable=false) {

            }

            public function sendFilter(data:$complexAnon,recv:gmod.gclass.CRecipientFilter,?unreliable=false) {

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
                untyped signal = signalTrigger.asSignal();
                gmod.libs.NetLib.Receive($v{netName},receive);
                #end
                #if server
                gmod.libs.UtilLib.AddNetworkString($v{netName});
                #end
            }
        }
        
        #if server
        var sendExpr = genSendExpr(anon,netName,fields);
        (cls.fields[0].kind.getParameters()[0]:Function).expr = sendExpr;
        (cls.fields[1].kind.getParameters()[0]:Function).expr = sendExpr;
        (cls.fields[2].kind.getParameters()[0]:Function).expr = sendExpr;
        #end
        #if client
        #if tink_core
        (cls.fields[2].kind.getParameters()[0]:Function).expr = genRecvExpr(anon,fields);
        #else
        (cls.fields[3].kind.getParameters()[0]:Function).expr = genRecvExpr(anon,fields);
        #end
        #end
        Context.defineType(cls);
        
        return TPath({name : clsName,pack: []});
    }

    static function genSendExpr(anon:haxe.macro.Type,name:String,fields:Array<ClassField>):Expr {
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
                    trace(field.type.toString());
            }
        }
        macArray.push(macro gmod.libs.NetLib.Send(recv));
        return macro $b{macArray};
    }

    static function genRecvExpr(anon:haxe.macro.Type,fields:Array<ClassField>):Expr { 
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
        // var mac:EObjectDecl = EObjectDecl()
    
        for (field in fields) {
            var name = field.name;
            //trace(name);
            switch (field.type) {
                case twoWayUni(_,int) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadInt(32)});
                case twoWayUni(_,string) => true:
                    recvAnon.push({field : name, expr : macro gmod.libs.NetLib.ReadString()});
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
                default:
                    trace('could not generate reciever field:${field.name}');
                    trace(field.type.toString());
            }
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
