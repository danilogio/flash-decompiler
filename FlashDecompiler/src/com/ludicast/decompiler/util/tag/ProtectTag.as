package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class ProtectTag extends Tag
	{
		public override function toString ():String {
			return "Protect Tag: " + super.toString();
		}
		
	}
}