package script.ast;

/**
 * ...
 * @author Ohmnivore
 */
class Constructor extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var args:Array<Dynamic> = [];
		for (arg in children)
		{
			args.push(arg.walk(I));
		}
		
		//var c:Class<Dynamic> = Type.resolveClass(text);
		var c:Class<Dynamic> = cast I.curScope.resolve(text).value;
		
		return Type.createInstance(c, args);
	}
}