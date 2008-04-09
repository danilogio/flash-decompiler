package com.ludicast.decompiler.vo
{
	import com.ludicast.decompiler.util.tag.DoABCTag;
	import com.ludicast.decompiler.util.tamarin.Traits;
	
	public class AS3Class
	{
		public var className:String = "";
		public var packageName:String = "";
		public var parentTag:DoABCTag = null;
		public var traits:Traits = null;
		
		public function AS3Class(name:String, parentTag:DoABCTag, traits:Traits) {
			var colonIndex:Number = name.indexOf("::");
			if (colonIndex == -1) {
			//	throw new Error("INVALID CLASS!!!");
				this.className = this.packageName = name;
			} else {
				this.className = name.substring(colonIndex + 2, name.length - 1);
				this.packageName = name.substring(0,colonIndex);
			}
			this.parentTag = parentTag;
			this.traits = traits;
		}
	}
}