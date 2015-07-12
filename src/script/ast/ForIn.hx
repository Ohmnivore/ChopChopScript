package script.ast;

import script.ScriptInterp;
import script.Symbol;

/**
 * ...
 * @author Ohmnivore
 */
class ForIn extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		argCount = 3;
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var name:String = children[0].text;
		var cont:Dynamic = children[1].walk(I);
		var block:AST = children[2];
		var ret:Dynamic = null;
		
		if (Std.is(cont, Array))
		{
			for (x in cast(cont, Array<Dynamic>))
			{
				I.curScope.define(name, x);
				ret = block.walk(I);
				if (ret == Break)
					break;
			}
		}
		
		return ret;
	}
}