package script.ast;

/**
 * ...
 * @author Ohmnivore
 */
class UnaryAST extends AST
{
	public var target:AST;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		isOperator = true;
		rightAssociative = true;
		argCount = 1;
	}
	
	override public function allSet():Void 
	{
		target = children[0];
	}
}