package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;
	
	public class FrameLabelTag extends Tag
	{
		public var frameLabel:String;
		public override function toString ():String {
			return "Frame Label Tag: " + super.toString();
		}

		public override function set byteData (array:ByteArray):void {
			super.byteData = array;
			frameLabel = "";
			for (var i:Number = 0; i < array.length; i++) {
				frameLabel += String.fromCharCode(array[i]);
			}
			trace ("set bd" + _byteData);
		}		
	
		public override function get tagData():String {
			return "Frame Label: " + frameLabel;
		}
				
	}
}