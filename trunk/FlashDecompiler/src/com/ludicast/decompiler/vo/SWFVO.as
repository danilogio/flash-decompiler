package com.ludicast.decompiler.vo
{
	import flash.utils.ByteArray;
	
	[Bindable]
	public class SWFVO {
		public var version:uint;
		public var compressed:Boolean;
		public var fileLength:uint;
		public var height:Number;
		public var width:Number;   
      	public var frameRate:Number;
      	public var frameCount:uint;
      	public var location:String;
      	public var remote:Boolean;
      	public var id:uint = 0;
      	public var name:String;
      	public var parsed:Boolean;
        public var rawData:ByteArray;    	
	}
}