package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ericfeminella.aircairngorm.business.AIRServiceLocator;
	import com.ericfeminella.sql.ISQLResponder;
	import example.cairngorm.air.business.CreateTableDelegate;
	import example.cairngorm.air.business.SQLStatementConfiguration;
	import example.cairngorm.air.business.Services;
	import example.cairngorm.air.model.UserAccountsModelLocator;	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	public class CreateTableCommand implements ICommand, ISQLResponder
	{
		public function execute(event:CairngormEvent) : void
		{
			var delegate:CreateTableDelegate = new CreateTableDelegate( this );
			delegate.create(SQLStatementConfiguration.CREATE_TABLE);
			
			//UserAccountsModelLocator.getInstance().resultMessage = AIRServiceLocator.getInstance().getSQLService(Services.RDBMS).getSQLStatement().text;
		}
		
		public function result(evt:SQLResult) : void 
		{
			//UserAccountsModelLocator.getInstance().resultMessage = "Operation complete";
		}
		
		public function fault(error:SQLError) : void 
		{
			//UserAccountsModelLocator.getInstance().resultMessage = error.message;
		}
	}
}

