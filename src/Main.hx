package;

import chopchop.ast.AST;
import chopchop.ChopInterp;
import chopchop.ChopLexer;
import chopchop.ChopParser;
import chopchop.Lexer;
import chopchop.Token;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import test.Test;
import test.CompileTime;

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
		var tests:Test = new Test(CompileTime.getNamesOfFilesInFolder("tests"),
			CompileTime.getTextOfFilesInFolder("tests"));
		tests.test();
	}
}