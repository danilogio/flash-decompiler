package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.util.tamarin.Abc;
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	
	public class DoABCTag extends Tag
	{
		public var flags:uint;
		public var abcData:ByteArray;
		public var abc:Abc;
		public var name:String;
		
		public override function toString ():String {
			return "DoABC Tag: " + super.toString();
		}

		public override function set byteData (array:ByteArray):void {
			super.byteData = array;
			flags = array.readUnsignedInt();
			abcData = new ByteArray();

			abcData.endian = Endian.LITTLE_ENDIAN;

			for (var i:Number = 4; i < array.length; i++) {
				abcData[i - 4] = array[i];
			}

			trace ("set bd" + _byteData);
		}

		public override function get tagData():String {
			return "Flags:" + flags  + " " + byteData[0] + " " +byteData[1] + " " + byteData[2] + " " + byteData[3] + 
				   "\n\nDoABC\n\n" + parseDoABC ();
		}		

		public function parseDoABC():String {
			//return "Minor " + abcData.readUnsignedShort() + "\n" + "Major " + abcData.readUnsignedShort(); 

			var newArray:ByteArray = new ByteArray();
			//trace ("newpos" + abcData.position);
			//trace ("nl " + name.length);
			if (abc == null) {
				name = readString();//return ByteCodePrinter.prettyPrint(abcData);
				abcData.readBytes(newArray,0,abcData.length - abcData.position);
				abcData = newArray;
				abcData.endian = Endian.LITTLE_ENDIAN;
			//trace (ByteCodePrinter.prettyPrint(abcData));
				abc = new Abc(abcData);
			}
			var retString:String = name;
			retString += "Magic:" + abc.magic + "\n";
			retString += "Minor:" + abc.minor + "\n";
			retString += "Major:" + abc.major + "\n";
		
			retString += "Public Namespaces:" + abc.publicNs + "\n"; 
		
			retString += "\nNames:\n";	
			for (var i:int = 0; i < abc.names.length; i++) {
				retString += "Name " + i + ":" + abc.names[i] + "\n"		
			}

			retString += "\nNamespaces:\n";													
			for (i = 0; i < abc.namespaces.length; i++) {
				retString += "Namespaces " + i + ":" + abc.namespaces[i] + "\n";	
			}

			retString += "\nClasses:\n";													
			for (i = 0; i < abc.classes.length; i++) {
				retString += "Class " + i + ":" + abc.classes[i] + "\n";	
			}

			retString += "\nnsset:\n";													
			for (i = 0; i < abc.nssets.length; i++) {
				retString += "nsset " + i + ":" + abc.nssets[i] + "\n";		
			}

			retString += "\nStrings:\n";	
			for (i = 0; i < abc.strings.length; i++) {
				retString += "string " + i + ":" + abc.strings[i] + "\n";		
			}

			retString += "\nInts:\n";	
			for (i = 0; i < abc.ints.length; i++) {
				retString += "int " + i + ":" + abc.ints[i] + "\n";		
			}
				
			retString += "\Doubles:\n";	
			for (i = 0; i < abc.doubles.length; i++) {
				retString += "Double " + i + ":" + abc.doubles[i] + "\n";		
			}

			retString += "\Scripts:\n";	
			for (i = 0; i < abc.scripts.length; i++) {
				retString += "Script " + i + ":" + abc.scripts[i] + "\n";		
			}

			retString += "\Defaults:\n";	
			for (i = 0; i < abc.defaults.length; i++) {
				retString += "Default " + i + ":" + abc.defaults[i] + "\n";		
			}

			retString += "\Instances:\n";	
			for (i = 0; i < abc.instances.length; i++) {
				retString += "Instance " + i + ":" + abc.instances[i] + "\n";		
			}
										
			retString += "\nUints:\n";	
			for (i = 0; i < abc.uints.length; i++) {
				retString += "Uint " + i + ":" + abc.uints[i] + "\n";		
			}
															
			//trace (abc.ints);
			//trace (abc.doubles);		
			//trace (abc.scripts);
			//return name;
			return retString;
		}


		//from tamarin project
		private function readString():String
		{
			trace ("pos: " + abcData.position);
			var s:String = "";
			var c:int;

			while (c=abcData.readUnsignedByte())
				s += String.fromCharCode(c);

			return s;
		}
			
	}
}