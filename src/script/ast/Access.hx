package script.ast;
import script.ScriptInterp;

/**
 * ...
 * @author Ohmnivore
 */
class Access
{
	public var oldValue:Dynamic;
	
	public function new(OldValue:Dynamic)
	{
		oldValue = OldValue;
	}
	
	public function setValue(V:Dynamic):Void
	{
		
	}
	
	public function getVal():Dynamic
	{
		return null;
	}
}