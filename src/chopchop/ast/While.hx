package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class While extends AST
{
	public var condition:AST;
	public var body:Array<AST>;
	
	public function new(T:Token, Condition:AST, Body:Array<AST>) 
	{
		super(T, []);
		
		condition = Condition;
		body = Body;
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