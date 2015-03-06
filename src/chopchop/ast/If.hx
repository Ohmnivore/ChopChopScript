package chopchop.ast;

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