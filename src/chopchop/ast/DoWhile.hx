package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class DoWhile extends While
{
	private var last:Dynamic = null;
	
	public function new(T:Token, Condition:AST, Body:Array<AST>) 
	{
		super(T, Condition, Body);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var doLoop:Bool = true;
		do
		{
			I.newScope();
			var i:Int = 0;
			while (i < body.length)
			{
				var ast:AST = body[i];
				last = ast.walk(I);
				
				if (I.doContinue)
				{
					I.doContinue = false;
					break;
				}
				else if (I.doBreak)
				{
					I.doBreak = false;
					doLoop = false;
					break;
				}
				i++;
			}
			I.oldScope();
		}
		while (condition.walk(I) == true && doLoop);
		
		return last;
	}
}