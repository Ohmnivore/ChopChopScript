package chopchop.ast;
import chopchop.ChopInterp;
import chopchop.Token;

/**
 * ...
 * @author Ohmnivore
 */
class Add extends BinAST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
	}
	
	override public function walk(I:ChopInterp):Dynamic 
	{
		var l:Dynamic = left.walk(I);
		var r:Dynamic = right.walk(I);
		
		return l + r;
	}
}