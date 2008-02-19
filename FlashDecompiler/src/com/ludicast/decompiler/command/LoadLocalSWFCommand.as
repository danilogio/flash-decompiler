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

	public class LoadLocalSWFCommand implements ICommand
	{

		private var model:DecompilerModelLocator;
		
		public function execute(event:CairngormEvent):void
		{
			model = DecompilerModelLocator.getInstance();
			model.loadProgress = DecompilerModelLocator.LOAD_PROGRESS_LOADING;
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

	}
}