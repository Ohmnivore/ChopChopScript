package script.ast;

import script.ast.AccessField.Access;
import script.Symbol;
import script.Token;
import script.ScriptInterp;

/**
 * ...
 * @author Ohmnivore
 */
class Assign extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		rightAssociative = true;
		priority = 1;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		Reflect.setField(left, "isValue", false);
		var l:Access = cast left.walk(I);
		var val:Dynamic = right.walk(I);
		Reflect.setProperty(l.oldValue, l.newName, val);
		
		return val;
	}
}