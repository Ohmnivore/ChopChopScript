package test;

/**
 * ...
 * @author Ohmnivore
 */
class Test
{
	private var tests:Array<TestFile> = [];
	
	public function new(Names:Array<String>, Content:Array<String>) 
	{
		for (i in 0...Names.length)
		{
			tests.push(new TestFile(Names[i], Content[i]));
		}
	}
	
	public function test():Void
	{
		for (t in tests)
		{
			var c:Case = new Case(t);
			c.execute();
		}
	}
	
	private function getValue(S:String):Dynamic
	{
		return null;
	}
}