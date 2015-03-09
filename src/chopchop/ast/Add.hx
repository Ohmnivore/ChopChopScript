package chopchop.ast;
import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Add extends BinAST
{
	public function new(T:Token, Children:Array<AST>) 
	{
		super(T, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var l:Dynamic = cast left.walk(I);
		var r:Dynamic = cast right.walk(I);
		
		return l + r;
	}
}