package script.ast;
import script.ScriptInterp;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Or extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		priority = 3;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var l:Dynamic = left.walk(I);
		var r:Dynamic = right.walk(I);
		
		return l || r;
	}
}