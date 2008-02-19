/*
 * Copyright(c) 2007 the Spark project.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

package org.libspark.swfassist.utils
{
	public class BitwiseUtil
	{
		public static function getMinBits(a:uint, b:uint = 0, c:uint = 0, d:uint = 0):uint
		{
			var val:uint = a | b | c | d;
			var bits:uint = 1;
			
			do {
				val >>>= 1;
				++bits;
			}
			while (val != 0)
			
			return bits;
		}
		
		public static function getMinSBits(a:int, b:int = 0, c:int = 0, d:int = 0):uint
		{
			return getMinBits(Math.abs(a), Math.abs(b), Math.abs(c), Math.abs(d));
		}
		
		public static function getMinFBits(a:Number, b:Number = 0, c:Number = 0, d:Number = 0):uint
		{
			return getMinSBits(a * 65536, b * 65536, c * 65536, d * 65536);
		}
	}
}