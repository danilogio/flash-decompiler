package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.util.SWFParser;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class LoadRemoteSWF implements ICommand
	{
		private var loader:URLLoader;
		private var model:DecompilerModelLocator;
		
		public function execute(event:CairngormEvent):void
		{
			model = DecompilerModelLocator.getInstance();
			model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_LOADING;
			var url:String = event.data;	
			var urlReq:URLRequest = new URLRequest(url);
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, loaded);
			loader.load(urlReq);
		}

		public function loaded(event:Event):void {
			trace ("loaded!");
			model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_PARSING;		
			try {
				cleanAndParseSWF(event.currentTarget.data);
				trace ("there is try good");
			} catch (error:Error) {
				trace ("error here");
				model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_ERROR;
				return;			
			}
			trace ("parsed successfully");
			model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_PARSED;
		}

		public function cleanAndParseSWF(data:*):void {
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(data);
			byteArray = SWFParser.shiftBytesToStart(byteArray);
			byteArray.endian = Endian.LITTLE_ENDIAN;
			SWFParser.parseSWF(byteArray);				
		}

	}
}