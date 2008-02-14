package com.ludicast.decompiler.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.ludicast.decompiler.vo.SWFPropsVO;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class DecompilerModelLocator implements ModelLocator {
		
	
	  private static var modelLocator : DecompilerModelLocator;      
      public var swfProps:SWFPropsVO;
      
      public var tags:ArrayCollection;
      public var loadedAS3Classes:ArrayCollection;
      
      public static const LOADING_STATE:String = "loadingState";
      public static const PARSING_STATE:String = "parsingState";
      public static const ERROR_STATE:String = "errorState";
      public static const WAITING_STATE:String = "waitingState";
      public static const PARSED_STATE:String = "parsedState";
	  
	  public var currentState:String = WAITING_STATE;

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