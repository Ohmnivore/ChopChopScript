package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class Parser
{
	public var input:Lexer;
	public var lookAhead:Array<Token> = [];
	public var k:Int;
	public var p:Int = 0;
	
	public function new(Input:Lexer, K:Int) 
	{
		input = Input;
		k = K;
		input.reset();
		
		var i:Int = 0;
		while (i < k)
		{
			consume();
			
			i++;
		}
	}
	
	public function match(X:Int):Void
	{
		if (LA(1) == X)
			consume();
		else
			throw "expecting " + input.getTokenName(X) + "; found " + LT(1);
	}
	
	public function consume():Void
	{
		lookAhead[p] = input.nextToken();
		p = (p + 1) % k;
	}
	
	public function LT(I:Int):Token
	{
		return lookAhead[(p + I - 1) % k];
	}
	
	public function LA(I:Int):Int
	{
		return LT(I).type;
	}
}