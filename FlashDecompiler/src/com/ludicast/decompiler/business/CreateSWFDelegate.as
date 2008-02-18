package com.ludicast.decompiler.business
{
	import com.ericfeminella.sql.ISQLResponder;
	
	public final class CreateSWFDelegate extends AbstractDelegate
	{
		public function CreateSWFDelegate(responder:ISQLResponder)
		{
			super( responder );
		}
		
		public function insert(statement:String) : void
		{	
			this.execute(statement);
		}
	}
}