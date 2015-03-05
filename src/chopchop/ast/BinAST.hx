package chopchop.ast;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class BinAST extends AST
{
	public var left:AST;
	public var right:AST;
	
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
		left = Children[0];
		right = Children[0];
	}
}