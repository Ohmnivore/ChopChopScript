package script.ast;

import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class StringV extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		return text;
	}
}