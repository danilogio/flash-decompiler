package com.ludicast.decompiler.util.tamarin
{
	
	public class Traits
	{
		public var name:*
		public var init:MethodInfo
		public var itraits:Traits
		public var base:*
		public var flags:int
		public var protectedNs:Namespace
		public const interfaces:Array = []
		public const names:Object = {}
		public const slots:Array = []
		public const methods:Array = []
		public const members:Array = []
		
		public function toString():String
		{
			return String(name);
		}
		
		public function dump(abc:Abc, indent:String, attr:String=""):*
		{
			for each (var m:* in members) 
				m.dump(abc,indent,attr)
		}
	}
}

