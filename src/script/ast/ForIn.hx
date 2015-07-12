package script.ast;

import script.ScriptInterp;
import script.Symbol;

/**
 * ...
 * @author Ohmnivore
 */
class ForIn extends AST
{
	private var name:String;
	private var cont:Dynamic;
	private var block:AST;
	private var ret:Dynamic;
	private var interp:ScriptInterp;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		argCount = 3;
		canNest = true;
	}
	
	private function iter(A:Dynamic):Bool
	{
		interp.curScope.define(name, A);
		ret = block.walk(interp);
		if (ret == Break)
			return false;
		return true;
	}
	override public function walk(I:ScriptInterp):Dynamic 
	{
		name = children[0].text;
		cont = children[1].walk(I);
		block = children[2];
		ret = null;
		interp = I;
		
		Lambda.foreach(cont, iter);
		
		return ret;
	}
}