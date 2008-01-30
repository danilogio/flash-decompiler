package com.ludicast.decompiler.util
{
	public class Multiname
	{
		public var nsset:Array
		public var name:String
		public function Multiname(nsset:Array, name:String)
		{
			this.nsset = nsset
			this.name = name
		}
		
		public function toString():String
		{
			return /*'{' + nsset + '}::' + */name
		}
	}
}

