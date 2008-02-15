package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	import com.ludicast.decompiler.util.tag.DoABCTag;
	import com.ludicast.decompiler.vo.AS3Class;
	import com.ludicast.decompiler.vo.Tag;
	
	
	import mx.collections.ArrayCollection;

	public class LoadAS3Classes implements ICommand
	{

		public function execute(event:CairngormEvent):void
		{
			private var model:DecompilerModelLocator;
			model = DecompilerModelLocator.getInstance();
			
			model.loadedAS3Classes = new ArrayCollection();
			for (var i:uint = 0; i < model.tags.length; i++) {
				var tag:Tag = Tag(model.tags.getItemAt(i));
				if (tag is DoABCTag) {
					var abcTag:DoABCTag = DoABCTag(tag);
					var classes:ArrayCollection = abcTag.classes;
					for (var j:uint = 0; j < classes.length; j++) {
						var cls:AS3Class
					}
				}
			}
	
		}
		
	}
}