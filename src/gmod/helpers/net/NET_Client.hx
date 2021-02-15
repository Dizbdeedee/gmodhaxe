package gmod.helpers;

/**
    Extend your data typedef with this
**/
typedef NET_CL_Message = {
    #if server
    /**
        The player who sent the message
    **/
    var _sentPlayer:gmod.gclass.Player;
    #end
}

@:genericBuild(gmod.helpers.macros.Networking.buildclient())
extern class NET_Client<Const:String,X:NET_CL_Message> {

} 