package com.ludicast.decompiler.util
{
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	public class TagParser
	{
		static public function getTags(array:ByteArray):ArrayCollection {
			var tags:ArrayCollection = new ArrayCollection();
			
			while (array.bytesAvailable) {
				tags.addItem(getTag(array));
			}
			
			return tags;
		}
		
		static public function getTag(data:ByteArray):Tag {
			var tag:uint = data.readUnsignedShort();
			var id:int = tag>>6;
			var size:int = tag&0x3F;
			if (size == 0x3F) {
				size = data.readUnsignedInt();
			}
			var parseLog:String = "new Tag "+id;

				var dump:ByteArray = new ByteArray();
				if (size!=0) {
					data.readBytes(dump,0,size);
				}
	
			parseLog += "\tsize: "+size;
			var tagObj:Tag = TagFactory.getTagById(id);
			tagObj.id = id;
			tagObj.tag = tag;
			tagObj.size = size;
			tagObj.dump = dump;

			return tagObj;
		}
		
		
	}
}