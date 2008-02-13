package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class EndTag extends Tag
	{
		public override function toString ():String {
			return "End Tag: " + super.toString();
		}
		
	}
}