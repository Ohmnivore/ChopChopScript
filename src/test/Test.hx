package test;

/**
 * ...
 * @author Ohmnivore
 */
class Test
{
	public var tests:Array<TestFile> = [];
	public var bad:Array<Case>;
	
	public function new(Names:Array<String>, Content:Array<String>) 
	{
		for (i in 0...Names.length)
		{
			tests.push(new TestFile(Names[i], Content[i]));
		}
	}
	
	public function test():Void
	{
		bad = [];
		for (t in tests)
		{
			var c:Case = new Case(t);
			if (c.f.content.length > 0)
			{
				if (!c.execute())
					bad.push(c);
			}
		}
		trace(bad.length + " tests failed.");
		for (c in bad)
			trace(c.f.name);
	}
	
	private function getValue(S:String):Dynamic
	{
		return null;
	}
}