package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class IntV extends ConstAST
{
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
	
	override function setValue():Void 
	{
		value = Std.parseInt(token.text);
	}
}