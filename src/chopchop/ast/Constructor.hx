package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Constructor extends BinAST
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
		
		var ret:Dynamic = Type.createInstance(Type.resolveClass(right.text), args);
		trace(right.text, ret);
		return ret;
	}
}