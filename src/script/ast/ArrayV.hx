package script.ast;

/**
 * ...
 * @author Ohmnivore
 */
class ArrayV extends AST
{
	public var isValue:Bool = true;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var arr:Array<Dynamic> = [];
		for (arg in children)
		{
			arr.push(arg.walk(I));
		}
		
		return arr;
	}
}