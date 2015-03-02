package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class Lexer
{
	public static inline var EOF_STR:String = "EOF";
	public static inline var EOF:Int = 1;
	public static var tokenNames:Array<String> = ["n/a", "EOF"];
	
	private var input:String;
	public var p:Int = 0;
	private var c:String;
	
	public function new(Input:String) 
	{
		input = Input;
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
		return new Token(Lexer.EOF, Lexer.EOF_STR, tokenNames);
	}
	
	public function getTokenName(T:Int):String
	{
		return "";
	}
}