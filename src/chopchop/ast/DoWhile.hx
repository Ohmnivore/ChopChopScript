package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class DoWhile extends While
{

	public function new(T:Token, Condition:AST, Body:Array<AST>) 
	{
		super(T, Condition, Body);
		
	}
	
}