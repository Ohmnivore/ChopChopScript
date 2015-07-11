package script.ast;
import script.ScriptInterp;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Equal extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		priority = 7;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var l:Dynamic = left.walk(I);
		var r:Dynamic = right.walk(I);
		
		return l == r;
	}
}