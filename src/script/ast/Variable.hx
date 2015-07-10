package script.ast;

import script.ScriptInterp;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Variable extends AST
{
	public var isValue:Bool = true;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		if (isValue)
			return I.curScope.resolve(text).value;
		else
		{
			return new VariableAccess(I.curScope.resolve(text), "value");
		}
	}
}