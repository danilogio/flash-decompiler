
package com.ludicast.decompiler.business
{
	import com.ericfeminella.sql.ISQLResponder;

	public final class SelectSWFDelegate extends AbstractDelegate
	{
		public function SelectSWFDelegate(responder:ISQLResponder)
		{
			super( responder );
		}
		
		public function select(statement:String, dataType:Class) : void
		{
			this.execute( statement, dataType );
		}
	}
}


