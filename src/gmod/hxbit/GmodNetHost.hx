package gmod.hxbit;

#if hxbit
import gmod.libs.UtilLib;
import gmod.Hook.GMHook;
import gmod.libs.HookLib;
import haxe.io.Input;
import gmod.libs.NetLib;
import haxe.io.Bytes;
import hxbit.NetworkHost;
import gmod.libs.PlayerLib;
using gmod.PairTools;

/**
   To use hxbit functionality, create a new instance on both the server and client.
   This is very wip
**/
class GmodNetHost extends NetworkHost {

    static var players:Map<Int,NetworkClient> = [];

    public function new(?onConnect:(nc:NetworkClient) -> Void,
                        ?_onMessage:(nc:NetworkClient,msg:Dynamic) -> Void ) {
        super();
        if (onConnect == null) onConnect = (a) -> {};
        if (_onMessage == null) _onMessage = (a,b) -> {};
        onMessage = _onMessage;
        #if server
        UtilLib.AddNetworkString("hxbit");
        wait(onConnect);
        #elseif client
        connect(onConnect);
        #end
        defaultLogger();
    }
    #if server
    public function wait(onConnect:(nc:NetworkClient) -> Void) {
        isAuth = false;
        self = new Client(this,null);
        HookLib.Add(GMHook.PlayerInitialSpawn,"hxbitconnect",(ply,tran) -> {
            var c = new Client(this,ply);
            pendingClients.push(c);
            onConnect(c);
        });
        HookLib.Add(GMHook.PlayerDisconnected,"hxbitdisconnect",(ply) -> {
                if (players.exists(ply.UserID())) {
                    var cl = players.get(ply.UserID());
                    cl.stop();
                }
            });
        isAuth = true;
        for (ply in PlayerLib.GetAll()) {
            var c = new Client(this,ply);
            pendingClients.push(c);
            onConnect(c);
        }
        makeAlive();
        onMessage = function (client:NetworkClient,msg:Int) {
            if (msg == 1024 && pendingClients.contains(client)) {
                client.sync();
            }
        }
    }
    #end
    
    #if client
    public function connect(onConnect:(nc:NetworkClient) -> Void) {
        isAuth = false;
        self = new Client(this,null);
        clients = [self];
        self.sync();
        self.sendMessage(1024);
        makeAlive();
        onConnect(self);
    }
    #end
}

class GmodNetworkInput extends haxe.io.Input {
    override function readInt32():Int {
        var len = NetLib.ReadUInt(32);
        return len;
    }
    override function readByte():Int {
        var len = NetLib.ReadUInt(8);
        return len;
    }

    public function new() {
        //....
    }
}

class Client extends NetworkClient {

    #if server
    final ply:Player;
    #end

    public function new(host:NetworkHost,?ply:Player) {
        super(host);
        NetLib.Receive("hxbit",recieve);
        #if server
        this.ply = ply;
        #end 
    }

    function recieve (len:Int) {
        var ni = new GmodNetworkInput();
        readData(ni,cast NetLib.BytesLeft().a);
    }

    override function send(bytes:Bytes) {
        NetLib.Start("hxbit",true);
        NetLib.WriteUInt(bytes.length,32);
        for (byt in bytes.getData()) {
            NetLib.WriteUInt(byt,8);
        }
        #if server
        NetLib.Send(ply);
        #elseif client
        NetLib.SendToServer();
        #end
    }
}
#end
