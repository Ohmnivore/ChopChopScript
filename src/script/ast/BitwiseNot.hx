package script.ast;
import script.ScriptInterp;

/**
 * ...
 * @author Ohmnivore
 */
class BitwiseNot extends UnaryAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		priority = 13;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		return ~target.walk(I);
	}
}