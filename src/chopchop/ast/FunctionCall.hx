package chopchop.ast;
import chopchop.ast.AccessField.Access;
import chopchop.ChopInterp;
import chopchop.Symbol;

/**
 * ...
 * @author Ohmnivore
 */
class FunctionCall extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var args:Array<Dynamic> = [];
		for (arg in children)
		{
			args.push(arg.walk(I));
		}
		
		if (Std.is(right, AccessField))
		{
			Reflect.setField(right, "isValue", false);
			var r:Access = cast right.walk(I);
			return Reflect.callMethod(r.oldValue, Reflect.field(r.oldValue, r.newName), args);
		}
		else if (Std.is(right, Variable))
		{
			var s:Symbol = I.curScope.resolve(text);
			return Reflect.callMethod(s, Reflect.field(s, "value"), args);
		}
		else
		{
			var r:Dynamic = right.walk(I);
			return Reflect.callMethod(r, text, args);
		}
	}
}