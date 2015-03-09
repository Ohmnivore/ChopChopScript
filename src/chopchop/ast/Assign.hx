package chopchop.ast;

import chopchop.ast.AccessField.Access;
import chopchop.Symbol;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Assign extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		Reflect.setField(left, "isValue", false);
		var l:Access = cast left.walk(I);
		var val:Dynamic = right.walk(I);
		Reflect.setProperty(l.oldValue, l.newName, val);
		
		return val;
	}
}