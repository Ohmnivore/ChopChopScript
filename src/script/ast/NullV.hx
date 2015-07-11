package script.ast;

import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class NullV extends ConstAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override function setValue():Void 
	{
		value = null;
	}
}