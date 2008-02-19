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

package org.libspark.swfassist.io
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class ByteArrayOutputStream implements DataOutput
	{
		public function ByteArrayOutputStream(output:ByteArray = null)
		{
			if (!output) {
				output = new ByteArray();
			}
			
			this.byteArray = output;
			
			resetBitCursor();
		}
		
		private var _byteArray:ByteArray;
		private var _bitBuffer:uint = 0;
		private var _bitCursor:uint;
		
		public function get byteArray():ByteArray
		{
			return _byteArray;
		}
		
		public function set byteArray(value:ByteArray):void
		{
			if (_byteArray == value) {
				return;
			}
			
			_byteArray = value;
			
			value.endian = Endian.LITTLE_ENDIAN;
			value.position = 0;
		}
		
		public function get length():uint
		{
			return byteArray.length;
		}
		
		public function get position():uint
		{
			return byteArray.position;
		}
		
		public function set position(value:uint):void
		{
			byteArray.position = value;
		}
		
		public function writeS8(value:int):void
		{
			byteArray.writeByte(value);
		}
		
		public function writeS16(value:int):void
		{
			byteArray.writeShort(value);
		}
		
		public function writeS32(value:int):void
		{
			byteArray.writeInt(value);
		}
		
		public function writeU8(value:uint):void
		{
			byteArray.writeByte(value & 0xff);
		}
		
		public function setU8(value:uint):void
		{
			byteArray[byteArray.position - 1] = value & 0xff;
		}
		
		public function writeU16(value:uint):void
		{
			byteArray.writeByte(value & 0xff);
			byteArray.writeByte((value >> 8) & 0xff);
		}
		
		public function writeU32(value:uint):void
		{
			byteArray.writeByte(value & 0xff);
			byteArray.writeByte((value >> 8) & 0xff);
			byteArray.writeByte((value >> 16) & 0xff);
			byteArray.writeByte((value >> 24) & 0xff);
		}
		
		public function writeFixed(value:Number):void
		{
			writeS32(int(value * 65536));
		}
		
		public function writeFixed8(value:Number):void
		{
			writeS16(int(value * 256));
		}
		
		public function writeFloat16(value:Number):void
		{
			if (value == 0) {
				writeU16(0x0000);
				return;
			}
			var sign:uint = 0;
			if (value < 0) {
				sign = 0x8000;
				value *= -1;
			}
			var exp:int = 0;
			if (value < 1) {
				while (uint(value) != 1) {
					value *= 2;
					--exp;
				}
			}
			else {
				while (uint(value) != 1) {
					value /= 2;
					++exp;
				}
			}
			exp += 16;
			if (exp < 0 || exp > 0x1f) {
				throw new Error();
			}
			writeU16(sign | (exp << 10) | (uint((value - 1) * 0x400) & 0x3ff))
		}
		
		public function writeFloat(value:Number):void
		{
			byteArray.writeFloat(value);
		}
		
		public function writeDouble(value:Number):void
		{
			byteArray.writeDouble(value);
		}
		
		public function writeEncodedU32(value:uint):void
		{
			for (;;) {
				var v:uint = value & 0x7f;
				
				if ((value >>= 7) == 0) {
					writeU8(v);
					break;
				}
				
				writeU8(v & 0x80);
			}
		}
		
		public function writeBit(value:Boolean):void
		{
			writeUBits(1, value ? 1 : 0);
		}
		
		public function writeUBits(numBits:uint, value:uint):void
		{
			if (numBits == 0) {
				return;
			}
			
			if (_bitCursor == 0) {
				writeU8(0x00);
				_bitBuffer = 0;
				_bitCursor = 8;
			}
			
			for (;;) {
				if (numBits > _bitCursor) {
					setU8(_bitBuffer | ((value << (32 - numBits)) >>> (32 - _bitCursor)));
					numBits -= _bitCursor;
					writeU8(0x00);
					_bitBuffer = 0;
					_bitCursor = 8;
				}
				else {
					setU8(_bitBuffer |= ((value << (32 - numBits)) >>> (32 - _bitCursor)));
					_bitCursor -= numBits;
					break;
				}
			}
		}
		
		public function writeSBits(numBits:uint, value:int):void
		{
			writeUBits(numBits, value | ((value < 0 ? 0x80000000 : 0x00000000) >> (32 - numBits)));
		}
		
		public function writeFBits(numBits:uint, value:Number):void
		{
			writeSBits(numBits, value * 65536);
		}
		
		public function resetBitCursor():void
		{
			_bitCursor = 0;
		}
		
		public function writeUTF(value:String, isNullTerminated:Boolean = true):void
		{
			if (isNullTerminated) {
				byteArray.writeUTFBytes(value);
				writeU8(0x00);
			}
			else {
				var begin:uint = position;
				writeU8(0x00);
				byteArray.writeUTFBytes(value);
				writeU8(0x00);
				var end:uint = position;
				position = begin;
				writeU8(end - (begin + 1));
				position = end;
			}
		}
		
		public function writeString(value:String, charset:String = 'iso-8859-1', isNullTerminated:Boolean = true):void
		{
			if (isNullTerminated) {
				byteArray.writeMultiByte(value, charset);
				writeU8(0x00);
			}
			else {
				var begin:uint = position;
				writeU8(0x00);
				byteArray.writeMultiByte(value, charset);
				writeU8(0x00);
				var end:uint = position;
				position = begin;
				writeU8(end - (begin + 1));
				position = end;
			}
		}
		
		public function writeBytes(source:ByteArray):void
		{
			byteArray.writeBytes(source);
		}
		
		public function compress(offset:uint = 0, length:uint = 0):void
		{
			var pos:uint = byteArray.position;
			
			if (offset == 0 && length == 0) {
				byteArray.compress();
			}
			else {
				var temp:ByteArray = new ByteArray();
				temp.writeBytes(byteArray, offset, length);
				temp.compress();
				temp.position = temp.length - 1;
				if (length != 0 && (offset + length) < byteArray.length) {
					temp.writeBytes(byteArray, offset + length);
				}
				byteArray.length = offset;
				byteArray.position = offset;
				byteArray.writeBytes(temp);
				temp.length = 0;
			}
			
			byteArray.position = pos;
		}
	}
}