package com.ludicast.decompiler.util
{
	import com.ludicast.decompiler.util.tag.DefineScalingGridTag;
	import com.ludicast.decompiler.util.tag.EnableDebugger2Tag;
	import com.ludicast.decompiler.util.tag.EnableDebuggerTag;
	import com.ludicast.decompiler.util.tag.EndTag;
	import com.ludicast.decompiler.util.tag.ExportAssetsTag;
	import com.ludicast.decompiler.util.tag.FileAttributesTag;
	import com.ludicast.decompiler.util.tag.FrameLabelTag;
	import com.ludicast.decompiler.util.tag.ImportAssets2Tag;
	import com.ludicast.decompiler.util.tag.ImportAssetsTag;
	import com.ludicast.decompiler.util.tag.MetaDataTag;
	import com.ludicast.decompiler.util.tag.ProtectTag;
	import com.ludicast.decompiler.util.tag.ScriptLimitsTag;
	import com.ludicast.decompiler.util.tag.SetBackgroundColorTag;
	import com.ludicast.decompiler.util.tag.SetTabIndexTag;
	import com.ludicast.decompiler.util.tag.SymbolClassTag;
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
				case 57:
					return new ImportAssetsTag();
				case 58:
					return new EnableDebuggerTag();
				case 64:
					return new EnableDebugger2Tag();										
				case 65:
					return new ScriptLimitsTag();
				case 66:
					return new SetTabIndexTag();
				case 69:
					return new FileAttributesTag();
				case 71:
					return new ImportAssets2Tag();
				case 76:
					return new SymbolClassTag();
				case 77:
					return new MetaDataTag();
				case 78:
					return new DefineScalingGridTag();
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