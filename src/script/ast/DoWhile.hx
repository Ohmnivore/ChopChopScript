package script.ast;

import script.ScriptInterp;
import script.Symbol;

/**
 * ...
 * @author Ohmnivore
 */
class DoWhile extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var cond:AST = children[0];
		var block:AST = children[1];
		
		var last:Dynamic = null;
		do
		{
			last = block.walk(I);
			if (last == Break)
				break;
			//else if (last == Continue)
				//continue;
		}
		while (cond.walk(I) == true)
		
		return last;
	}
}