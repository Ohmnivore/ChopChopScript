package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class While extends AST
{
	public var condition:AST;
	public var body:Array<AST>;
	
	public function new(Text:String, Condition:AST, Body:Array<AST>) 
	{
		super(Text, []);
		
		condition = Condition;
		body = Body;
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var last:Dynamic = null;
		var doLoop:Bool = true;
		while (doLoop && condition.walk(I) == true)
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
		return last;
	}
	
	override public function toString():String 
	{
		var ret:String = getRep();
		
		ret += AST.indent(condition.toString());
		ret += "\n";
		for (ast in body)
		{
			ret += AST.indent(ast.toString());
		}
		ret += "\n";
		
		return ret;
	}
}