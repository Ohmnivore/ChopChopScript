package script;
import script.ast.AST;

/**
 * ...
 * @author Ohmnivore
 */
class ScriptInterp
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
	
	public function reset():Void
	{
		globalScope = new Scope();
		curScope = globalScope;
		
		curScope.define("trace", doTrace);
		quickShareClass(Array);
		//quickShareClass(ArrayAccess);
		curScope.define("Bool", Bool);
		curScope.define("Class", Class);
		quickShareClass(Date);
		quickShareClass(DateTools);
		curScope.define("Dynamic", Dynamic);
		curScope.define("EReg", EReg);
		curScope.define("Enum", Enum);
		//curScope.define("EnumValue", EnumValue);
		curScope.define("Float", Float);
		//curScope.define("IMap", IMap);
		curScope.define("Int", Int);
		quickShareClass(IntIterator);
		//curScope.define("Iterable", Iterable);
		//curScope.define("Iterator", Iterator);
		quickShareClass(Lambda);
		quickShareClass(List);
		quickShareClass(Map);
		quickShareClass(Math);
		//curScope.define("Null", Null);
		//quickShareClass(Reflect); //SECURITY
		//curScope.define("Single", Single);
		quickShareClass(Std);
		quickShareClass(String);
		quickShareClass(StringBuf);
		quickShareClass(StringTools);
		//quickShareClass(Sys); //SECURITY
		//quickShareClass(Type); //SECURITY
		//quickShareClass(UInt);
		//curScope.define("ValueType", ValueType);
		//curScope.define("Void", Void);
		quickShareClass(Xml);
		//curScope.define("XmlType", XmlType);
	}
	private function quickShareClass(C:Class<Dynamic>):Void
	{
		curScope.define(Type.getClassName(C), C);
	}
	public function importClass(FullName:String):Class<Dynamic>
	{
		var justName:String = FullName.split(".").pop();
		var c:Class<Dynamic> = Type.resolveClass(FullName);
		
		curScope.define(FullName, c);
		curScope.define(justName, c);
		
		return c;
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