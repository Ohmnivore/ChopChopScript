package script.ast;

import script.ScriptInterp;
import script.Symbol;

/**
 * ...
 * @author Ohmnivore
 */
class While extends AST
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
		while (cond.walk(I) == true)
		{
			last = block.walk(I);
			if (last == Break)
				break;
		}
		return last;
	}
}