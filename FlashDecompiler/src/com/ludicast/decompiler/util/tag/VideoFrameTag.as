package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class VideoFrameTag extends Tag
	{
		public override function toString ():String {
			return "Video Frame Tag: " + super.toString();
		}
		
	}
}