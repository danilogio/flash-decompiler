package com.ludicast.decompiler.vo {

	import flash.utils.ByteArray;
	
	public class Tag
	{
		public var tag:int;
		public var size:int;
		protected var _dump:ByteArray;
		public var id:uint;

		//should almost always be overridden
		public function set dump(array:ByteArray):void {
			_dump = array;
		}
		
		public function get dump():ByteArray {
			return _dump;
		}

		public function toString():String {
			return ("Tag:" + tag + " Size:" + size + " Id:" + id);
		}
	}
}