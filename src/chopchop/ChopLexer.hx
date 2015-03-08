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
	public static var VARIABLE:Int = Lexer.getID();
	public static var FIELD_ACCESSSOR:Int = Lexer.getID();
	public static var OPEN_PAR:Int = Lexer.getID();
	public static var CLOSE_PAR:Int = Lexer.getID();
	public static var OPEN_BRACK:Int = Lexer.getID();
	public static var CLOSE_BRACK:Int = Lexer.getID();
	public static var OPEN_CURLY:Int = Lexer.getID();
	public static var CLOSE_CURLY:Int = Lexer.getID();
	public static var COMMA:Int = Lexer.getID();
	
	//KEYWORDS
	public static var NEW:Int = Lexer.getID();
	public static var IF:Int = Lexer.getID();
	public static var ELSE:Int = Lexer.getID();
	public static var WHILE:Int = Lexer.getID();
	public static var DO:Int = Lexer.getID();
	public static var FOR:Int = Lexer.getID();
	public static var BREAK:Int = Lexer.getID();
	public static var CONTINUE:Int = Lexer.getID();
	
	//MATH OPS
	public static var PLUS:Int = Lexer.getID();
	public static var MINUS:Int = Lexer.getID();
	public static var MULT:Int = Lexer.getID();
	public static var DIV:Int = Lexer.getID();
	public static var MOD:Int = Lexer.getID();
	
	//OTHER OPS
	public static var EQUAL:Int = Lexer.getID();
	
	//TYPES
	public static var INT:Int = Lexer.getID();
	public static var FLOAT:Int = Lexer.getID();
	public static var STRING:Int = Lexer.getID();
	public static var BOOL:Int = Lexer.getID();
	public static var NULL:Int = Lexer.getID();
	
	//MISC
	public static var SMALLER:Int = Lexer.getID();
	public static var BIGGER:Int = Lexer.getID();
	public static var AND:Int = Lexer.getID();
	public static var OR:Int = Lexer.getID();
	public static var XOR:Int = Lexer.getID();
	public static var NOT:Int = Lexer.getID();
	public static var COMPLEMENT:Int = Lexer.getID();
	
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
				return quickConsume(EQUAL);
			}
			else if (c == ".")
			{
				return quickConsume(FIELD_ACCESSSOR);
			}
			else if (c == "(")
			{
				return quickConsume(OPEN_PAR);
			}
			else if (c == ")")
			{
				return quickConsume(CLOSE_PAR);
			}
			else if (c == "[")
			{
				return quickConsume(OPEN_BRACK);
			}
			else if (c == "]")
			{
				return quickConsume(CLOSE_BRACK);
			}
			else if (c == "{")
			{
				return quickConsume(OPEN_CURLY);
			}
			else if (c == "}")
			{
				return quickConsume(CLOSE_CURLY);
			}
			else if (c == ".")
			{
				return quickConsume(COMMA);
			}
			else if (c == "<")
			{
				return quickConsume(SMALLER);
			}
			else if (c == ">")
			{
				return quickConsume(BIGGER);
			}
			else if (c == "&")
			{
				return quickConsume(AND);
			}
			else if (c == "^")
			{
				return quickConsume(XOR);
			}
			else if (c == "|")
			{
				return quickConsume(OR);
			}
			else if (c == "!")
			{
				return quickConsume(NOT);
			}
			else if (c == "~")
			{
				return quickConsume(COMPLEMENT);
			}
			else if (isQuote(c))
			{
				return STR();
			}
			else if (isDigit(c))
			{
				return NUM();
			}
			else
			{
				return PARSELONGSTRING();
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
		while (c == "." || isDigit(c));
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
	
	private function PARSELONGSTRING():Token
	{
		var buf:String = "";
		do
		{
			buf += c;
			consume();
		}
		while (isLETTER() || isDigit(c));
		
		var ret:Int = VARIABLE;
		if (buf == "true" || buf == "false")
			ret = BOOL;
		else if (buf == "new")
			ret = NEW;
		else if (buf == "if")
			ret = IF;
		else if (buf == "else")
			ret = ELSE;
		else if (buf == "while")
			ret = WHILE;
		else if (buf == "do")
			ret = DO;
		else if (buf == "for")
			ret = FOR;
		else if (buf == "break")
			ret = BREAK;
		else if (buf == "continue")
			ret = CONTINUE;
		else if (buf == "null")
			ret = NULL;
		
		return new Token(ret, buf, tokenNames);
	}
	private function isLETTER():Bool
	{
		var code:Int = c.charCodeAt(0);
		
		if (code == '_'.charCodeAt(0))
			return true;
		
		return code >= 'a'.charCodeAt(0) && code <= 'z'.charCodeAt(0) ||
			code >= 'A'.charCodeAt(0) && code <= 'Z'.charCodeAt(0);
	}
	
	private function isQuote(S:String):Bool
	{
		return S == '"';
	}
	private function STR():Token
	{
		var buf:String = "";
		do
		{
			if (c == Lexer.EOF_STR)
				doThrow("Unclosed string");
			buf += c;
			consume();
		}
		while (c != '"');
		buf += c;
		consume();
		
		return new Token(STRING, buf, tokenNames);
	}
}