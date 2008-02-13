package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class EnableDebuggerTag extends Tag
	{
		public override function toString ():String {
			return "Enable Debugger Tag: " + super.toString();
		}
		
	}
}