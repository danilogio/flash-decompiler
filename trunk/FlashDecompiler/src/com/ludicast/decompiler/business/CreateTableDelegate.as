
package com.ludicast.decompiler.business
{
	import com.ericfeminella.sql.ISQLResponder;
	
	public class CreateTableDelegate extends AbstractDelegate
	{
		public function CreateTableDelegate(responder:ISQLResponder)
		{
			super( responder );
		}
		
		public function create(statment:String) : void
		{
			this.execute(statment);
		}
	}
}