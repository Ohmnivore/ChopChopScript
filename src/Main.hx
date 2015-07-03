package;
import script.ast.AST;
import script.Lexer;
import script.ScriptLexer;
import script.ScriptParser;
import script.Token;
//import test.Test;
//import test.CompileTime;
/**
* ...
* @author Ohmnivore
*/
class Main
{
    static function main()
    {
        //var lexer:ScriptLexer = new ScriptLexer('hi = "TEST"; hi.charAt(); hi.charAt(0); hi.charAt(1, 2, 3, 4, 5);');
        //var lexer:ScriptLexer = new ScriptLexer('1 * (2 + 3);');
        var lexer:ScriptLexer = new ScriptLexer('(2 + 3) * 4;');
        
        var token:Token = lexer.nextToken();
        trace(token);
  		while (token.type != Lexer.EOF)
        {
            token = lexer.nextToken();
            trace(token);
        }
            
        lexer.reset();
        var parser:ScriptParser = new ScriptParser(lexer);
        var asts:Array<AST> = parser.parse();
		for (a in asts)
			trace(a);
        
        //test();
    }
	static private function traceAST(A:AST):Void
	{
		trace(A);
	}
    static public function test():Void
    {
        //var tests:Test = new Test(CompileTime.getNamesOfFilesInFolder("tests"),
        //CompileTime.getTextOfFilesInFolder("tests"));
        //tests.test();
    }
}