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
				case 7: 
					return new DefineButtonTag();
				case 8: 
					return new JpegTablesTag();
				case 9:
					return new SetBackgroundColorTag();
				case 10:
					return new DefineFontTag();
				case 11:
					return new DefineTextTag();
				case 12:
					return new DoActionTag();				
				case 13:
					return new DefineFontInfoTag();
				case 14:
					return new DefineSoundTag();
				case 15:
					return new StartSoundTag();
				case 17:
					return new SoundStreamHeadTag();
				case 18:
					return new DefineButtonSoundTag();
				case 19:
					return new SoundStreamBlockTag();					
				case 20: 
					return new DefineBitsLosslessTag();
				case 21: 
					return new DefineBitsJPEG2Tag();
				case 22: 
					return new DefineShape2Tag();
				case 23: 
					return new DefineButtonCxformTag();
				case 24:
					return new ProtectTag();
				case 26: 
					return new PlaceObject2Tag();
				case 28: 
					return new RemoveObject2Tag();					
				case 32: 
					return new DefineShape3Tag();
				case 33: 
					return new DefineText2Tag();
				case 34: 
					return new DefineButton2Tag();					
				case 35: 
					return new DefineBitsJPEG3Tag();
				case 36: 
					return new DefineBitsLossless2Tag();
				case 37: 
					return new DefineEditTextTag();
				case 39:
					return new DefineSpriteTag();
				case 43:
					return new FrameLabelTag();
				case 45:
					return new SoundStreamHead2Tag();					
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
				case 60:
					return new DefineVideoStreamTag();
				case 61:
					return new VideoFrameTag();
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
				case 74:
					return new CSMTextSettingsTag();	
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
				case 87:
					return new DefineBinaryDataTag();
				case 88:
					return new DefineFontNameTag();
				case 89:
					return new StartSound2Tag();
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