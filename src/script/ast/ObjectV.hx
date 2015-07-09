package script.ast;

/**
 * ...
 * @author Ohmnivore
 */
class ObjectV extends AST
{
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		canNest = true;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		var obj:Dynamic = {};
		for (arg in children)
		{
			var id:FieldID = cast arg.walk(I);
			Reflect.setField(obj, id.name, id.value);
		}
		
		return obj;
	}
}