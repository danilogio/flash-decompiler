package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class MetaDataTag extends Tag
	{
		public override function toString ():String {
			return "Meta Data Tag: " + super.toString();
		}
		
	}
}