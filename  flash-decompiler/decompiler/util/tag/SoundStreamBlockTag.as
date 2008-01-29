package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class SoundStreamBlockTag extends Tag
	{
		public override function toString ():String {
			return "Sound Stream Block Tag: " + super.toString();
		}
		
	}
}