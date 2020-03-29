package gmod;
//Requires tinkerbell core
#if tink_core
// Build your network message class using this
// @:build(gmod.macros.Networking.build())

//Use this to represent a message to be sent over the server. "A" must be an anonymous structure that contains
//transferable items i.e floats, ints entities ect. Can be things that unify with base types in both directions.
typedef NetMessageServer<A> = {}
#end