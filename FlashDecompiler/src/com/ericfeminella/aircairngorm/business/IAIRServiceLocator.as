/*
 Copyright (c) 2007 Eric J. Feminella <eric@ericfeminella.com>
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

package com.ericfeminella.aircairngorm.business
{
	import com.ericfeminella.sql.SQLService;
	import flash.data.SQLConnection;
	import flash.filesystem.File;

	/**
	 * 
	 * Provides a mechanism from which specific APIs Adobe AIR 
	 * APIs (e.g. SQLConnection, SQLStatement) can be located 
	 * on a ServiceLocator instance
	 * 
	 */ 
	public interface IAIRServiceLocator
	{
        /**
         * Retrieves the unique SWLService registered to the IAIRServiceLocator
         * 
         * @param  the unique identifier of the SQLService
         * @return the SQLService instance with the specified name
         * 
         */		
		function getSQLService(name:String) : SQLService;
	}
}


