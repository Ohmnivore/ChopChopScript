package chopchop;
import chopchop.ast.AST;

/**
 * ...
 * @author Ohmnivore
 */
class ChopInterp
{
	public var globalScope:Scope;
	public var curScope:Scope;
	
	public function new() 
	{
		globalScope = new Scope();
		curScope = globalScope;
	}
	
	public function setSymbol(Name:String, Value:Dynamic):Void
	{
		globalScope.define(Name, Value);
	}
	
	public function interpret(Arr:Array<AST>):Dynamic
	{
		var lastV:Dynamic = null;
		for (x in Arr)
		{
			lastV = x.walk(this);
		}
		return lastV;
	}
}