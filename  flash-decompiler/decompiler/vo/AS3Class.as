package com.ludicast.decompiler.vo
{
	import com.ludicast.decompiler.util.tag.DoABCTag;
	
	public class AS3Class
	{
		public var className:String = "";
		public var packageName:String = "";
		public var parentTag:DoABCTag = null;
		
		public function AS3Class(className:String, packageName:String, parentTag:DoABCTag) {
			this.className = className;
			this.packageName = packageName;
			this.parentTag = parentTag;
		}
	}
}