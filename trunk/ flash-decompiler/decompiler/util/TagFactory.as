package com.ludicast.decompiler.util
{
	import com.ludicast.decompiler.util.tag.*;
	import com.ludicast.decompiler.vo.Tag;
	
	public class TagFactory
	{
		static public function getTagById(id:Number):Tag {
			switch (id) {
				case 0: 
					return new EndTag();
				case 1: 
					return new ShowFrameTag();
				case 2: 
					return new DefineShapeTag();
				case 4: 
					return new PlaceObjectTag();
				case 5: 
					return new RemoveObjectTag();
				case 6: 
					return new DefineBitsTag();
				case 8: 
					return new JpegTablesTag();
				case 9:
					return new SetBackgroundColorTag();
				case 10:
					return new DefineFontTag();
				case 12:
					return new DoActionTag();				
				case 13:
					return new DefineFontInfoTag();
				case 20: 
					return new DefineBitsLosslessTag();
				case 21: 
					return new DefineBitsJPEG2Tag();
				case 22: 
					return new DefineShape2Tag();
				case 24:
					return new ProtectTag();
				case 26: 
					return new PlaceObject2Tag();
				case 28: 
					return new RemoveObject2Tag();					
				case 32: 
					return new DefineShape3Tag();
				case 35: 
					return new DefineBitsJPEG3Tag();
				case 36: 
					return new DefineBitsLossless2Tag();
				case 39:
					return new DefineSpriteTag();
				case 43:
					return new FrameLabelTag();
				case 46:
					return new DefineMorphShapeTag();
				case 48:
					return new DefineFont2Tag();
				case 56:
					return new ExportAssetsTag();
				case 57:
					return new ImportAssetsTag();
				case 58:
					return new EnableDebuggerTag();
				case 59:
					return new DoInitActionTag();
				case 62:
					return new DefineFontInfo2Tag();					
				case 64:
					return new EnableDebugger2Tag();										
				case 65:
					return new ScriptLimitsTag();
				case 66:
					return new SetTabIndexTag();
				case 69:
					return new FileAttributesTag();
				case 70: 
					return new PlaceObject3Tag();
				case 71:
					return new ImportAssets2Tag();
				case 73:
					return new DefineFontAlignZonesTag();
				case 75:
					return new DefineFont3Tag();					
				case 76:
					return new SymbolClassTag();
				case 77:
					return new MetaDataTag();
				case 78:
					return new DefineScalingGridTag();
				case 82:
					return new DoABCTag();
				case 83: 
					return new DefineShape4Tag();
				case 84:
					return new DefineMorphShape2Tag();								
				case 86:
					return new DefineSceneAndFrameLabelTag();
				case 88:
					return new DefineFontNameTag();
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