package script.ast ;

/**
 * ...
 * @author Ohmnivore
 */
class AST
{
	public var text:String;
	public var children:Array<AST> = [];
	
	public var argCount:Int = 0;
	public var isOperator:Bool = false;
	public var canNest:Bool = false;
	public var rightAssociative:Bool = false;
	public var priority:Int = 0;
	
	private static function indent(S:String):String
	{
		var ret:String = "";
		for (s in S.split("\n"))
		{
			ret += "\n\t" + s;
		}
		return ret;
	}
	
	public function new(Text:String, Children:Array<AST>)
	{
		text = Text;
		children = Children;
	}
	
	public function walk(I:ScriptInterp):Dynamic
	{
		return null;
	}
	
	public function allSet():Void
	{
		
	}
	
	public function toString():String
	{
		var ret:String = getRep();
		for (c in children)
		{
			if (c != null)
				ret += AST.indent(c.toString());
		}
		
		return ret;
	}
	private function getRep():String
	{
		var className:String = Type.getClassName(Type.getClass(this));
		return text + " : " + className.substr(className.lastIndexOf(".") + 1);
		return "";
	}
}