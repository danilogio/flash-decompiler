package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ericfeminella.aircairngorm.business.AIRServiceLocator;
	import com.ericfeminella.sql.ISQLResponder;
	import com.ericfeminella.sql.SQLStatementHelper;
	import com.ludicast.decompiler.business.CreateSWFDelegate;
	import com.ludicast.decompiler.business.SQLStatementConfiguration;
	import com.ludicast.decompiler.business.Services;
	import com.ludicast.decompiler.controller.DecompilerController;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.vo.SWFVO;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.errors.SQLError;

	public class SaveCurrentSWF implements ICommand, ISQLResponder
	{
		private var exampleDB:SQLConnection;
		private var model:DecompilerModelLocator;
		private var vo:SWFVO;
		
		public function execute(event:CairngormEvent):void
		{
			model = DecompilerModelLocator.getInstance();			

			vo = model.swfProps;
			var delegate:CreateSWFDelegate = new CreateSWFDelegate( this );

			var statement:String = SQLStatementHelper.create(
				SQLStatementConfiguration.INSERT_SWF,
				vo.name,
				vo.remote,		
				vo.location,						
				vo.version,
				vo.compressed,
				vo.fileLength,
				vo.width,
				vo.height,
				vo.frameRate,
				vo.frameCount
			);
			var params:Array = [vo.rawData];

			/*for (var i:uint; i < params.length; i++) {
				trace ("jknjnkjjI@@@@" + i + "lxslsls" + params[i]);
			}*/
			delegate.insert(statement,params);		

			trace ("insertion text : " + AIRServiceLocator.getInstance().getSQLService(Services.RDBMS).getSQLStatement().text);
		}

		public function result(evt:SQLResult) : void 
		{
			trace ("result" + evt.lastInsertRowID);
			vo.id = evt.lastInsertRowID;

			var event:CairngormEvent = new CairngormEvent(DecompilerController.SELECT_ALL_SWFS);
			event.dispatch();			

			//UserAccountsModelLocator.getInstance().resultMessage = "Operation complete";
		}
		
		public function fault(error:SQLError) : void 
		{
			trace ("fault" + error);
			//UserAccountsModelLocator.getInstance().resultMessage = error.message;
		}

		
	}
}