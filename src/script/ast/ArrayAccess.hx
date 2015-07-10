package script.ast;
import script.ScriptInterp;

/**
 * ...
 * @author Ohmnivore
 */
class ArrayAccess extends Access
{
	public var index:Int;
	
	public function new(OldValue:Dynamic, Index:Int)
	{
		super(OldValue);
		index = Index;
	}
	
	public function toString():String
	{
		return oldValue.toString() + "[" + index + "]";
	}
	
	override public function setValue(V:Dynamic):Void 
	{
		oldValue[index] = V;
	}
	
	override public function getVal():Dynamic
	{
		return oldValue[index];
	}
}