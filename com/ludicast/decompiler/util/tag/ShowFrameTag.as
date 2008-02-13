package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class ShowFrameTag extends Tag
	{
		public override function toString ():String {
			return "Show Frame Tag: " + super.toString();
		}
		
	}
}