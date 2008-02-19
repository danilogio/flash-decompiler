package com.ludicast.decompiler.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import com.ludicast.decompiler.command.*;
	
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
			addCommand( LOAD_REMOTE_SWF,  LoadRemoteSWFCommand );
			addCommand( LOAD_LOCAL_SWF,  LoadLocalSWFCommand );
			addCommand( LOAD_DATABASE_SWF,  LoadDatabaseSWFCommand );
			addCommand( INITIALIZE_DATABASE,  InitializeDatabaseCommand );
			addCommand( SET_STATE,  SetStateCommand );
			addCommand( SAVE_CURRENT_SWF,  SaveCurrentSWFCommand );
			addCommand( SELECT_ALL_SWFS, SelectAllSWFsCommand);
		}	
		
		public static const SET_STATE:String = "setState";		
		public static const LOAD_REMOTE_SWF:String = "loadRemoteSWF";				
		public static const LOAD_LOCAL_SWF:String = "loadLocalSWF";		
		public static const LOAD_DATABASE_SWF:String = "loadDatabaseSWF";	
		public static const SAVE_CURRENT_SWF:String = "saveCurrentSWF";	
		public static const SELECT_ALL_SWFS:String = "selectAllSWFs";	
		public static const INITIALIZE_DATABASE:String = "initializeDatabase";
	}
}