package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class FloatV extends ConstAST
{
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
	
	override function setValue():Void 
	{
		value = Std.parseFloat(token.text);
	}
}