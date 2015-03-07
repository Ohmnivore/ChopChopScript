package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Bigger extends BinAST
{
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var l:Float = cast left.walk(I);
		var r:Float = cast right.walk(I);
		
		return l > r;
	}
}