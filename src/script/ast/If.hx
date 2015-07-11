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
		shouldPop = true;
		isOperator = true;
		rightAssociative = true;
		argCount = 2;
		priority = 1;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var cond:AST = children[0];
		var block:AST = children[1];
		var theRest:Array<AST> = children.slice(2, children.length);
		
		if (cond.walk(I) == true)
			return block.walk(I);
		else
		{
			var i:Int = 0;
			while (i < theRest.length)
			{
				var a1:AST = theRest[i];
				var a2:AST = null;
				if (i < theRest.length + 1)
					a2 = theRest[i + 1];
				if (Type.getClass(a1) == Condition)
				{
					if (a1.walk(I) == true)
					{
						return a2.walk(I);
					}
					else
					{
						i++;
					}
				}
				else
				{
					return a1.walk(I);
				}
				i++;
			}
		}
		return null;
	}
}