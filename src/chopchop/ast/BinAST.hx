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
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		left = Children[0];
		right = Children[1];
	}
}