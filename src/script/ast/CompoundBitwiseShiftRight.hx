package script.ast;
import script.ScriptInterp;
import script.Token;

/**
 * ...
 * @author Ohmnivore
 */
class CompoundBitwiseShiftRight extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		priority = 1;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		Reflect.setField(left, "isValue", false);
		var l:Access = cast left.walk(I);
		var val:Dynamic = right.walk(I);
		l.setValue(l.getVal() >> val);
		
		return val;
	}
}