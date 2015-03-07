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
	
	public var doContinue:Bool = false;
	public var doBreak:Bool = false;
	
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
	
	public function newScope():Void
	{
		var s:Scope = new Scope(curScope);
		curScope = s;
	}
	
	public function oldScope():Void
	{
		curScope = curScope.parent;
	}
}