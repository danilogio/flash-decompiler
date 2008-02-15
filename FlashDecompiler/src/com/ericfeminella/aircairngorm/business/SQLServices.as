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
	import com.ericfeminella.sql.SQLService;
    import flash.utils.describeType;
    import flash.utils.Dictionary;

	internal final class SQLServices
	{
        protected var services:Dictionary;

        public function SQLServices() 
        {
        	services = new Dictionary();
        }
        
        public function register(serviceLocator:IAIRServiceLocator) : void
        {         
			var accessors:XMLList = getAccessors( serviceLocator );
         
            var n:int = accessors.length();
         
            for (var i:uint = 0; i < n; i++) {
         	
				var id:String = accessors[i];
                var sqlService:Object = serviceLocator[id];
            
                if (sqlService is SQLService)
                {
                    services[id] = sqlService;
                }
            }
        }
      
        public function getService(name:String) : SQLService
        {
            var service:SQLService = services[name];
         
         	trace ("svc:" + services);
			for (var i:* in services) {
				trace (i + ":" + services[i]);
			}
			
            if ( service == null )
            {
                throw new CairngormError(CairngormMessageCodes.DATA_SERVICE_NOT_FOUND, name);
            }
            return service;
        }

        protected function getAccessors( serviceLocator : IAIRServiceLocator ) : XMLList
        {
           var description : XML = describeType( serviceLocator );
           var accessors : XMLList = description.accessor.( @access == "readwrite" ).@name;
            
           return accessors;
        }
	}
}

