package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;

	public class DefineTextTag extends Tag
	{
		public override function toString ():String {
			return "Define Text Tag: " + super.toString();
		}
	}
}