package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class SymbolClassTag extends Tag
	{
		public override function toString ():String {
			return "Symbol Class Tag: " + super.toString();
		}
	}
}