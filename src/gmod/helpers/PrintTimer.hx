package gmod.helpers;

#if !macro
import gmod.Gmod;
#end
/**
    See `PrintTimer.print_time`
**/
class PrintTimer {

    #if !macro
    static var timersArr:Array<Float> = [];

    
    static function _printTimer(ident:Int,time:Float,run:() -> Void) {
        final timer = timersArr[ident];
        if (timer != null) {
            if (Gmod.SysTime() > timer) {
                run();
                timersArr[ident] = Gmod.SysTime() + time;
            }
        } else {
            run();
            timersArr[ident] = Gmod.SysTime() + time;
        }
    }
    #end


    #if macro
    static var nextPrinter = 0;
    #end

    /**
        Extremely useful for print debugging think hooks or timers
        
        
        Example:


        `print_time(5,() -> trace(my_important_variable));`
        
        
        will only print your important variable every 5 seconds - no matter how often the hook runs. Can also be used for other purposes
    **/
    public static macro function print_time(time:Float,run:haxe.macro.Expr) {
        return macro @:privateAccess gmod.helpers.PrintTimer._printTimer($v{nextPrinter++},$v{time},$run);
    }
}
