package com.ludicast.decompiler.util
{
	import flash.utils.ByteArray;
	
	import mx.automation.codec.ArrayPropertyCodec;
	
	public class HeaderParser
	{
		public static const MIN_BYTES:Number = 40;
		
		public function HeaderParser()
			static public function hasSWFSignature(array:ByteArray):Boolean {
				if (array == null || array.length < MIN_BYTES) {
					return false;
				} 
				var magic:String =  String.fromCharCode(array[0]) + 
									String.fromCharCode(array[1]) + 
									String.fromCharCode(array[2]);
									
				if (magic == "CWS" || magic == "FWS") {
					return true;					
				} else {
					return false;
				}			
			
			}

			static public function isCompressed(array:ByteArray):Boolean {
				var compressed:String =  String.fromCharCode(array[0]);
				
				if (compressed == "C") {
					return true;					
				} else {
					return false;
				}						
			}

			static public function getVersion(array:ByteArray):uint {
				return (array[3] as uint);
			}

			static public function getSize(array:ByteArray):uint {
				var position:uint = array.position;
				trace ("positionIs" + position);
				array.position = 4;
				var length:uint = array.readUnsignedInt();
				array.position = position;
				return length;
			}

			static public function moveTo(array:ByteArray):void {
				trace ("ap" + array.position);
				array.readInt();
				
				array.readInt();
				trace ("ap" + array.position);				
				array.readBytes(array);
				array.length -=8;				
			}

			static public function uncompress(array:ByteArray):void {
				array.uncompress();
			}


	}
}