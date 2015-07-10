package script.ast;

import script.ScriptInterp;
import script.Symbol;

/**
 * ...
 * @author Ohmnivore
 */
class If extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		isOperator = true;
		rightAssociative = true;
		argCount = 2;
		priority = 15;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var cond:AST = children[0];
		var block:AST = children[1];
		
		if (cond.walk(I) == true)
			return block.walk(I);
		return null;
	}
}