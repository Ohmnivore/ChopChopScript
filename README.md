# What is this?
ChopChop script is a script language for Haxe that
is focused on speed. It expects that you have already
declared all necessary methods and classes in your Haxe
code, so all it needs to do is call them. It supports
only very basic operations for quick parsing and execution.

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

BTW, it was inspired by Nico's
[VainLang](http://nicom1.github.io/interpreter/).

# TODO
* Lol I haven't started coding this yet, just brainstorming
* I should start by writing a tokenizer
* Tokens:
 * Syntax: ACCESSOR (.)
 * Types: BOOL, STRING
 * Math ops: +=, -=, *=, /=, %=, ++[var], --[var], [var]++, [var]--
 * Other ops:
 * Misc: FUNCTION_CALL
