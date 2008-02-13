package com.ludicast.decompiler.util.tag
{
	import com.ludicast.decompiler.util.tamarin.Abc;
	import com.ludicast.decompiler.util.tamarin.MethodInfo;
	import com.ludicast.decompiler.util.tamarin.SlotInfo;
	import com.ludicast.decompiler.util.tamarin.Traits;
	import com.ludicast.decompiler.vo.AS3Class;
	import com.ludicast.decompiler.vo.Tag;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import mx.collections.ArrayCollection;
	
	
	public class DoABCTag extends Tag
	{
		public var flags:uint;
		public var abcData:ByteArray;
		public var abc:Abc;
		public var name:String;

		public var parsed:Boolean;

		public var classes:ArrayCollection;
		public var names:ArrayCollection;
		public var methods:ArrayCollection;
		public var namespaces:ArrayCollection;		

		public var magic:Number;
		public var minor:Number;		
		public var major:Number;		
		public var publicNs:Namespace;
		
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
			
			var newArray:ByteArray = new ByteArray();
			if (parsed) {
				return "parsed already";
			}
			parsed = true;
			
			name = readString();
			abcData.readBytes(newArray,0,abcData.length - abcData.position);
			abcData = newArray;
			abcData.endian = Endian.LITTLE_ENDIAN;			
			abc = new Abc(abcData);
			
			magic = abc.magic;
			minor = abc.minor;
			major = abc.major;
			publicNs = abc.publicNs; 
			
		
			names = new ArrayCollection();
			for (var i:int = 0; i < abc.names.length; i++) {
				names.addItem(abc.names[i]);
			}

			methods = new ArrayCollection();
			for (i = 0; i < abc.methods.length; i++) {
				var method:MethodInfo = MethodInfo(abc.methods[i]);
		/*		retString += "Method " + i + ":" + method + "\n"		
				retString += processABC(method.code) + "\n";
				retString += method.debugName + "\n";
				retString += method.code_length + "\n";							
				retString += method.code_length + "\n";			
			*/
				methods.addItem(method);
			}

	//		keepAddingAsParseData...
			//retString += "\nNamespaces:\n";													
			namespaces = new ArrayCollection();
			for (i = 0; i < abc.namespaces.length; i++) {	
				namespaces.addItem(abc.namespaces[i]);
			}
										
			classes = new ArrayCollection();	
			for (i = 0; i < abc.classes.length; i++) {				
				var clsTraits:Traits = Traits(abc.classes[i]);
				var cls:AS3Class = new AS3Class(clsTraits.name, clsTraits.name, this);
				classes.addItem(cls);



	/*			retString += "*********************\n";		
				retString += "Class " + i + ":" + cls.className + "\n";
				retString += "*********************\n";				
				retString += cls.methods + "\n";
				retString += cls.interfaces + "\n";				
				retString += cls.members + "\n";	
				retString += cls.init + "\n";					
*/
				

			}
/*
		//	retString += "\nnsset:\n";
													
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
				var traits:Traits = Traits(abc.scripts[i]);
				retString += "Script " + i + ":" + traits + "\n";
				retString +=  "********************";
				retString += "name:   " + traits.name + "\n";		
				retString += "methods:   " + traits.methods + "\n";	
				
				retString += "members:   " + traits.members + "\n";
				for (var j:Number = 0; j < traits.members.length; j++) {
					if (traits.members[j] is SlotInfo) {
						var slot:SlotInfo  = traits.members[j] as SlotInfo;
						retString += "name:" + (slot.name) + "\n";
						retString += "metadata:" + (slot.metadata) + "\n";
						retString += "type:" + (slot.type) + "\n";
						retString += "value:" + (slot.value) + "\n";
						retString += "kind:" + (slot.kind) + "\n";
					}
				}
				
				retString += "\n\n\n\n";	
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
			//return name;
			return retString;
			*/
			return "UNDERGOING MASSIVE REFACTORING FOR MOMENT";
		}

		private function processABC(rawBytes:*):String {
			var array:ByteArray = ByteArray(rawBytes);
			if (array == null) {
				return "Empty Code Section";
			}
			return ("Code array " + array.length);
			
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