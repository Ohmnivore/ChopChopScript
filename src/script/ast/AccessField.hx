package script.ast;

import script.ScriptInterp;
import script.Symbol;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class AccessField extends BinAST
{
	public var isValue:Bool = true;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		priority = 14;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var isFunc:Bool = Std.is(right, FunctionCall);
		if (Std.is(left, Variable) || Std.is(left, AccessField))
		{
			Reflect.setField(left, "isValue", true);
			if (isFunc)
				return cast(right, FunctionCall).walkFuncAccess(I, cast left);
			else
				return doWalk(I);
		}
		if (isFunc)
			return cast(right, FunctionCall).walkFuncDirect(I, left);
		else
			return doWalk(I);
	}
	
	private function doWalk(I:ScriptInterp):Dynamic
	{
		if (isValue)
		{
			return Reflect.getProperty(left.walk(I), right.text);
		}
		else
		{
			return new Access(left.walk(I), right.text);
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