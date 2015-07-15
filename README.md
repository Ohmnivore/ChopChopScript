# What is this?
ChopChop script is a script language for Haxe that
is focused on speed. It expects that you have already
declared all necessary methods and classes in your Haxe
code, so all it needs to do is call them.

# Why?
Of course half of this is just me fooling around, but the
main idea is to provide a scripting tool for Haxe with the
best performance possible. I'm planning on using benchmarks
to compare it to
[hscript](https://github.com/HaxeFoundation/hscript),
which seems to be the only alternative so far, and then
to a Haxe equivalent of the test scripts.

I plan to maybe use this for a plugin system in one of
my games.

It was inspired by Nico's
[VainLang](http://nicom1.github.io/interpreter/)
and the [hscript project](https://github.com/HaxeFoundation/hscript).

# TODO
* import functions from other chop scripts
* enums
* resolve packages for classes: new script.ast.AST("", []);
* robust syntax error reporting (match->[throw error if not expected token] instead of consume)
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

# REF
* https://en.wikipedia.org/wiki/Shunting-yard_algorithm
* http://www.amazon.ca/Language-Implementation-Patterns-Domain-Specific-Programming/dp/193435645X
* http://rosettacode.org/wiki/Parsing/Shunting-yard_algorithm
* https://www.klittlepage.com/2013/12/22/twelve-days-2013-shunting-yard-algorithm/
* http://en.cppreference.com/w/cpp/language/operator_precedence
