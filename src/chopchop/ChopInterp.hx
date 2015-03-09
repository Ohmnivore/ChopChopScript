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
		reset();
	}
	
	private function doTrace(E:Dynamic):Void
	{
		haxe.Log.trace(Std.string(E), cast { fileName : "hscript", lineNumber : 0 });
	}
	private function doNew(Cl:String, Args:Array<Dynamic>):Dynamic
	{
		var c:Class<Dynamic> = Type.resolveClass(Cl);
		if (c == null) c = curScope.resolve(Cl).value;
		return Type.createInstance(c, Args);
	}
	private function doCast<T:Dynamic>(V:Dynamic, To:Class<T>):T
	{
		if(Std.is(V, To))
		{
			var ret:T = cast V;
			return ret;
		}
		return null;
	}
	
	public function reset():Void
	{
		globalScope = new Scope();
		curScope = globalScope;
		
		curScope.define("trace", doTrace);
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