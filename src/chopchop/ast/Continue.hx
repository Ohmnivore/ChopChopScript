package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Continue extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		I.doContinue = true;
		
		return super.walk(I);
	}
}