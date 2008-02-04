package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.view.tags.BackgroundTagView;
	import com.ludicast.decompiler.vo.Tag;
	
	import mx.core.Container;

	public class DefineButtonTag extends Tag
	{
		public override function toString ():String {
			return "Define Button Tag: " + super.toString();
		}
	}
}