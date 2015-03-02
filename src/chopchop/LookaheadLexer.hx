package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class LookaheadLexer extends Lexer
{
	public static inline var NAME:Int = 2;
	public static inline var COMMA:Int = 3;
	public static inline var LBRACK:Int = 4;
	public static inline var RBRACK:Int = 5;
	public static inline var EQUALS:Int = 6;
	
	public static var tokenNames:Array<String> = ["n/a", "<EOF>", "NAME", "COMMA",
		"LBRACK", "RBRACK", "EQUALS"];
	
	override public function getTokenName(X:Int):String
	{
		return tokenNames[X];
	}
	
	public function new(Input:String) 
	{
		super(Input);
	}
	
	private function isLETTER():Bool
	{
		var code:Int = c.charCodeAt(0);
		
		return code >= 'a'.charCodeAt(0) && code <= 'z'.charCodeAt(0) ||
			code >= 'A'.charCodeAt(0) && code <= 'Z'.charCodeAt(0);
	}
	
	override public function nextToken():Token
	{
		while (c != Lexer.EOF_STR) //EOF
		{
			if (c == " " || c == "\t" || c == "\n" || c == "\r")
			{
				WS();
				continue;
			}
			else if (c == "=")
			{
				consume();
				return new Token(EQUALS, "=", LookaheadLexer.tokenNames);
			}
			else if (c == ",")
			{
				consume();
				return new Token(COMMA, ",", LookaheadLexer.tokenNames);
			}
			else if (c == "[")
			{
				consume();
				return new Token(LBRACK, "[", LookaheadLexer.tokenNames);
			}
			else if (c == "]")
			{
				consume();
				return new Token(RBRACK, "]", LookaheadLexer.tokenNames);
			}
			else
			{
				if (isLETTER())
					return fNAME();
                
				throw "invalid character: " + c;
			}
		}
		
		return new Token(Lexer.EOF, Lexer.EOF_STR, LookaheadLexer.tokenNames);
	}
	
	private function fNAME():Token
	{
		var buf:String = "";
		do
		{
			buf += c;
			consume();
		}
		while (isLETTER());
		
		return new Token(NAME, buf, LookaheadLexer.tokenNames);
	}
	
	private function WS():Void
	{
		while (c == " " || c == "\t" || c == "\n" || c == "\r")
		{
			consume();
		}
	}
}