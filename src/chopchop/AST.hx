package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class AST
{
	public var token:Token;
	public var children:Array<AST> = [];
	
	public function new(T:Token) 
	{
		token = T;
	}
}