package script.ast;

import script.ScriptInterp;
import script.Symbol;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class AccessArray extends BinAST
{
	public var isValue:Bool = true;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		priority = 14;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		Reflect.setField(left, "isValue", true);
		return doWalk(I);
	}
	
	private function doWalk(I:ScriptInterp):Dynamic
	{
		if (isValue)
		{
			return left.walk(I)[right.walk(I)];
		}
		else
		{
			return new script.ast.ArrayAccess(cast left.walk(I), cast right.walk(I));
		}
	}
}