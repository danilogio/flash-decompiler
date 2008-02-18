package com.ludicast.decompiler.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.ludicast.decompiler.vo.SWFVO;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class DecompilerModelLocator implements ModelLocator {
		
	
	  private static var modelLocator : DecompilerModelLocator;      
      public var swfProps:SWFVO;

      
      public var tags:ArrayCollection;
      public var loadedAS3Classes:ArrayCollection;
   
      public var savedSWFs:ArrayCollection;
   
      public static const LOAD_PROGRESS_LOADING:String = "loadingState";
      public static const LOAD_PROGRESS_PARSING:String = "parsingState";
      public static const LOAD_PROGRESS_ERROR:String = "errorState";
      public static const LOAD_PROGRESS_WAITING:String = "waitingState";
      public static const LOAD_PROGRESS_PARSED:String = "parsedState";
	  private var _loadProgress:String = LOAD_PROGRESS_WAITING;

	  public function get loadProgress():String {
	  	return _loadProgress;
	  }

	  public function set loadProgress(progress:String):void {
	  	_loadProgress = progress;
	  	if (progress == LOAD_PROGRESS_PARSED) {
	  		currentTool = VIEWER_TOOL;
	  	}
	  }

      public static const LOADER_TOOL:String = "loaderTool";
      public static const VIEWER_TOOL:String = "viewerTool";	  
	  public var currentTool:String = LOADER_TOOL;

      public static function getInstance() : DecompilerModelLocator 
      {
      	if ( modelLocator == null )
      	{
      		modelLocator = new DecompilerModelLocator();
      	}
      		
      	return modelLocator;
      }
  
  
	  public function initialize():void {

	  }
	  
      public function DecompilerModelLocator() 
      {	
      	
         if ( modelLocator != null ) {
         	throw new Error( "Only one FlexDecompilerModelLocator instance should be instantiated" );	
         } else {
			 this.initialize();
         }
      }
	}
}