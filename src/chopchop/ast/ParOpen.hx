package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class ParOpen extends AST
{
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
}