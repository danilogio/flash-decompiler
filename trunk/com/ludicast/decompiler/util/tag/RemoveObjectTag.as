package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	import flash.utils.ByteArray;

	public class RemoveObjectTag extends Tag
	{
		public override function toString ():String {
			return "Remove Object Tag: " + super.toString();
		}
		
	}
}