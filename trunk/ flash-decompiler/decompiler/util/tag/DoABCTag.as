package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.util.ByteCodePrinter;
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;
	
	
	public class DoABCTag extends Tag
	{
		public var flags:uint;
		public var abcData:ByteArray;
		
		public override function toString ():String {
			return "DoABC Tag: " + super.toString();
		}

		public override function set byteData (array:ByteArray):void {
			super.byteData = array;
			flags = array.readUnsignedInt();
			
			abcData = new ByteArray();
			for (var i:Number = 4; i < array.length; i++) {
				abcData[i - 4] = array[i];
			}
	
	//try diff...
			trace ("set bd" + _byteData);
		}

		public override function get tagData():String {
			return "Flags:" + flags  + " " + byteData[0] + " " +byteData[1] + " " + byteData[2] + " " + byteData[3]
				   "\n\nDoABC\n\n" + parseDoABC ();
		}		

		public function parseDoABC():String {
			//return "Minor " + abcData.readUnsignedShort() + "\n" + "Major " + abcData.readUnsignedShort(); 
			return ByteCodePrinter.prettyPrint(abcData);
		}
			
	}
}