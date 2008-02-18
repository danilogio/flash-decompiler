package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ericfeminella.sql.ISQLResponder;
	import com.ludicast.decompiler.business.CreateTableDelegate;
	import com.ludicast.decompiler.business.SQLStatementConfiguration;
	import com.ludicast.decompiler.controller.DecompilerController;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.errors.SQLError;

	public class InitializeDatabase implements ICommand, ISQLResponder
	{
		private static var initialized:Boolean = false;
		private var exampleDB:SQLConnection;


		public function execute(event:CairngormEvent):void
		{
			if (initialized) {return};
		/*	
			var exampleDBFile:File = new File("app:/NewDB.db");
			trace (exampleDBFile.nativePath);
			exampleDB = new SQLConnection();
    		exampleDB.addEventListener(SQLEvent.OPEN, onExampleDBOpened);
    		exampleDB.addEventListener(SQLErrorEvent.ERROR, onExampleDBError);
    		exampleDB.open(exampleDBFile);
*/

			var delegate:CreateTableDelegate = new CreateTableDelegate( this );
			delegate.create(SQLStatementConfiguration.CREATE_SWF_TABLE);
			delegate.create(SQLStatementConfiguration.CREATE_TAG_TABLE);			
			initialized = true;
		}

		public function result(evt:SQLResult) : void 
		{
			trace ("result" + evt.data);
			var event:CairngormEvent = new CairngormEvent(DecompilerController.SELECT_ALL_SWFS);
			event.dispatch();
			//UserAccountsModelLocator.getInstance().resultMessage = "Operation complete";
		}
		
		public function fault(error:SQLError) : void 
		{
			trace ("fault" + error);
			var event:CairngormEvent = new CairngormEvent(DecompilerController.SELECT_ALL_SWFS);
			event.dispatch();
			//UserAccountsModelLocator.getInstance().resultMessage = error.message;
		}

		
	}
}