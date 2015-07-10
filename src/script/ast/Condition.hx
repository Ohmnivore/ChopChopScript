package script.ast;

/**
 * ...
 * @author Ohmnivore
 */
class Condition extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		return children[0].walk(I) == true;
	}
}