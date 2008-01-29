package com.ludicast.decompiler.vo
{
	import flash.utils.ByteArray;
	
	public class Tag
	{
		public var tag:int;
		public var size:int;
		public var dump:ByteArray;
		public var id:uint;
		
		public function toString():String {
			return ("Tag:" + tag + " Size:" + size + " Id:" + id);
		}
	}
}