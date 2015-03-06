package;

import chopchop.ast.AST;
import chopchop.ChopLexer;
import chopchop.ChopParser;
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
	
	static private var lexer:ChopLexer;
	static private var parser:ChopParser;
	
	static public function test():Void
	{
		//lexer = new ChopLexer('_test.x = 0;\n_bool2=true;\nstr="test";\na = 2 + 3.5;\nb = 2 - 1;\nc = 2 * 3;\nd = 2 / 0.5;\ne = 4 % 3;');
		//lexer = new ChopLexer('test1.test.method();\ntest = 2 * (3 + 4);');
		//lexer = new ChopLexer('3 + 4 * 2 / ( 1 - 5 ) * 2 / 3;');
		//lexer = new ChopLexer('(3 + 4) * id;');
		//lexer = new ChopLexer('a = k.lol % 4;');
		//lexer = new ChopLexer('kek.lol + 4;2 + 3;');
		//lexer = new ChopLexer('3 * 4 + 5;');
		//lexer = new ChopLexer('if (kek == 0 && topkek == 1) {lel = 5;toplel=4;} else lel = 3;');
		//lexer = new ChopLexer('if (true) k = 0; else if (false) kek = 1; else lel = 3;');
		lexer = new ChopLexer('while (true) {kek = 3;}');
		
		//var token:Token = lexer.nextToken();
		//while (token.type != Lexer.EOF)
		//{
			//trace(token, lexer.p);
			//token = lexer.nextToken();
		//}
		//trace(token, lexer.p);
		
		lexer.reset();
		parser = new ChopParser(lexer);
		for (ast in parser.ast)
		{
			trace("\n" + ast.toString());
		}
	}
}