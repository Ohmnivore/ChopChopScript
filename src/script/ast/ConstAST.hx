package script.ast;

import script.ScriptInterp;
import script.Token;

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
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		return value;
	}
}