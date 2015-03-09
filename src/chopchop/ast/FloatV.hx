package chopchop.ast;

import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class FloatV extends ConstAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override function setValue():Void 
	{
		value = Std.parseFloat(text);
	}
}