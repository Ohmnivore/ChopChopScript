package chopchop;

/**
 * ...
 * @author Ohmnivore
 */
class AST
{
	public var token:Token;
	public var children:Array<AST> = [];
	
	public var op:Int;
	public var left:AST;
	public var right:AST;
	
	//public function new(T:Token)
	public function new(Op:Int, Left:AST, Right:AST)
	{
		//token = T;
		op = Op;
		left = Left;
		right = Right;
	}
}