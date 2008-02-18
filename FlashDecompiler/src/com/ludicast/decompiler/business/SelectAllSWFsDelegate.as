
package com.ludicast.decompiler.business
{
	import com.ericfeminella.sql.ISQLResponder;

	public final class SelectAllSWFsDelegate extends AbstractDelegate
	{
		public function SelectAllSWFsDelegate(responder:ISQLResponder)
		{
			super( responder );
		}
		
		public function select(statement:String, dataType:Class) : void
		{
			this.execute( statement, dataType );
		}
	}
}


