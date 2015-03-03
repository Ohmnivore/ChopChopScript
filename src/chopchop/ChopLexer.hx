package chopchop;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class ChopLexer extends Lexer
{
	//SYNTAX
	public static var SEMI_COLON:Int = Lexer.getID();
	
	//MATH OPS
	public static var PLUS:Int = Lexer.getID();
	public static var MINUS:Int = Lexer.getID();
	public static var MULT:Int = Lexer.getID();
	public static var DIV:Int = Lexer.getID();
	public static var MOD:Int = Lexer.getID();
	
	//OTHER OPS
	public static var ASSIGN:Int = Lexer.getID();
	
	//TYPES
	public static var VARIABLE:Int = Lexer.getID();
	public static var INT:Int = Lexer.getID();
	public static var FLOAT:Int = Lexer.getID();
	
	public var tokenNames:Array<String> = ["n/a", "EOF"];
	public function new(Input:String) 
	{
		var fields:Array<String> = Type.getClassFields(ChopLexer);
		for (i in 0...30)
		{
			tokenNames.push(Lexer.EOF_STR);
		}
		for (field in Type.getClassFields(ChopLexer))
		{
			tokenNames[Reflect.field(ChopLexer, field)] = field;
		}
		
		super(Input);
	}
	
	override public function getTokenName(T:Int):String 
	{
		return tokenNames[T];
	}
	
	private function quickConsume(T:Int, ?Text:String):Token
	{
		var text:String = c;
		consume();
		
		if (Text == null)
			return new Token(T, text, tokenNames);
		else
			return new Token(T, Text, tokenNames);
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
			else if (c == ";")
			{
				return quickConsume(SEMI_COLON);
			}
			else if (c == "+")
			{
				return quickConsume(PLUS);
			}
			else if (c == "-")
			{
				return quickConsume(MINUS);
			}
			else if (c == "*")
			{
				return quickConsume(MULT);
			}
			else if (c == "/")
			{
				return quickConsume(DIV);
			}
			else if (c == "%")
			{
				return quickConsume(MOD);
			}
			else if (c == "=")
			{
				return quickConsume(ASSIGN);
			}
			else if (isDigit(c))
			{
				return NUM();
			}
			else
			{
				return VAR();
			}
		}
		
		return new Token(Lexer.EOF, Lexer.EOF_STR, tokenNames);
	}
	
	private function WS():Void
	{
		while (c == " " || c == "\t" || c == "\n" || c == "\r")
		{
			consume();
		}
	}
	
	private function NUM():Token
	{
		var isInt:Bool = true;
		var buf:String = "";
		do
		{
			if (c == ".")
				isInt = false;
			buf += c;
			consume();
		}
		while (isDigit(c) || c == ".");
		if (isInt)
			return new Token(INT, buf, tokenNames);
		else
			return new Token(FLOAT, buf, tokenNames);
	}
	private function isDigit(S:String):Bool
	{
		var code:Int = S.charCodeAt(0);
		return code >= 48 && code <= 57;
	}
	
	private function VAR():Token
	{
		var buf:String = "";
		do
		{
			buf += c;
			consume();
		}
		while (isLETTER());
		return new Token(VARIABLE, buf, tokenNames);
	}
	private function isLETTER():Bool
	{
		var code:Int = c.charCodeAt(0);
		
		return code >= 'a'.charCodeAt(0) && code <= 'z'.charCodeAt(0) ||
			code >= 'A'.charCodeAt(0) && code <= 'Z'.charCodeAt(0);
	}
}