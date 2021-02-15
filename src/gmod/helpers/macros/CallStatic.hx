 
package gmod.helpers.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;
#end

class CallStatic {

    public static macro function callStatic(func:haxe.macro.Expr.ExprOf<Dynamic>,args:Array<haxe.macro.Expr>) {
        final typ:ComplexType = Context.toComplexType(Context.typeof(func));
        return macro {
            final __fun:Dynamic = @:luaDotMethod cast $func;
            (__fun : $typ)($a{args});
        }
    }
}
