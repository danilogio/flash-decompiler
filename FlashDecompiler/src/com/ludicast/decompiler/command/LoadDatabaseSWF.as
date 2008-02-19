package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ericfeminella.sql.ISQLResponder;
	import com.ericfeminella.sql.SQLStatementHelper;
	import com.ludicast.decompiler.business.SQLStatementConfiguration;
	import com.ludicast.decompiler.business.SelectSWFDelegate;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.util.SWFParser;
	import com.ludicast.decompiler.vo.SWFVO;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class LoadDatabaseSWF implements ICommand, ISQLResponder
	{

		private var model:DecompilerModelLocator;
		
		public function execute(event:CairngormEvent):void
		{
			model = DecompilerModelLocator.getInstance();
			model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_LOADING;
			loadSWF(event.data);
		}
		
		public function loadSWF(id:uint):void {
			var statement:String = SQLStatementHelper.create(
				SQLStatementConfiguration.SELECT_SWF_BY_ID, id
			);
			var delegate:SelectSWFDelegate = new SelectSWFDelegate(this);	
			delegate.select(statement, SWFVO);
			
			
		}
			
		public function result(evt:SQLResult):void {
			//var model:UserAccountsModelLocator = UserAccountsModelLocator.getInstance();
			//model.resultMessage = "OPERATION COMPLETED";
		//	model.users.source = null;
			
		//	var i:int = 0;
			var n:int = evt.data.length;
			if (evt.data.length != 1) {
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_ERROR;
				trace ("return error!!!!");return;	
			}
			//for (i; i < n; i++) {
			var vo:SWFVO = evt.data[0] as SWFVO;
			trace ("got vo " + vo.name);
			try {
				var bytes:ByteArray = vo.rawData;
				trace ("bytes is " + bytes.length);
				//no good reads 8
				bytes.endian = Endian.LITTLE_ENDIAN;			
				SWFParser.parseSWF(bytes);
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_PARSED ;	
				model.swfProps.remote = vo.remote;
				model.swfProps.location = vo.location;
				model.swfProps.name = vo.name;
				model.swfProps.id = vo.id;
			} catch (error:Error) {
				trace (error);
				trace (error.getStackTrace());
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_ERROR;
				return;
			}
		}
		
		public function fault(error:SQLError):void
		{
			trace ("had fault" + error);
		}

/*		


		
			var file:File = event.data as File;
			
			if (file == null || !file.exists) {
				trace ("doesn't exit");
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_ERROR;
				return;
			}
			try {
				var bytes:ByteArray = readSWFFile(file);
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_PARSING;
				bytes.endian = Endian.LITTLE_ENDIAN;			
				SWFParser.parseSWF(bytes);
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_PARSED ;
				model.swfProps.remote = false;
				model.swfProps.location = file.nativePath;
				model.swfProps.name = file.name;
			} catch (error:Error) {
				trace (error);
				trace (error.getStackTrace());
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_ERROR;
				return;				
			}

		}

		public function readSWFFile(file:File):ByteArray {
			var bytes:ByteArray = new ByteArray();
			var fileStream:FileStream = new FileStream();
			fileStream.open(file,FileMode.READ);
			fileStream.readBytes(bytes,0,0);
			trace ("bl:" + bytes.length);
			return bytes;
		}

*/
	}
}