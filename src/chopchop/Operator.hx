package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class Operator
{
	public var symbol:Int;
	public var rightAssociative:Bool;
	public var precedence:Int;
	public var nameArr:Array<String>;
	
	public function new(S:Int, RightAssociative:Bool, Precedence:Int, NameArr:Array<String>) 
	{
		symbol = S;
		rightAssociative = RightAssociative;
		precedence = Precedence;
		nameArr = NameArr;
	}
	
	public function compare(Op:Operator):Int
	{
		if (Op.precedence > precedence)
			return -1;
		else if (Op.precedence < precedence)
			return 1;
		else
			return 0;
	}
	
	public function toString():String
	{
		return nameArr[symbol];
	}
}