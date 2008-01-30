package com.ludicast.decompiler.util.tamarin
{

	public dynamic class MetaData
	{
		protected var name:String
		public function toString():String 
		{
			var last:String
			var s:String = last = '['+name+'('
			var n:* // kidwell added *
			for (n in this)
				s = (last = s + n + "=" + '"' + this[n] + '"') + ','
			return last + ')]'
		}
	}
}

