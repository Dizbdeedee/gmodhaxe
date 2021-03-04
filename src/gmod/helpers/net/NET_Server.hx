package gmod.helpers.net;

/**
    Generate a net message by adding a variable to any class
    i.e

    ```haxe 
    static var netmessage = new NET_Server<"exampleMessage",{name : String}>;
    ```
**/
@:genericBuild(gmod.helpers.macros.Networking.build())
extern class NET_Server<Const,Data> {
}

/**
	Mangled name version of NET_Server
**/
@:genericBuild(gmod.helpers.macros.Networking.build())
extern class NET_Sv<Data> {

} 

