package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class LookaheadParser extends Parser
{

	public function new(Input:Lexer, K:Int) 
	{
		super(Input, K);
	}
	
	public function list():Void
	{
		match(LookaheadLexer.LBRACK);
		elements();
		match(LookaheadLexer.RBRACK);
	}
	
	private function elements():Void
	{
		element();
		
		while (LA(1) == LookaheadLexer.COMMA)
		{
			match(LookaheadLexer.COMMA);
			element();
		}
	}
	
	private function element():Void
	{
		if (LA(1) == LookaheadLexer.NAME && LA(2) == LookaheadLexer.EQUALS)
		{
			match(LookaheadLexer.NAME);
			match(LookaheadLexer.EQUALS);
			match(LookaheadLexer.NAME);
		}
		else if (LA(1) == LookaheadLexer.NAME)
		{
			match(LookaheadLexer.NAME);
		}
		else if (LA(1) == LookaheadLexer.LBRACK)
		{
			list();
		}
		else
		{
			throw "expecting name or list; found " + LT(1);
		}
	}
}