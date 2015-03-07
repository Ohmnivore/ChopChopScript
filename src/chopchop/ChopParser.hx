package chopchop;
import chopchop.ast.*;
import chopchop.ast.Continue;
import haxe.ds.GenericStack;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Ohmnivore
 */
class ChopParser extends Parser
{
	public var lexer:ChopLexer;
	private var ops:ObjectMap<Dynamic, Operator>;
	public var ast:Array<AST>;
	
	public function new(Input:ChopLexer) 
	{
		lexer = Input;
		initOps();
		super(Input, 2);
		
		ast = makeAST(Lexer.EOF);
	}
	
	private function addNode(Stack:GenericStack<AST>, T:Token, Ast:Class<AST>):Void
	{
        var rightASTNode:AST = Stack.pop();
		var leftASTNode:AST = Stack.pop();
		var ast:AST = Type.createInstance(Ast, [T, [leftASTNode, rightASTNode]]);
        Stack.add(ast);
    }
	public function makeAST(Until:Int):Array<AST>
	{
		var ret:Array<AST> = [];
		var lastIf:If = null;
		while (LA(1) != Until && LA(1) != Lexer.EOF)
		{
			var t:Int = LA(1);
			var tok:Token = LT(1);
			var t2:Int = LA(2);
			var tok2:Token = LT(2);
			var t3:Int = LA(3);
			var tok3:Token = LT(3);
			
			if (t == ChopLexer.IF || (t == ChopLexer.ELSE && t2 == ChopLexer.IF))
			{
				if (t == ChopLexer.ELSE)
				{
					match(ChopLexer.ELSE);
					tok.text = "else if";
				}
				match(ChopLexer.IF);
				match(ChopLexer.OPEN_PAR);
				var condition:AST = parseExpr(ChopLexer.CLOSE_PAR);
				match(ChopLexer.CLOSE_PAR);
				var ifTrue:Array<AST> = [];
				if (LA(1) == ChopLexer.OPEN_CURLY)
				{
					ifTrue = makeAST(ChopLexer.CLOSE_CURLY);
				}
				else
				{
					ifTrue = makeAST(ChopLexer.SEMI_COLON);
				}
				
				var thisIf:If = new If(tok, condition, ifTrue, null);
				if (t == ChopLexer.ELSE)
					lastIf.ifFalse = [thisIf];
				else
					ret.push(thisIf);
				
				lastIf = thisIf;
			}
			else if (t == ChopLexer.ELSE)
			{
				match(ChopLexer.ELSE);
				var ifFalse:Array<AST> = [];
				if (LA(1) == ChopLexer.OPEN_CURLY)
				{
					ifFalse = makeAST(ChopLexer.CLOSE_CURLY);
				}
				else
				{
					ifFalse = makeAST(ChopLexer.SEMI_COLON);
				}
				lastIf.ifFalse = ifFalse;
			}
			
			else if (t == ChopLexer.WHILE)
			{
				match(ChopLexer.WHILE);
				match(ChopLexer.OPEN_PAR);
				
				var condition:AST = parseExpr(ChopLexer.CLOSE_PAR);
				match(ChopLexer.CLOSE_PAR);
				var body:Array<AST> = [];
				if (LA(1) == ChopLexer.OPEN_CURLY)
				{
					body = makeAST(ChopLexer.CLOSE_CURLY);
				}
				else
				{
					body = makeAST(ChopLexer.SEMI_COLON);
				}
				
				ret.push(new While(tok, condition, body));
			}
			else if (t == ChopLexer.DO)
			{
				match(ChopLexer.DO);
				var body:Array<AST> = [];
				if (LA(1) == ChopLexer.OPEN_CURLY)
				{
					body = makeAST(ChopLexer.CLOSE_CURLY);
					match(ChopLexer.CLOSE_CURLY);
				}
				else
				{
					body = makeAST(ChopLexer.SEMI_COLON);
					match(ChopLexer.SEMI_COLON);
				}
				match(ChopLexer.WHILE);
				match(ChopLexer.OPEN_PAR);
				var condition:AST = parseExpr(ChopLexer.CLOSE_PAR);
				match(ChopLexer.CLOSE_PAR);
				
				ret.push(new DoWhile(tok, condition, body));
			}
			
			//Keywords -> moved to parseExpr
			//else if (t == ChopLexer.CONTINUE)
			//{
				//ret.push(new Continue(tok, []));
			//}
			//else if (t == ChopLexer.BREAK)
			//{
				//ret.push(new Break(tok, []));
			//}
			
			else if (t == ChopLexer.OPEN_CURLY || t == ChopLexer.CLOSE_CURLY ||
					 t == ChopLexer.OPEN_PAR || t == ChopLexer.CLOSE_PAR)
			{
				
			}
			
			else
			{
				ret.push(parseExpr(ChopLexer.SEMI_COLON));
				if (Until == ChopLexer.SEMI_COLON)
					return ret;
			}
			consume();
		}
		
		return ret;
	}
	public function parseExpr(Until:Int):AST
	{
		var operatorStack:GenericStack<AST> = new GenericStack<AST>();
		var operandStack:GenericStack<AST> = new GenericStack<AST>();
		
		while (LA(1) != Until && LA(1) != Lexer.EOF)
		{
			var t:Int = LA(1);
			var tok:Token = LT(1);
			var t2:Int = LA(2);
			var tok2:Token = LT(2);
			var t3:Int = LA(3);
			var tok3:Token = LT(3);
			
			if (t == ChopLexer.OPEN_PAR)
			{
				operatorStack.add(new ParOpen(tok, []));
			}
			else if (t == ChopLexer.CLOSE_PAR)
			{
				while (!operatorStack.isEmpty())
				{
					var popped:AST = operatorStack.pop();
					if (popped.token.type == ChopLexer.OPEN_PAR)
					{
						//continue main;
						break;
					}
					else
					{
						addNode(operandStack, popped.token, Type.getClass(popped));
					}
				}
				//throw "Unbalanced right parentheses";
			}
			
			//Math operators
			else if (t == ChopLexer.PLUS)
			{
				handleSimpleOp(Add, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.MINUS)
			{
				handleSimpleOp(Substract, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.MULT)
			{
				handleSimpleOp(Multiply, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.DIV)
			{
				handleSimpleOp(Divide, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.MOD)
			{
				handleSimpleOp(Modulo, tok, operatorStack, operandStack);
			}
			
			//Boolean operators
			else if (t == ChopLexer.EQUAL && t2 == ChopLexer.EQUAL)
			{
				consume();
				tok.text = "==";
				handleSimpleOp(Equals, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.NOT && t2 == ChopLexer.EQUAL)
			{
				consume();
				tok.text = "!=";
				handleSimpleOp(NotEquals, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.BIGGER && t2 != ChopLexer.BIGGER && t2 != ChopLexer.EQUAL)
			{
				handleSimpleOp(Bigger, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.SMALLER && t2 != ChopLexer.SMALLER && t2 != ChopLexer.EQUAL)
			{
				handleSimpleOp(Smaller, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.BIGGER && t2 == ChopLexer.EQUAL)
			{
				consume();
				tok.text = ">=";
				handleSimpleOp(BiggerOrEqual, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.SMALLER && t2 == ChopLexer.EQUAL)
			{
				consume();
				tok.text = "<=";
				handleSimpleOp(SmallerOrEqual, tok, operatorStack, operandStack);
			}
			
			//Bitwise operators
			else if (t == ChopLexer.AND && t2 != ChopLexer.AND)
			{
				handleSimpleOp(BitwiseAnd, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.OR && t2 != ChopLexer.OR)
			{
				handleSimpleOp(BitwiseOr, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.XOR && t2 != ChopLexer.XOR)
			{
				handleSimpleOp(BitwiseXOR, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.SMALLER && t2 == ChopLexer.SMALLER)
			{
				consume();
				tok.text = "<<";
				handleSimpleOp(BitwiseShiftLeft, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.BIGGER && t2 == ChopLexer.BIGGER && t3 != ChopLexer.BIGGER)
			{
				consume();
				tok.text = ">>";
				handleSimpleOp(BitwiseShiftRight, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.BIGGER && t2 == ChopLexer.BIGGER && t3 == ChopLexer.BIGGER)
			{
				consume();
				consume();
				tok.text = ">>>";
				handleSimpleOp(BitwiseShiftRightUnsigned, tok, operatorStack, operandStack);
			}
			
			//Boolean operators
			else if (t == ChopLexer.AND && t2 == ChopLexer.AND)
			{
				consume();
				tok.text = "&&";
				handleSimpleOp(And, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.OR && t2 == ChopLexer.OR)
			{
				consume();
				tok.text = "||";
				handleSimpleOp(Or, tok, operatorStack, operandStack);
			}
			
			//Other operators
			else if (t == ChopLexer.EQUAL && t2 != ChopLexer.EQUAL)
			{
				handleSimpleOp(Assign, tok, operatorStack, operandStack);
			}
			else if (t == ChopLexer.FIELD_ACCESSSOR)
			{
				handleSimpleOp(AccessField, tok, operatorStack, operandStack);
			}
			
			//Values
			else if (t == ChopLexer.INT)
			{
				operandStack.add(new IntV(tok, []));
			}
			else if (t == ChopLexer.FLOAT)
			{
				operandStack.add(new FloatV(tok, []));
			}
			else if (t == ChopLexer.BOOL)
			{
				operandStack.add(new BoolV(tok, []));
			}
			else if (t == ChopLexer.VARIABLE)
			{
				operandStack.add(new Variable(tok, []));
			}
			else if (t == ChopLexer.STRING)
			{
				operandStack.add(new StringV(tok, []));
			}
			else if (t == ChopLexer.NULL)
			{
				operandStack.add(new NullV(tok, []));
			}
			
			else if (t == ChopLexer.CONTINUE)
			{
				operandStack.add(new Continue(tok, []));
			}
			else if (t == ChopLexer.BREAK)
			{
				operandStack.add(new Break(tok, []));
			}
			
			else
			{
				operandStack.add(new AST(tok, []));
			}
			consume();
		}
		while (!operatorStack.isEmpty())
		{
			var ast:AST = operatorStack.pop();
            addNode(operandStack, ast.token, Type.getClass(ast));
        }
        return operandStack.pop();
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
		ops = new ObjectMap<Dynamic, Operator>();
		
		//addOp(new Operator(Multiply, false, 3));
		//addOp(new Operator(Divide, false, 3));
		//addOp(new Operator(Add, false, 2));
		//addOp(new Operator(Substract, false, 2));
		//addOp(new Operator(Substract, false, 2));
		
		addOp(new Operator(AccessField, false, 2));
		
		addOp(new Operator(Multiply, false, 5));
		addOp(new Operator(Divide, false, 5));
		addOp(new Operator(Modulo, false, 5));
		
		addOp(new Operator(Add, false, 6));
		addOp(new Operator(Substract, false, 6));
		
		addOp(new Operator(BitwiseShiftLeft, false, 7));
		addOp(new Operator(BitwiseShiftRight, false, 7));
		addOp(new Operator(BitwiseShiftRightUnsigned, false, 7));
		
		addOp(new Operator(Smaller, false, 8));
		addOp(new Operator(SmallerOrEqual, false, 8));
		addOp(new Operator(Bigger, false, 8));
		addOp(new Operator(BiggerOrEqual, false, 8));
		
		addOp(new Operator(Equals, false, 9));
		addOp(new Operator(NotEquals, false, 9));
		
		addOp(new Operator(BitwiseAnd, false, 10));
		addOp(new Operator(BitwiseXOR, false, 11));
		addOp(new Operator(BitwiseOr, false, 12));
		addOp(new Operator(And, false, 13));
		addOp(new Operator(Or, false, 14));
		
		addOp(new Operator(Assign, true, 15));
	}
	private function addOp(Op:Operator):Void
	{
		ops.set(Op.ast, Op);
	}
	private function handleSimpleOp(Ast:Class<AST>, T:Token, OperatorStack:GenericStack<AST>,
		OperandStack:GenericStack<AST>):Void
	{
		var o1:Operator = ops.get(Ast);
		var ast2:AST = OperatorStack.first();
		var o2:Operator = null;
		if (ast2 != null)
			o2 = ops.get(Type.getClass(ast2));
		while (!OperatorStack.isEmpty() && o2 != null)
		{
			if ((!o1.rightAssociative &&
					o1.compare(o2) == 0) ||
					o1.compare(o2) < 0)
			{
				OperatorStack.pop();
				//Not sure if addNode(OperandStack, t) or
				addNode(OperandStack, ast2.token, Type.getClass(ast2));
			}
			else
			{
				break;
			}
			ast2 = OperatorStack.first();
			o2 = null;
			if (ast2 != null)
				o2 = ops.get(Type.getClass(ast2));
		}
		OperatorStack.add(Type.createInstance(Ast, [T, []]));
	}
}