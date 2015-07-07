package script;

class Token
{
	public var type:Int;
	public var text:String;
	public var name:String;
	
	public function new(T:Int, Text:String, Name:String)
	{
		type = T;
		text = Text;
		name = Name;
	}
	
	public function toString():String
	{
		return text + ": [" + name + "]";
	}
}