package com.ludicast.decompiler.util
{
	import com.ludicast.decompiler.error.SWFParseError;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.vo.SWFPropsVO;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	public class SWFParser {



		
		static public function parseSWF(byteArray:ByteArray):void {
						
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
			DecompilerModelLocator.getInstance().tags = tags;

		}

		static public function shiftBytesToStart(bytes:ByteArray):ByteArray {
			
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
			throw new SWFParseError("invalid swf format");
			return null;
		}


		static private function readBox(data:ByteArray):Array {
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