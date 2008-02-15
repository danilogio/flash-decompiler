/*
 Copyright (c) 2006 - 2007 Eric J. Feminella <eric@ericfeminella.com>
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

 @ignore
 */

package com.ericfeminella.errors
{
    import mx.utils.StringUtil;
    
    /**
     * 
     * Pseudo-abstract base class which provides an API allowing 
     * concrete implementations to replace tokens with an arbitrary
     * parameters
     * 
     * <pre>
     * Below is an example of an AbstractException sub class
     * 
     * package 
     * {
     *    public class SimpleError extends AbstractException
     *    {
     *        public static const MESSAGE:String = "Error {0}";
     *        
     *        public function SimpleError(detail:String)
     *        {
     *             super(SimpleError.MESSAGE, detail);
     *        }
     * }
     * </pre>
     * 
     */
	internal class AbstractException extends Error
	{
		/**
		 * Constructor
		 * 
		 * @param the message String associated with the error
		 * @param arguments to replace tokens in error message
		 */		
		public function AbstractException(message:String, ...args)
		{
			super(StringUtil.substitute(message, args));
		}
	}
}


