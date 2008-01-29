package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class JpegTablesTag extends Tag
	{
		public override function toString ():String {
			return "Jpeg Tables Tag: " + super.toString();
		}
		
	}
}