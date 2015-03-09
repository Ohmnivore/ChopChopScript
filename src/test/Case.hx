package test;
import chopchop.*;
import chopchop.ast.AST;

/**
 * ...
 * @author Ohmnivore
 */
class Case
{
	public var f:TestFile;
	private var executable:String;
	private var expected:String;
	
	public function new(F:TestFile)
	{
		f = F;
		var firstLine:Int = f.content.indexOf("\n");
		expected = f.content.substring(f.content.indexOf("//") + 2, firstLine);
		executable = f.content.substr(firstLine);
	}
	
	public function execute():Bool
	{
		var lexer:ChopLexer = new ChopLexer(executable);
		var lexerBuff:String = checkLexer(lexer);
		//trace(lexerBuff);
		var parser:ChopParser = new ChopParser(lexer);
		var parserBuff:String = checkParser(parser);
		//trace(parserBuff);
		var interp:ChopInterp = new ChopInterp();
		var v:Dynamic = checkInterp(interp, parser.ast);
		var expectedV:Dynamic = interp.interpret(oneShot(expected));
		
		var ok:Bool = expectedV == v;
		trace(Std.string(ok).toUpperCase() + ": " + f.name + " | expects: " + expectedV + " | gets: " + v);
		if (!ok)
		{
			trace(lexerBuff);
			trace(parserBuff);
		}
		
		interp.reset();
		return ok;
	}
	
	private function oneShot(S:String):Array<AST>
	{
		var lexer:ChopLexer = new ChopLexer(S);
		return new ChopParser(lexer).parse();
	}
	
	private function checkLexer(L:Lexer):String
	{
		var buffer:String = "";
		try {
			var token:Token = L.nextToken();
			while (token.type != Lexer.EOF)
			{
				buffer += token + ", " + L.p + "; ";
				token = L.nextToken();
			}
			buffer += token + ", " + L.p + "; ";
		}
		catch (e:Dynamic) {
			throw "Lexer error at position " + L.p + ": " + e + "\n" + buffer;
		}
		L.reset();
		return buffer;
	}
	
	private function checkParser(P:ChopParser):String
	{
		var buffer:String = "";
		//try {
			P.parse();
			for (ast in P.ast)
			{
				buffer += "\n" + ast.toString();
			}
		//}
		//catch (e:Dynamic) {
			//throw "Parser error at position " + P.p + ": " + e + "\n" + buffer;
		//}
		return buffer;
	}
	
	private function checkInterp(I:ChopInterp, ast:Array<AST>):Dynamic
	{
		//try {
			return I.interpret(ast);
		//}
		//catch (e:Dynamic) {
			//throw "Interpreter error: " + e;
		//}
	}
}