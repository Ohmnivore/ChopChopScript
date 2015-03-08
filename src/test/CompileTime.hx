/****
* Copyright (c) 2013 Jason O'Neil
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
* 
****/
package test;
import haxe.macro.Context;
import haxe.macro.Expr;

class CompileTime 
{
    macro public static function getTextOfFilesInFolder(path:String):ExprOf<Array<String>> {
		return  _toExpr(_getTextOfFilesInFolder(path));
    }
	macro public static function getNamesOfFilesInFolder(path:String):ExprOf<Array<String>> {
		return  _toExpr(_getNamesOfFilesInFolder(path));
    }
	
    #if macro
	static function _getTextOfFilesInFolder(path:String) {
		try {
			var p = Context.resolvePath(path);
			var ret:Array<String> = [];
			for (f in sys.FileSystem.readDirectory(p))
			{
				ret.push(sys.io.File.getContent(haxe.io.Path.join([p, f])));
			}
			return ret;
		} 
		catch(e:Dynamic) {
			return haxe.macro.Context.error('Failed to load folder $path: $e', Context.currentPos());
		}
	}
	static function _getNamesOfFilesInFolder(path:String) {
		try {
			var p = Context.resolvePath(path);
			var ret:Array<String> = [];
			return sys.FileSystem.readDirectory(p);
		} 
		catch(e:Dynamic) {
			return haxe.macro.Context.error('Failed to load folder $path: $e', Context.currentPos());
		}
	}
	
	static function _toExpr(v:Dynamic) {
		return Context.makeExpr(v, Context.currentPos());
	}
    #end
}