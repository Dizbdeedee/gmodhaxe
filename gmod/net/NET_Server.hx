package gmod.net;

/**
    Generate a net message by adding a variable to any class
    i.e

    ```haxe 
    static var netmessage = new NET_Server<"exampleMessage",{name : String}>;
    ```
**/
@:genericBuild(gmod.macros.Networking.build())
extern class NET_Server<Const,Data> {
}


