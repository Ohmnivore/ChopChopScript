package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class IntV extends ConstAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override function setValue():Void 
	{
		value = Std.parseInt(text);
	}
}