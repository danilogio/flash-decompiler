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

package org.libspark.swfassist.errors
{
	public class ErrorMessageConstants
	{
		public static const INVALID_SIGNATURE:String = 'SWF file signature is invalid.';
		public static const INVALID_FILE_LENGTH:String = 'SWF file length is invalid.';
		public static const INVALID_TAG_LENGTH:String = 'Tag length is invalid.';
		public static const INVALID_CLIP_ACTION_RECORD_SIZE:String = 'ClipActionRecord.ActionRecordSize is invalid.';
		public static const FILE_ATTRIBUTES_ARE_NEEDED:String = 'FileAttributes tag is needed at first.';
	}
}