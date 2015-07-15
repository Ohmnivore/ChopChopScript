package script.ast;

import script.ScriptInterp;
import script.Symbol;

/**
 * ...
 * @author Ohmnivore
 */
class FunctionDef extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		I.curScope.define(text, this);
		return null;
	}
	
	public function callFunction(I:ScriptInterp, Args:Array<AST>):Dynamic
	{
		I.newScope();
		var ret:Dynamic = null;
		var cond:Condition = cast children[0];
		var block:Block = cast children[1];
		
		var i:Int = 0;
		while (i < Args.length)
		{
			I.curScope.define(cond.children[i].text, Args[i].walk(I));
			i++;
		}
		while (i < cond.children.length)
		{
			cond.children[i].walk(I);
			i++;
		}
		
		ret = block.walk(I);
		I.oldScope();
		return ret;
	}
}