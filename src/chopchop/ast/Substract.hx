package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Substract extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var l:Float = cast left.walk(I);
		var r:Float = cast right.walk(I);
		
		return l - r;
	}
}