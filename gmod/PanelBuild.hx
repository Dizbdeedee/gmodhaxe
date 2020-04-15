package gmod;

#if client
@:genericBuild(gmod.macros.PanelMacro.build())
@:keepSub
class PanelBuild<T:Panel> {

}
#else
extern class PanelBuild<X> {

}
#end
