package;

import chopchop.Lexer;
import chopchop.LookaheadLexer;
import chopchop.LookaheadParser;
import chopchop.Token;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

/**
 * ...
 * @author Ohmnivore
 */

class Main 
{
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		test();
	}
	
	static public function test():Void
	{
		var lexer:LookaheadLexer = new LookaheadLexer("[a,b=c,[d,e]]");
		var parser:LookaheadParser = new LookaheadParser(lexer, 2);
		
        parser.list(); // begin parsing at rule list
		
		//var token:Token = lexer.nextToken();
		//while (token.type != Lexer.EOF)
		//{
			//trace(token, lexer.p);
			//token = lexer.nextToken();
		//}
		//trace(token);
	}
}