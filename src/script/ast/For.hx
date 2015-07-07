package script.ast;

import script.ScriptInterp;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class For extends AST
{
	public var varName:String;
	public var iter:AST;
	public var toIter:Dynamic;
	public var body:Array<AST>;
	
	public function new(Text:String, VarName:String, Iter:AST, Body:Array<AST>) 
	{
		super(Text, []);
		
		varName = VarName;
		iter = Iter;
		body = Body;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var last:Dynamic = null;
		var i:Int = 0;
		//while (doLoop && condition.walk(I) == true)
		//while (i < )
		//for (a in cast 
		
		var iterable:Array<Dynamic> = cast toIter;
		for (i in iterable.iterator)
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