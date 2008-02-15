/*
 Copyright (c) 2007 Eric J. Feminella  <eric@ericfeminella.com>
 All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 @internal
 */

package com.ericfeminella.sql
{
	import mx.utils.StringUtil;
	
	/**
	 * SQLStatementHelper is an all static utility class which provides a 
	 * mechanism for substituting tokens specified in a statement with 
	 * arbitrary values. Use this utility in conjunction with classes 
	 * that implement ISQLStatementResource to replace tokens with values
	 * 
	 */	
	public final class SQLStatementHelper
	{
		/**
		 * SQLStatementHelper is an all static utility class which provides a 
		 * mechanism for substituting tokens specified in a statement with 
		 * arbitrary parameters
		 * 
		 * @param  the SQL statement from which to replace tokens
		 * @param  arbitrary values of specified tokens
		 * @return a new String containing th ereplaced values
		 * 
		 */		
		public static function create(statement:String, ...args) : String
		{
			return StringUtil.substitute(statement, args.toString().split(","));
		}
	}
}



