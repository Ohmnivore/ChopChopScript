package chopchop;
import haxe.ds.GenericStack;

/**
 * ...
 * @author Ohmnivore
 */
class ChopParser extends Parser
{
	public var lexer:ChopLexer;
	private var ops:Map<Int, Operator>;
	public var ast:AST;
	
	public function new(Input:ChopLexer, K:Int) 
	{
		lexer = Input;
		initOps();
		super(Input, K);
		
		ast = makeAST();
	}
	
	private function addNode(Stack:GenericStack<AST>, Op:Int):Void
	{
        var rightASTNode:AST = Stack.pop();
		var leftASTNode:AST = Stack.pop();
        Stack.add(new AST(Op, leftASTNode, rightASTNode));
    }
	public function makeAST():AST
	{
		var operatorStack:GenericStack<Int> = new GenericStack<Int>();
		var operandStack:GenericStack<AST> = new GenericStack<AST>();
		while (LA(1) != ChopLexer.SEMI_COLON)
		{
			trace(toStringStack(operatorStack));
			
			var t:Int = LA(1);
			//if (isSimpleOp(t))
			//{
				//handleSimpleOp(t, operatorStack, operandStack);
			//}
			if (t == ChopLexer.OPEN_PAR)
			{
				operatorStack.add(ChopLexer.OPEN_PAR);
			}
			else if (t == ChopLexer.CLOSE_PAR)
			{
				while (!operatorStack.isEmpty())
				{
					var popped:Int = operatorStack.pop();
					if (ChopLexer.OPEN_PAR == popped)
					{
						//continue main;
						break;
					}
					else
					{
						addNode(operandStack, popped);
					}
				}
				//throw "Unbalanced right parentheses";
			}
			else
			{
				handleSimpleOp(t, operatorStack, operandStack);
			}
			consume();
		}
		while (!operatorStack.isEmpty())
		{
            addNode(operandStack, operatorStack.pop());
        }
        return operandStack.pop();
	}
	private function toStringStack(S:GenericStack<Int>):String
	{
		var buff:String = "";
		for (e in S.iterator())
		{
			buff += lexer.tokenNames[e] + ", ";
		}
		return buff;
	}
	
	private function isSimpleOp(T:Int):Bool
	{
		if (T == ChopLexer.PLUS || T == ChopLexer.MINUS || T == ChopLexer.DIV ||
			T == ChopLexer.MULT)
			return true;
		else
			return false;
	}
	private function initOps():Void
	{
		ops = new Map<Int, Operator>();
		
		addOp(new Operator(ChopLexer.MULT, false, 3, lexer.tokenNames));
		addOp(new Operator(ChopLexer.DIV, false, 3, lexer.tokenNames));
		addOp(new Operator(ChopLexer.PLUS, false, 2, lexer.tokenNames));
		addOp(new Operator(ChopLexer.MINUS, false, 2, lexer.tokenNames));
	}
	private function addOp(Op:Operator):Void
	{
		ops.set(Op.symbol, Op);
	}
	private function handleSimpleOp(T:Int, OperatorStack:GenericStack<Int>,
		OperandStack:GenericStack<AST>):Void
	{
		if (ops.exists(T))
		{
			var o1:Operator = ops.get(T);
			var o2:Operator = ops.get(OperatorStack.first());
			while (!OperatorStack.isEmpty() && o2 != null)
			{
				if ((!o1.rightAssociative &&
						o1.compare(o2) == 0) ||
						o1.compare(o2) < 0)
				{
					OperatorStack.pop();
					addNode(OperandStack, o2.symbol);
				}
				else
				{
					break;
				}
				o2 = ops.get(OperatorStack.first());
			}
			OperatorStack.add(T);
		}
		else
		{
			OperandStack.add(new AST(T, null, null));
		}
	}
}