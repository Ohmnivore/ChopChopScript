package;

import chopchop.ChopLexer;
import chopchop.Lexer;
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
		//var lexer:ChopLexer = new ChopLexer('_test.x = 0;\n_bool2=true;\nstr="test";\na = 2 + 3.5;\nb = 2 - 1;\nc = 2 * 3;\nd = 2 / 0.5;\ne = 4 % 3;');
		var lexer:ChopLexer = new ChopLexer('test1.test.method();\ntest = 2 * (3 + 4);');
		
		var token:Token = lexer.nextToken();
		while (token.type != Lexer.EOF)
		{
			trace(token, lexer.p);
			token = lexer.nextToken();
		}
		trace(token, lexer.p);
		
		//var parser:LookaheadParser = new LookaheadParser(lexer, 2);
        //parser.list(); // begin parsing at rule list
	}
}