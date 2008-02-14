package com.ludicast.decompiler.util {
	import flash.utils.ByteArray;
	
	public class ByteCodePrinter {
		public static function prettyPrint(byteArray:ByteArray):String {
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
	}

}