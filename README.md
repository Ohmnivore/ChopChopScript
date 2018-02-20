# About
ChopChop script is a script language for Haxe.
It can interface with Haxe code using reflection.

# Usage

	var script:String = sys.io.File.getContent(path);
	var lexer:ScriptLexer = new ScriptLexer(script);
	var parser:ScriptParser = new ScriptParser(lexer);
	var interp:ScriptInterp = new ScriptInterp();
	trace(interp.interpret(parser.parse()));

For your own purposes you only need the src/script folder. This project
also builds into an interpreter with the following usage:

	Usage: ChopChop Interpreter
	[source] -> the file to interpret -> expects: [path]
	-[test] (-t) -> run tests and exit -> expects: []
	ex: chopchop.exe test.cpcp
	ex: chopchop.exe -t

You can download a pre-compiled version: https://github.com/Ohmnivore/ChopChopScript/releases

The language syntax is illustrated in the [test suite](tests).

# TODO
* import functions from other chop scripts
* enums
* resolve packages for classes: new script.ast.AST("", []);
* more robust syntax error reporting (match->[throw error if not expected token] instead of consume)
* turn inNest into an inObject bool

# Notes
* enums are WIP
* Do while loop syntax: do while (CONDITION) {STATEMENTS}
* No ++ or -- operator
* No shorthand blocks: if (true) x = 10;
* No type checking
* No ... operator aka no for (0...10) style loops
* No class definitions
* No ternary operator (?:)
* No string interpolation
* No array or iterator comprehension (aka [while (i < 10) i++] && for (while (i < 10) i++))
* No conditional compilation
* No macros
* No switches
* No pattern matching
* No need for type casting

# References
* https://en.wikipedia.org/wiki/Shunting-yard_algorithm
* http://www.amazon.ca/Language-Implementation-Patterns-Domain-Specific-Programming/dp/193435645X
* http://rosettacode.org/wiki/Parsing/Shunting-yard_algorithm
* https://www.klittlepage.com/2013/12/22/twelve-days-2013-shunting-yard-algorithm/
* http://en.cppreference.com/w/cpp/language/operator_precedence
