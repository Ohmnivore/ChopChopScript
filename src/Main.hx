package;
import script.ast.AST;
import script.Lexer;
import script.ScriptLexer;
import script.ScriptParser;
import script.Token;
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
		//var lexer:ScriptLexer = new ScriptLexer('2 + 3 * 4;');
		//var lexer:ScriptLexer = new ScriptLexer('(1 * (2 + 3)) * 4;');
		//var lexer:ScriptLexer = new ScriptLexer('f();');
		//var lexer:ScriptLexer = new ScriptLexer('a.f(b.f(1 * 3), 2, f());');
		//var lexer:ScriptLexer = new ScriptLexer('(1 + 2) * 3;');
		//var lexer:ScriptLexer = new ScriptLexer('if (true) {2 + 3; 1 + 2 * 3;} kek = 10;');
		//var lexer:ScriptLexer = new ScriptLexer('[[0, 1, 2], [3, 4, 5]][1][2];');
		//var lexer:ScriptLexer = new ScriptLexer('if (true) {} else if (false) {} else {}');
		var lexer:ScriptLexer = new ScriptLexer('while (true) { if (true) { break; } }');
        
        var parser:ScriptParser = new ScriptParser(lexer);
        var asts:Array<AST> = parser.parse();
		for (a in asts)
			trace("\n" + a);
        
        //test();
    }
    static public function test():Void
    {
        var tests:Test = new Test(CompileTime.getNamesOfFilesInFolder("tests"),
        CompileTime.getTextOfFilesInFolder("tests"));
		tests.test();
    }
}