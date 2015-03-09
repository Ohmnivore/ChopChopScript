package chopchop;
import chopchop.ast.AST;

/**
 * ...
 * @author Ohmnivore
 */
class Operator
{
	private static inline var MAX_PRECEDENCE:Int = 17;
	public var rightAssociative:Bool;
	public var precedence:Int;
	public var numOfArgs:Int;
	public var ast:Class<AST>;
	
	public function new(Ast:Class<AST>, RightAssociative:Bool, Precedence:Int, NumOfArgs:Int = 2) 
	{
		ast = Ast;
		rightAssociative = RightAssociative;
		//precedence = Precedence;
		precedence = MAX_PRECEDENCE - Precedence;
		numOfArgs = NumOfArgs;
	}
	
	public function compare(Op:Operator):Int
	{
		if (Op.precedence > precedence)
			return -1;
		else if (Op.precedence < precedence)
			return 1;
		else
			return 0;
	}
	
	public function toString():String
	{
		return Type.getClassName(ast);
	}
}