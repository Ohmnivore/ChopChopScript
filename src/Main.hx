package;
import script.ast.AST;
import script.Lexer;
import script.ScriptInterp;
import script.ScriptLexer;
import script.ScriptParser;
import script.Token;
import test.Test;
import test.CompileTime;
import hxclap.*;
import hxclap.arg.*;
/**
* ...
* @author Ohmnivore
*/
class Main
{
    static function main()
    {
		//var lexer:ScriptLexer = new ScriptLexer('1 + 2; 1 + 3;');
		//
		//var token:Token = lexer.nextToken();
		//trace(token);
		//while (token.type != Lexer.EOF)
		//{
			//token = lexer.nextToken();
			//trace(token);
		//}
		
		//var parser:ScriptParser = new ScriptParser(lexer);
        //var asts:Array<AST> = parser.parse();
		//for (a in asts)
			//trace("\n" + a);
		
		#if !(flash)
		var input:CmdTargStr = new CmdTargStr(
			"source",
			"path",
			"the file to interpret",
			(E_CmdArgSyntax.isOPT | E_CmdArgSyntax.isVALOPT),
			null);
		var doTests:CmdArgBool = new CmdArgBool(
			"t",
			"test",
			"run tests and exit",
			(E_CmdArgSyntax.isOPT | E_CmdArgSyntax.isVALOPT));
		var cmd:CmdLine = new CmdLine("ChopChop Interpreter", [input, doTests]);
		cmd.switchNotFound = HandleSwitchNotFound;
		cmd.argNotFound = HandleArgNotFound;
		cmd.missingRequiredArg = HandleMissingArg;
		cmd.missingRequiredSwitch = HandleMissingSwitch;
		cmd.noArgsPassed = HandleNoArgsPassed;
		
		cmd.parse(Sys.args());
        
		if (doTests.value)
			test();
		else if (input.value != null)
		{
			var script:String = sys.io.File.getContent(input.value);
			var lexer:ScriptLexer = new ScriptLexer(script);
			var parser:ScriptParser = new ScriptParser(lexer);
			var interp:ScriptInterp = new ScriptInterp();
			Sys.println(interp.interpret(parser.parse()));
		}
		else
			Sys.println(cmd.defaultTraceUsage());
		#else
		test();
		#end
    }
	
	#if !(flash)
	static public function HandleSwitchNotFound(Switch:String):Void
	{
		Sys.println("Warning: argument '" + Switch + "' looks strange, ignoring");
	}
	static public function HandleMissingSwitch(Cmd:CmdElem):Void
	{
		if (Cmd.isArg)
			Sys.println("Error: the switch -" + Cmd.keyword + " must be supplied");
		else
			Sys.println("Error: the target " + Cmd.keyword + " must be supplied");
	}
	static public function HandleArgNotFound(Cmd:CmdElem):Void
	{
		if (Cmd.isArg)
			Sys.println("Error: switch -" + Cmd.keyword + " must take an argument");
		else
			Sys.println("Error: target " + Cmd.keyword + " must take an argument");
	}
	static public function HandleMissingArg(Cmd:CmdElem):Void
	{
		if (Cmd.isArg)
			Sys.println("Error: the switch -" + Cmd.keyword + " must take a value");
		else
			Sys.println("Error: the target " + Cmd.keyword + " must take a value");
	}
	static public function HandleNoArgsPassed():Void
	{
		Sys.println("Error: requires at least one argument");
	}
	#end
	
    static public function test():Void
    {
        var tests:Test = new Test(CompileTime.getNamesOfFilesInFolder("tests"),
        CompileTime.getTextOfFilesInFolder("tests"));
		tests.test();
    }
}