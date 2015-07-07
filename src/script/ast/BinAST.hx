package script.ast;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class BinAST extends AST
{
	public var left:AST;
	public var right:AST;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		argCount = 2;
		isOperator = true;
	}
	
	override public function allSet():Void 
	{
		left = children[0];
		right = children[1];
	}
}