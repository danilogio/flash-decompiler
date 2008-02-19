
package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ericfeminella.sql.ISQLResponder;
	import com.ericfeminella.sql.SQLStatementHelper;
	import com.ludicast.decompiler.business.SQLStatementConfiguration;
	import com.ludicast.decompiler.business.SelectSWFDelegate;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.vo.SWFVO;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;
	
	public final class SelectAllSWFsCommand implements ICommand, ISQLResponder
	{
		public function execute(event:CairngormEvent):void
		{	
			var delegate:SelectSWFDelegate = new SelectSWFDelegate( this );
			delegate.select( SQLStatementHelper.create(SQLStatementConfiguration.SELECT_ALL_SWFS), SWFVO);
			
			//UserAccountsModelLocator.getInstance().resultMessage = AIRServiceLocator.getInstance().getSQLService(Services.RDBMS).getSQLStatement().text;
		}
		
		public function result(evt:SQLResult):void
		{
			//var model:UserAccountsModelLocator = UserAccountsModelLocator.getInstance();
			//model.resultMessage = "OPERATION COMPLETED";
		//	model.users.source = null;
			
			var i:int = 0;
			if (evt.data == null) {
				DecompilerModelLocator.getInstance().savedSWFs = new ArrayCollection();
				return;
			}
			
			var n:int = evt.data.length;
			
			trace ("had result " + evt);

			var swfs:ArrayCollection = new ArrayCollection();			
			for (i; i < n; i++) {
				var vo:SWFVO = evt.data[i];
			//	model.users.addItem( user );
				swfs.addItem(vo);
				trace ("swf props " + i);
				trace (vo.id, vo.name, vo.version, vo.location, vo.remote);			
			}
			DecompilerModelLocator.getInstance().savedSWFs= swfs;
		}
		
		public function fault(error:SQLError):void
		{
			trace ("had fault" + error);
//			if (error.code == SQLError..OPERATION)
//			{
//				new CreateTableCommand().execute( new CairngormEvent("") );
//			}
	//		UserAccountsModelLocator.getInstance().resultMessage = "Creating TABLE users...";
		}
	}
}

