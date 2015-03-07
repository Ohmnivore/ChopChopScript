package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class If extends AST
{
	public var condition:AST;
	public var ifTrue:Array<AST>;
	public var ifFalse:Array<AST>;
	
	public function new(T:Token, Condition:AST, IfTrue:Array<AST>, IfFalse:Array<AST>) 
	{
		super(T, []);
		
		condition = Condition;
		ifTrue = IfTrue;
		ifFalse = IfFalse;
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var last:Dynamic = null;
		if (condition.walk(I) == true)
		{
			I.newScope();
			for (ast in ifTrue)
			{
				last = ast.walk(I);
			}
			I.oldScope();
		}
		else if (ifFalse != null && ifFalse.length > 0)
		{
			I.newScope();
			for (ast in ifFalse)
			{
				last = ast.walk(I);
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
		for (ast in ifTrue)
		{
			ret += AST.indent(ast.toString());
		}
		ret += "\n";
		if (ifFalse != null)
		{
			for (ast in ifFalse)
			{
				ret += AST.indent(ast.toString());
			}
		}
		
		return ret;
	}
}