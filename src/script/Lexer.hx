package script;

class Lexer
{
	public static inline var EOF_STR:String = "EOF";
	public static var EOF:Int = 1;
	
	private var input:String;
	public var p:Int = 0;
	private var c:String;
	
	public function new(Input:String) 
	{
		input = Input;
		reset();
	}
	
	private static var curID:Int = 1;
	public static function getID():Int
	{
		curID += 1;
		return curID;
	}
	
	public function reset():Void
	{
		p = 0;
		c = input.charAt(p);
	}
	
	public function consume():Void
	{
		p++;
		
        if (p >= input.length)
			c = EOF_STR;
        else
			c = input.charAt(p);
	}
	
	public function match(X:String):Void
	{
        if (c == X)
			consume();
        else
			throw "expecting " + X + "; found " + c;
    }
	
	public function nextToken():Token
	{
		return new Token(Lexer.EOF, Lexer.EOF_STR, null);
	}
	
	public function getTokenName(T:Int):String
	{
		return "";
	}
	
	private function doThrow(Msg:String):Void
	{
		throw Msg + " at " + p;
	}
}