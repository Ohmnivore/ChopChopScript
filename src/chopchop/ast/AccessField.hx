package chopchop.ast;

import chopchop.ChopInterp;
import chopchop.Symbol;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class AccessField extends BinAST
{
	public var isValue:Bool = true;
	
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		if (isValue)
		{
			Reflect.setField(left, "isValue", true);
			return Reflect.getProperty(left.walk(I), right.token.text);
		}
		else
		{
			Reflect.setField(left, "isValue", true);
			return new Access(left.walk(I), right.token.text);
		}
	}
}

class Access
{
	public var oldValue:Dynamic;
	public var newName:String;
	
	public function new(OldValue:Dynamic, NewName:String)
	{
		oldValue = OldValue;
		newName = NewName;
	}
	
	public function toString():String
	{
		return oldValue.toString() + "." + newName;
	}
}