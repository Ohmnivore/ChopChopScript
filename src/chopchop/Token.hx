package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class Token
{
	public var type:Int;
	public var text:String;
	public var nameArr:Array<String>;
	
	public function new(T:Int, Text:String, NameArr:Array<String>)
	{
		type = T;
		text = Text;
		nameArr = NameArr;
	}
	
	public function toString():String
	{
		return text + ": [" + nameArr[type] + "]";
	}
}