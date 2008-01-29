package com.ludicast.decompiler.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.ludicast.decompiler.vo.SWFPropsVO;
	
	[Bindable]
	public class DecompilerModelLocator implements ModelLocator
	{
		
	
	private static var modelLocator : DecompilerModelLocator;
      
      public var dataString:String = "";
      public var decompressedDataString:String = "";
      public var swfProps:SWFPropsVO;

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