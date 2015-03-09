package chopchop.ast;

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
		
		target = Children[0];
	}
}