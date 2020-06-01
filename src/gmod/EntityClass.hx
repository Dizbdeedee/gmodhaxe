package gmod;
/**
    Represents an entity class
**/
enum abstract EntityClass<T:Entity>(Dynamic) from String to String {
    public inline function new(name:String) {
        this = name;
    }
}

enum abstract BaseEntities<T:Entity>(EntityClass<T>) to String to EntityClass<T> {
    var info_player_start:BaseEntities<Entity>;
    var npc_zombie:BaseEntities<Entity>;
}
