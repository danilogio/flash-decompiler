package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.util.Abc;
	import com.ludicast.decompiler.util.ByteCodePrinter;
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	
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

			abcData.endian = Endian.LITTLE_ENDIAN;
		//	trace ("here");
		//	trace (ByteCodePrinter.prettyPrint(array));
		//	trace ("there");
			for (var i:Number = 4; i < array.length; i++) {
				abcData[i - 4] = array[i];
			}
	
	//try diff...
			trace ("set bd" + _byteData);
		}

		public override function get tagData():String {
			return "Flags:" + flags  + " " + byteData[0] + " " +byteData[1] + " " + byteData[2] + " " + byteData[3] + 
				   "\n\nDoABC\n\n" + parseDoABC ();
		}		

		public function parseDoABC():String {
			//return "Minor " + abcData.readUnsignedShort() + "\n" + "Major " + abcData.readUnsignedShort(); 
			var name:String = readString();//return ByteCodePrinter.prettyPrint(abcData);
			var newArray:ByteArray = new ByteArray();
			trace ("newpos" + abcData.position);
			trace ("nl " + name.length);
			abcData.readBytes(newArray,0,abcData.length - abcData.position);
			abcData = newArray;
			abcData.endian = Endian.LITTLE_ENDIAN;
			//trace (ByteCodePrinter.prettyPrint(abcData));
			//var abc:Abc = new Abc(abcData);
			return name;
		}


		//from tamarin project
		private function readString():String
		{
			trace ("pos: " + abcData.position);
			var s:String = "";
			var c:int;

			while (c=abcData.readUnsignedByte())
				s += String.fromCharCode(c);

			return s;
		}
			
	}
}