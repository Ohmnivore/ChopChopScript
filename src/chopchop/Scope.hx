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
	
	public function define(S:Symbol):Void
	{
		symbols.set(S.name, S);
	}
	
	public function resolve(Name:String):Symbol
	{
		var s:Symbol = symbols.get(Name);
		if (s == null && parent != null)
			return parent.resolve(Name);
		return s;
	}
}