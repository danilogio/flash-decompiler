package com.ludicast.decompiler.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ludicast.decompiler.model.DecompilerModelLocator;
	
	public class SetState implements ICommand
	{
		public function execute(event:CairngormEvent):void {
			var model:DecompilerModelLocator = DecompilerModelLocator.getInstance();
			model.currentTool = event.data;
			trace ("setting tool to " + event.data);
		}
	}
}