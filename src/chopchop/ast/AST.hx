package chopchop.ast ;

/**
 * ...
 * @author Ohmnivore
 */
class AST
{
	public var token:Token;
	public var children:Array<AST> = [];
	
	public function new(T:Token, Children:Array<AST>)
	{
		token = T;
		children = Children;
	}
}