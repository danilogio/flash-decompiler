package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class ScriptLimitsTag extends Tag
	{
		public override function toString ():String {
			return "Script Limits Tag: " + super.toString();
		}
		
	}
}