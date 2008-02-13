package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.view.tags.BackgroundTagView;
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;
	
	import mx.core.Container;

	public class SetBackgroundColorTag extends Tag implements IDescribableComponent
	{
		public var red:uint;
		public var green:uint;
		public var blue:uint;
		public override function toString ():String {
			return "Set Background Color Tag: " + super.toString();
		}
				
		public override function set byteData (array:ByteArray):void {
			super.byteData = array;
			red = array[0];
			green = array[1];
			blue = array[2];
			trace ("set bd" + _byteData);
		}		
	
		public override function get tagData():String {
			return "Red:" + red + " Green:" + green + " Blue:" + blue;
		}
		
		public function getDescribingComponent():Container {
			var desc:BackgroundTagView = new BackgroundTagView();
			desc.backgoundColor = uint(red << 16 | green << 8 | blue);
			
			return desc;
		}
	}
}