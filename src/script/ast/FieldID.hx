package script.ast;

/**
 * ...
 * @author Ohmnivore
 */
class FieldID extends BinAST
{
	public var name:String;
	public var value:Dynamic;
	
	public function new(Text:String, Children:Array<AST>) 
	{
		super(Text, Children);
		rightAssociative = true;
		priority = 1;
	}
	
	override public function walk(I:ScriptInterp):Dynamic 
	{
		name = left.text;
		value = right.walk(I);
		return this;
	}
}