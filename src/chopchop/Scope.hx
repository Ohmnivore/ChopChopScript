package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class Scope
{
	public var name:String;
	public var parent:Scope;
	private var symbols:Map<String, Symbol>;
	
	public function new(Parent:Scope = null) 
	{
		parent = Parent;
		symbols = new Map<String, Symbol>();
	}
	
	public function define(Name:String, Value:Dynamic):Void
	{
		if (!symbols.exists(Name))
			symbols.set(Name, new Symbol(Name, Value));
		else
			symbols.get(Name).value = Value;
	}
	
	public function resolve(Name:String):Symbol
	{
		var d:Dynamic = symbols.get(Name);
		if (d == null && parent != null)
			return parent.resolve(Name);
		return d;
	}
}