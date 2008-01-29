package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.vo.SWFPropsVO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class LoadRemoteSWF implements ICommand
	{
		private var loader:URLLoader;
		
		public function execute(event:CairngormEvent):void
		{
			var url:String = event.data;
			trace ("loading remote swf" + url);
			
			
			var urlReq:URLRequest = new URLRequest(url);
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaded);
			loader.load(urlReq);
//			var remoteText:
		}
		
		public function loaded(event:Event):void {
			trace ("bl" + loader.bytesLoaded);
			trace ("bt" + loader.bytesTotal);
			trace ("df" + loader.dataFormat);

			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(loader.data);
			byteArray = shiftBytesToStart(byteArray);

			byteArray.endian = Endian.LITTLE_ENDIAN;
			
			trace (byteArray.length);
			var hexString:String = "";
			var asciiString:String = "";
			
			var fullString:String = "";
			
			for (var i:Number = 0; i < byteArray.length; i++) {
				if (i % 16 == 0) {
					fullString += hexString + " " + asciiString + "\n";
					
					hexString = "";
					asciiString = "";
				}

				if (i % 8 == 0 && i % 16 != 0) {
					hexString += " ";
				}
				
				var byte:uint = byteArray[i];
				
				if (byte < 16) {
					hexString += "0" + byte.toString(16) + " ";
				} else {
					hexString += byte.toString(16) + " ";					
				}
				if (byte < 127 && byte >= 32) {
					asciiString += "" + String.fromCharCode(byte);
				} else {
					asciiString += ".";					
				}
			}
			fullString +=  hexString + " " + asciiString + "\n";
			DecompilerModelLocator.getInstance().dataString = fullString;

			DecompilerModelLocator.getInstance().swfProps = loadProps(byteArray);
		}
		protected function loadProps(bytes:ByteArray):SWFPropsVO {
			var vo:SWFPropsVO = new SWFPropsVO();
			
			var compressed:uint = bytes.readByte();
			if (String.fromCharCode(compressed) == "C") {
				vo.compressed = true;				
			} else if (String.fromCharCode(compressed) == "F") {
				vo.compressed = false;	
			} else {
				throw new Error("PARSE ERROR C/F");
			}
			if (!(String.fromCharCode(bytes.readByte()) == "W")) {
				throw new Error("PARSE ERROR W/S");				
			}

			if (!(String.fromCharCode(bytes.readByte()) == "S")) {
				throw new Error("PARSE ERROR W/S");				
			}


			trace ("new info");
			vo.version = bytes.readByte();			
			vo.fileLength = bytes.readUnsignedInt();//getFileLength(bytes);

			if (vo.compressed) {
				bytes = decompressSWF(bytes);
			}

			getRect(bytes);
			
			vo.frameRate = bytes.readUnsignedShort();
			vo.frameCount = bytes.readUnsignedShort();
			
			return vo;
		}

		protected function decompressSWF(bytes:ByteArray) :ByteArray {
			var newArray:ByteArray = new ByteArray();
			for (var i:uint = 8; i < bytes.length; i++) {
				newArray[i - 8] = bytes[i];
			}
			newArray.endian = Endian.LITTLE_ENDIAN;
			newArray.uncompress();
						
			return newArray;
			
		}

		protected function getRect(bytes:ByteArray):void {
			var firstByte:uint = bytes.readByte();

			var firstNum:uint = (firstByte & ( 31) );
			var totalLength:Number = 5 + firstNum * 4;
			var numBytes:Number =  Math.ceil(totalLength / 8);
			for (var i:uint = 1; i < numBytes; i++) {
				bytes.readByte();
			}
		}

		protected function shiftBytesToStart(bytes:ByteArray):ByteArray {
			
			var shiftValue:int = -1;
			for (var i:uint = 0; i < 50; i++) {
				if (String.fromCharCode(bytes[i + 1]) == "W" && 
				    String.fromCharCode(bytes[i + 2]) == "S") {
					if (String.fromCharCode(bytes[i]) == "C" || 
					    String.fromCharCode(bytes[i]) == "F" ) {
					    	shiftValue = i;
					    	break;
					    }
				}
			}
			if (shiftValue > -1) {
				trace ("shifting by " + shiftValue);
				var newBytes:ByteArray = new ByteArray();
				for (var j:Number = 0; j < bytes.length - shiftValue; j++) {
					newBytes[j] = bytes[j + shiftValue];
				}
				
				trace ("length:" + newBytes.length);
				trace (bytes.length);
				return newBytes;
			}
			throw new Error("invalid swf format");
			return null;
		}
		
	}
}