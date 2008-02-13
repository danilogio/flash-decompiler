package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class PlaceObjectTag extends Tag
	{
		public override function toString ():String {
			return "Place Object Tag: " + super.toString();
		}
		
	}
}