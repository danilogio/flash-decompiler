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

 @ignore
 */

package com.ericfeminella.sql
{
	/**
	 * 
	 * ISQLStatementResource is a marker interfaces which is intended to improve
	 * code readability by indicating that a class which implements this interface 
	 * is to provide access to external SQL statements defined in a .properties
	 * file
	 * 
	 * <pre>
	 * package example.cairngorm.air.business
	 * {
	 *    import mx.resources.ResourceBundle;
	 *    import mx.resources.ResourceManager;
	 *    import mx.resources.IResourceManager;
	 * 
	 *    public final class SQLStatementConfiguration implements ISQLStatementResource
	 *    {
	 * 	     [ResourceBundle('queries')]
	 *       private static const resource:ResourceBundle;
	 * 
	 *       private static const rm:IResourceManager = ResourceManager.getInstance();
	 * 	
	 *       public static const INSERT:String = rm.getString("queries", "INSERT");
	 *       public static const SELECT:String = rm.getString("queries", "SELECT");
	 *       public static const UPDATE:String = rm.getString("queries", "UPDATE");
	 * 	     public static const DELETE:String = rm.getString("queries", "DELETE");
	 *    }
	 * }
	 * </pre>
	 * 
	 * <pre>
	 * 
	 * queries.properties:
	 * INSERT=INSERT INTO users VALUES('{0}', '{1}')
	 * SELECT=SELECT * FROM users
	 * UPDATE=UPDATE users SET password='{0}' WHERE username = '{1}'
	 * DELETE=DELETE FROM users WHERE username = '{0}'
	 * 
	 * </pre>
	 * 
	 */	
	public interface ISQLStatementResource {
	}
}


