package com.ludicast.decompiler.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import com.ludicast.decompiler.command.LoadRemoteSWF;
	
	public class DecompilerController extends FrontController
	{
		private static var _controller:DecompilerController;
		
		public static function getInstance():DecompilerController {
			if (_controller == null) _controller = new DecompilerController();
			return _controller;
			
		}
		
		public function DecompilerController() {
         	if ( _controller != null ) {
         		throw new Error( "Only one FlexDecompilerController instance should be instantiated" );	
         	}
			initialiseCommands();
		}
		
		
		public function initialiseCommands() : void {
			addCommand( LOAD_REMOTE_SWF,  LoadRemoteSWF );
		}	
	
		public static const LOAD_REMOTE_SWF:String = "loadRemoteSWF";				
		
	}
}