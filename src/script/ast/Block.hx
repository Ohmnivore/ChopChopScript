package script.ast;

/**
 * ...
 * @author Ohmnivore
 */
class Block extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		I.newScope();
		var ret:Dynamic = null;
		for (c in children)
		{
			ret = c.walk(I);
			if (ret == Break || ret == Continue)
			{
				I.oldScope();
				return ret;
			}
		}
		I.oldScope();
		
		return ret;
	}
}