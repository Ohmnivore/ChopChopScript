package script;

/**
 * ...
 * @author Ohmnivore
 */
class Stack<T>
{
	public var arr:Array<T>;
	public var length(get, never):Int;
	public function get_length():Int
	{
		return arr.length;
	}
	
	public function new()
	{
		arr = [];
	}
	
	public function add(item:T) 
	{
		arr.push(item);
	}
	
	public function pop():T
	{
		return arr.pop();
	}
	
	public function first():T 
	{
		if (arr.length > 0)
			return arr[length - 1];
		else
			return null;
	}
}