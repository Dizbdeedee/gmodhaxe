package gmod.macros;

#if client

@:PanelHelper
@:autoBuild(gmod.macros.PanelMacroOverride.build())
class PanelHelper<T:Panel> {
    public final self:T;

    @:noCompletion
    function new(x:T) {
        self = x;
        
    }

}

#end

