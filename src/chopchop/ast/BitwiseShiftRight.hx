package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class BitwiseShiftRight extends BinAST
{
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var l:Int = cast left.walk(I);
		var r:Int = cast right.walk(I);
		
		return l >> r;
	}
}