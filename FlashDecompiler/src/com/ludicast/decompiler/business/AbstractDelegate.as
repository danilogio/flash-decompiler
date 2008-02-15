package com.ludicast.decompiler.business
{
	import com.ericfeminella.aircairngorm.business.AIRServiceLocator;
	import com.ludicast.decompiler.business.Services;
	import com.ericfeminella.sql.SQLService;
	import com.ericfeminella.sql.ISQLResponder;
	import flash.net.Responder;
	
	internal class AbstractDelegate
	{
		protected var responder:ISQLResponder;
		protected var sql:SQLService;
		
		public function AbstractDelegate(responder:ISQLResponder)
		{
			this.responder = responder;
			this.sql = AIRServiceLocator.getInstance().getSQLService( Services.RDBMS );
		}
		
		protected function execute(statement:String, dataType:Class = null, prefetch:int = - 1.0) : void
		{
			this.sql.execute(statement, responder, dataType, prefetch);
		}
	}
}