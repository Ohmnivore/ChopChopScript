package script.ast;

import script.ScriptInterp;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class BoolV extends ConstAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override function setValue():Void 
	{
		if (text == "true")
			value = true;
		else
			value = false;
	}
}