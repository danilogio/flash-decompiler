/*
 Copyright (c) 2007 Eric J. Feminella <eric@ericfeminella.com>
 All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy 
 of this software and associated documentation files (the "Software"), to deal 
 in the Software without restriction, including without limitation the rights 
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished 
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all 
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 @internal
 */

package com.ericfeminella.aircairngorm.business
{
	import com.adobe.cairngorm.CairngormError;
	import com.adobe.cairngorm.CairngormMessageCodes;
	import com.adobe.cairngorm.business.ServiceLocator;
    import com.ericfeminella.sql.SQLService;
    import flash.events.Event;
    import mx.core.Application;
    import mx.events.FlexEvent;
    
	/**
	 * IAIRServiceLocator implementation which provides a mechanism
	 * from which Adobe AIR APIs (e.g. SQLConnection, SQLStatement)
	 * can be located on a ServiceLocator instance
	 * 
	 */    
	public class AIRServiceLocator extends ServiceLocator implements IAIRServiceLocator
	{
		/**
		 * Defines the Singleton instance of AIRServiceLocator
		 */
		private static var instance:AIRServiceLocator;
		
		/**
		 * Defines the SQLServices for the AIRServiceLocator instance
		 */
		protected var sqlServices:SQLServices;

		/**
		 * Instantiates the Singleton instance of AIRServiceLocator
		 */		
		public function AIRServiceLocator()
		{
			if (instance != null)
			{
				throw new CairngormError( CairngormMessageCodes.SINGLETON_EXCEPTION, "AIRServiceLocator" );
			}	
            instance = this;
            
            Application(Application.application).addEventListener(FlexEvent.PREINITIALIZE, this.preinitialize);
		}
		 
		/**
		 * Returns the Singleton instance of IAIRServiceLocator
		 */
		public static function getInstance() : IAIRServiceLocator
		{
			if (instance == null)
			{
				instance = new AIRServiceLocator();
			}
			return instance;
		}
		
        /**
         * Retrieves the unique SWLService registered to the IAIRServiceLocator
         * 
         * @param  the unique identifier of the SQLService
         * @return the SQLService instance with the specified name
         * 
         */		
        public function getSQLService(name:String) : SQLService
        {
           if (sqlServices == null)
           {
               sqlServices = new SQLServices();
               sqlServices.register( this );
           }
           return sqlServices.getService( name );
        }
        
        /**
         * Abstract method which is invoked when Application.preinitialize 
         * event is dispatched. 
         * 
         * <p>
         * Typically, clients would override this method in order to initialize 
         * services at startup of the application
         * </p>
         * 
         * @param FlexEvent.PREINITIALIZE
         * 
         */        
        protected function preinitialize(event:FlexEvent) : void
        {
        	throw new CairngormError(CairngormMessageCodes.ABSTRACT_METHOD_CALLED, "preinitialize");
        }
	}
}


/**
 * Inner class which restricts constructor access to private
 */
class Private {}


