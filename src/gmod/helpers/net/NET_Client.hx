package gmod.helpers.net;

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

@:genericBuild(gmod.helpers.macros.Networking.build(true))
extern class NET_Client<Const:String,X:NET_CL_Message> {

}

/**
    Mangled name version of NET_Client
**/
@:genericBuild(gmod.helpers.macros.Networking.build(true))
extern class NET_Cl<X:NET_CL_Message> {

}