package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class JPEGTablesTag extends Tag
	{
		public override function toString ():String {
			return "JPEG Tables Tag: " + super.toString();
		}
		
	}
}