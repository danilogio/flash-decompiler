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

package com.ericfeminella.sql
{
	import com.ericfeminella.errors.SQLServiceConnectionException;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;

	/**
	 * Provides an API from which Adobe AIR SQL classes can be managed
	 * uniformly as a consolidated Service when building an application
	 * on Adobe Cairngorm 2.1.1
	 * 
	 */	
	public class SQLService
	{
		/**
		 * Represents the physical file which contains the 
		 * local database
		 */
		protected var databaseFile:File;
		
		/**
		 * the name of the local SQLite database
		 */
		protected var databaseFileName:String;
		
		/**
		 * the path to the local SQLite database
		 */
		protected var databaseFilePath:String;
				
		/**
		 * SQLConnection which the Service is connected
		 */
		protected var databaseConnection:SQLConnection;	
		
		/**
		 * the current version of the SQLService database
		 */
		protected var databaseVersion:int;
        
		/**
		 * SQLStatement from which queries are executed on
		 */
		protected var statement:SQLStatement;
		
		/**
		 * Creates a new instance of SQLService and initiates
		 * members
		 */		
		public function SQLService()
		{
			this.databaseConnection = new SQLConnection();
			this.statement = new SQLStatement();
		}
		
		/**
		 * Retrieves the path to the local SQLite database
		 * 
		 * @return the qualified path of the SQLite database
		 * 
		 */	    
		public function get localDatabaseFilePath() : String
		{
			return databaseFilePath;
		}
		
		/**
		 * Sets the path to the local SQLite database 
		 */	
		public function set localApplicationDirectory(dir:File):void {
			localDatabaseFilePath = dir.nativePath;
		} 
		 
		 
		public function set localDatabaseFilePath(path:String) : void
		{
			trace ("path!!!"  + path );
		    databaseFilePath = path;
		}
		
		/**
		 * Retrieves the name of the local SQLite database
		 * 
		 * @return the name of the local SQLite database
		 *  
		 */	
		public function get localDatabaseFileName() : String
		{
			return databaseFileName;
		}
		
		/**
		 * Sets the name of the local SQLite database 
		 */
		public function set localDatabaseFileName(fileName:String) : void
		{
			databaseFileName = fileName;
		}
		
		/**
		 * Retrieves the local SQLite database file object
		 * 
		 * @return the local SQLite database file object
		 * 
		 */	
		public function get localDatabaseFile() : File
		{
			return databaseFile;
		}
		
		/**
		 * Retrieves the SQLService SQLStatement instance
		 * 
		 * @return SQLService SQLStatement instance
		 * 
		 */		
		public function getSQLStatement() : SQLStatement
		{
			return statement;
		}
		
		/**
		 * Retrieves the SQLService SQLConnection instance
		 * 
		 * @return SQLService SQLConnection instance
		 * 
		 */	
		public function getSQLConnection() : SQLConnection
		{
			return databaseConnection;
		}
		
		/**
		 * Sets the version for the local SQLite database 
		 */
		public function set version(release:int) : void
		{
			databaseVersion = release;
		}
		
		/**
		 * Retrieves the local SQLite database version
		 * 
		 * @return the local SQLite database file object
		 * 
		 */	
		public function get version() : int
		{
			return databaseVersion;
		}
			
		/**
		 * Provides a mechanism for opening the connection via an mxml 
		 * implementation
		 * 
		 * @param the version of the database
		 * 
		 */
		public function open() : void
		{
			databaseFile = new File(databaseFilePath + File.separator + databaseFileName);

			databaseConnection = new SQLConnection();
		    databaseConnection.addEventListener(SQLEvent.OPEN, openResult);
		    databaseConnection.addEventListener(SQLErrorEvent.ERROR, openException);
		    databaseConnection.open( databaseFile );
		}
		
		/**
		 * Handles SQLEvent result upon database connection
		 * 
		 * @param SQLEvent
		 * 
		 */
		private function openResult(result:SQLEvent) : void
		{
		    //databaseConnection.version = databaseVersion;
		}
		
		/**
		 * @private
		 */
		private function openException(error:SQLErrorEvent) : void
		{
			throw new SQLServiceConnectionException(databaseFilePath, databaseFileName);
		}
		
		/**
		 * Executes a specific SQL operation on the SQLService 
		 * 
		 * @param the SQL statement in which to execute
		 * @param responder which handles the operation result / fault
		 * @param optional prefetch
		 * 
		 */
		public function execute(statement:String, responder:ISQLResponder, dataType:Class = null, prefetch:int = -1.0) : void
		{
			this.statement = new SQLStatement();
			open();			
			this.statement.sqlConnection = databaseConnection;
			this.statement.text = statement;
			
			if (dataType != null)
			{
				this.statement.itemClass = dataType;
			}
			
			
			trace ("dbconnection " + databaseConnection);

			trace ("opened with responder " + responder);
			this.statement.execute(prefetch, new Responder( responder.result, responder.fault) );
		}
	}
}

