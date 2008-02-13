package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class ExportAssetsTag extends Tag
	{
		public override function toString ():String {
			return "Export Assets Tag: " + super.toString();
		}
		
	}
}