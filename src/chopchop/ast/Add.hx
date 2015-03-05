package chopchop.ast;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Add extends BinAST
{
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
}