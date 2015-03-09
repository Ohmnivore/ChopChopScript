package chopchop.ast;
import chopchop.ChopInterp;

/**
 * ...
 * @author Ohmnivore
 */
class UnaryBitwiseNot extends UnaryAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		return ~target.walk(I);
	}
}