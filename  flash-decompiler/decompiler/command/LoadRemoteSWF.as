package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ludicast.decompiler.error.SWFParseError;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.util.HeaderParser;
	import com.ludicast.decompiler.util.TagParser;
	import com.ludicast.decompiler.vo.SWFPropsVO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import mx.collections.ArrayCollection;

	public class LoadRemoteSWF implements ICommand
	{
		private var loader:URLLoader;
		
		public function execute(event:CairngormEvent):void
		{
			var url:String = event.data;
			trace ("loading remote swf" + url);
			
			
			var urlReq:URLRequest = new URLRequest(url);
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, loaded);
			loader.load(urlReq);
		}

		public function getDataString(byteArray:ByteArray):String {
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
			return fullString;		
		}
		
		public function loaded(event:Event):void {
			trace ("bl" + loader.bytesLoaded);
			trace ("bt" + loader.bytesTotal);
			trace ("df" + loader.dataFormat);

			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(loader.data);
			byteArray = shiftBytesToStart(byteArray);
			byteArray.endian = Endian.LITTLE_ENDIAN;
						
			var propsVO:SWFPropsVO = new SWFPropsVO();			
			if (!HeaderParser.hasSWFSignature(byteArray)) {
				throw new SWFParseError("No swf signature");
			}
			
			propsVO.compressed = HeaderParser.isCompressed(byteArray);
		
			propsVO.version = HeaderParser.getVersion(byteArray);
			propsVO.fileLength = HeaderParser.getSize(byteArray);			

				
			HeaderParser.moveTo(byteArray);
			
			if (propsVO.compressed) {
				HeaderParser.uncompress(byteArray);
			} 


			byteArray.position = 0;
			var frame:Array = readBox(byteArray);
			
			propsVO.width = Math.round((frame[1]-frame[0])/20);
			propsVO.height =  Math.round((frame[3]-frame[2])/20);			

			var fps_f:uint = byteArray.readUnsignedByte();
			var fps_i:uint = byteArray.readUnsignedByte();

			propsVO.frameRate = (fps_i+fps_f/256);
			propsVO.frameCount = byteArray.readUnsignedShort();

			DecompilerModelLocator.getInstance().swfProps = propsVO;


			var tags:ArrayCollection = TagParser.getTags(byteArray);

			
			
			DecompilerModelLocator.getInstance().dataString = getDataString(byteArray);
			
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










/*
Simple SWF parser
Written by Denis V. Chumakov 
http://flashpanoramas.com/blog/
Use this code without any restrictions.
*/



// log string
	private var parseLog:String;

// handlers for SWF tags
// for example: 
// handlers[6] = parseJPEG; 
// to set your handler for DefineBitsJPEG tag.
// you can find SWF file specifications in Google.
	private var handlers:Array = [];

// parse SWF file
/*	private function parseSWF(data:ByteArray):void {
	parseLog = "";
	data.endian = Endian.LITTLE_ENDIAN;
	var format:String = data.readUTFBytes(3);
	var compressed:Boolean = format=="CWS";
	if (format=="FWS" || format=="CWS") {
		parseLog += "SWF version "+data.readByte();
		parseLog += ", size: "+data.readUnsignedInt();
	} else {
		parseLog += "Not a Flash file.";
		return;
	}
	
	//trace (getDataString(data));	
	
	data.readBytes(data);
	data.length -= 8;
//	trace (getDataString(data));
	trace ("data info" + data.length + ":" + data.position);
	if (compressed) {
		data.uncompress();
	}

	
	data.position = 0;
	var frame:Array = readBox(data);
	parseLog += "\n";
	parseLog += "Width: "+Math.round((frame[1]-frame[0])/20);
	parseLog += ", height: "+Math.round((frame[3]-frame[2])/20);
	var fps_f:uint = data.readUnsignedByte();
	var fps_i:uint = data.readUnsignedByte();
	parseLog += "\n";
	parseLog += "FPS: "+(fps_i+fps_f/256);
	var count:uint = data.readUnsignedShort();
	parseLog += "\n";
	parseLog += "Total frames: "+count;
	parseLog += "\n";
	while (data.bytesAvailable) {
		readSWFTag(data);
	}
	trace(parseLog);
}

*/

// read SWF tag and call handler if present


// read compressed box format
	private function readBox(data:ByteArray):Array {
	var c:Array = [];
	var current:uint = data.readUnsignedByte();
	var size:uint = current>>3;
	var off:int = 3;
	for (var i:int=0; i<4; i+=1) {
		c[i] = current<<(32-off)>>(32-size);
		off -= size;
		while (off<0) {
			current = data.readUnsignedByte();
			c[i] |= off<-8?current<<(-off-8):current>>(-off-8);
			off += 8;
		}
	}
	return c;
}









		
	}
}