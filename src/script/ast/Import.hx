package script.ast;
import script.ScriptInterp;

/**
 * ...
 * @author Ohmnivore
 */
class Import extends UnaryAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		priority = 13;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var ret:Dynamic = null;
		
		var full:String = children[0].text;
		ret = I.importClass(full);
		
		return ret;
	}
}