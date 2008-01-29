package com.ludicast.decompiler.util
{
	import com.ludicast.decompiler.util.tag.EndTag;
	import com.ludicast.decompiler.util.tag.ExportAssetsTag;
	import com.ludicast.decompiler.util.tag.FrameLabelTag;
	import com.ludicast.decompiler.util.tag.ProtectTag;
	import com.ludicast.decompiler.util.tag.SetBackgroundColorTag;
	import com.ludicast.decompiler.vo.Tag;
	
	public class TagFactory
	{
		static public function getTagById(id:Number):Tag {
			switch (id) {
				case 0: 
					return new EndTag();
				case 9:
					return new SetBackgroundColorTag();
				case 24:
					return new ProtectTag();
				case 43:
					return new FrameLabelTag();
				case 56:
					return new ExportAssetsTag();
				default:
					return new Tag();
			}
			
			
			
		}
		
		public function TagFactory()
			{
			super();
		}

	}
}