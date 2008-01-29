package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;

	public class FrameLabelTag extends Tag
	{
		public override function toString ():String {
			return "Frame Label Tag: " + super.toString();
		}
				
	}
}