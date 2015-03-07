package chopchop.ast;

import chopchop.ast.AccessField.Access;
import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Variable extends AST
{
	public var isValue:Bool = true;
	
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		if (isValue)
			return I.curScope.resolve(token.text).value;
		else
			return new Access(I.curScope.resolve(token.text), "value");
	}
}