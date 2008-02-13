package com.ludicast.decompiler.vo {

	import com.ludicast.decompiler.util.ByteCodePrinter;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class Tag
	{
		public var tag:int;
		public var size:int;
		protected var _byteData:ByteArray;
		public var id:uint;

		//should almost always be overridden
		public function set byteData(array:ByteArray):void {
			_byteData = array;
			_byteData.endian = Endian.LITTLE_ENDIAN;			
		}
		
		public function get byteData():ByteArray {
			return _byteData;
		}

		public function get tagData():String {
			return ByteCodePrinter.prettyPrint(_byteData);
		}

		public function toString():String {
			return ("Tag:" + tag + " Size:" + size + " Id:" + id);
		}
	}
}