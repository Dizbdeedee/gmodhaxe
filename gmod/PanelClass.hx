package gmod;


import gmod.panels.*;
#if client
enum abstract PanelClass<T:Panel>(Dynamic) from String to String {
    public inline function new(name:String) {
        this = name;
    }
}

enum abstract GMPanels<T:Panel>(PanelClass<T>) to String to PanelClass<T> {
    var DModelPanel:GMPanels<DModelPanel>;
}
#end
