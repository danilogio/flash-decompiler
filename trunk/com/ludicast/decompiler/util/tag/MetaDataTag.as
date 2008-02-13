package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;

	public class MetaDataTag extends Tag
	{
		public var dataXML:XML;
		public override function toString ():String {
			return "Meta Data Tag: " + super.toString();
		}

		public override function set byteData (array:ByteArray):void {
			super.byteData = array;
			var dataString:String = "";
			for (var i:Number = 0; i < array.length; i++) {
				dataString += String.fromCharCode(array[i]);
			}
			dataXML = new XML(dataString);		
			trace ("set bd" + _byteData);
		}		
	
		public override function get tagData():String {
			return "Metadata XML\n\n" + dataXML.toXMLString();
		}		
	}
}