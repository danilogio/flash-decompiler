package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class ImportAssetsTag extends Tag
	{
		public override function toString ():String {
			return "Import Assets Tag: " + super.toString();
		}
		
	}
}