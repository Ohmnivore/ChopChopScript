package script.ast;
import script.ScriptInterp;

/**
 * ...
 * @author Ohmnivore
 */
class VariableAccess extends Access
{
	public var newName:String;
	
	public function new(OldValue:Dynamic, NewName:String)
	{
		super(OldValue);
		newName = NewName;
	}
	
	public function toString():String
	{
		return oldValue.toString() + "." + newName;
	}
	
	override public function setValue(V:Dynamic):Void 
	{
		Reflect.setProperty(oldValue, newName, V);
	}
	
	override public function getVal():Dynamic
	{
		return Reflect.getProperty(oldValue, newName);
	}
}