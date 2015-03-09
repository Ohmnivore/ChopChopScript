package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class ConstAST extends AST
{
	public var value:Dynamic;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		setValue();
	}
	
	private function setValue():Void
	{
		
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		return value;
	}
}