package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class Symbol
{
	public var name:String;
	
	public function new(Name:String) 
	{
		name = Name;
	}
	
	public function toString():String
	{
		return name;
	}
}