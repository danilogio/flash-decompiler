package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.util.SWFParser;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class LoadLocalSWF implements ICommand
	{

		private var model:DecompilerModelLocator;
		
		public function execute(event:CairngormEvent):void
		{
			model = DecompilerModelLocator.getInstance();
			model.currentState = DecompilerModelLocator.LOADING_STATE;
			var path:String = event.data as String;
					
			var file:File = new File(path);
			if (!file.exists) {
				trace ("doesn't exit");
				model.currentState = DecompilerModelLocator.ERROR_STATE;
				return;
			}
			try {
				var bytes:ByteArray = readSWFFile(file);
				model.currentState = DecompilerModelLocator.PARSING_STATE;
				bytes.endian = Endian.LITTLE_ENDIAN;			
				SWFParser.parseSWF(bytes);
				model.currentState = DecompilerModelLocator.PARSED_STATE;
			} catch (error:Error) {
				trace (error);
				model.currentState = DecompilerModelLocator.ERROR_STATE;
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

	}
}