package chopchop.ast ;

/**
 * ...
 * @author Ohmnivore
 */
class AST
{
	public var token:Token;
	public var children:Array<AST> = [];
	
	private static function indent(S:String):String
	{
		var ret:String = "";
		for (s in S.split("\n"))
		{
			ret += "\n\t" + s;
		}
		return ret;
	}
	
	public function new(T:Token, Children:Array<AST>)
	{
		token = T;
		children = Children;
	}
	
	public function toString():String
	{
		var ret:String = getRep();
		for (c in children)
		{
			ret += AST.indent(c.toString());
		}
		
		return ret;
	}
	private function getRep():String
	{
		var className:String = Type.getClassName(Type.getClass(this));
		return token.text + " : " + className.substr(className.lastIndexOf(".") + 1);
	}
}