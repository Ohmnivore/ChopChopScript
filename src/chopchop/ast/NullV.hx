package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class NullV extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		return null;
	}
}