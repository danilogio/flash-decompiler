package com.ludicast.decompiler.util.tamarin {
	import flash.utils.ByteArray;

	public class Abc
	{
		private var data:ByteArray
		
		public var major:int
		public var minor:int
		
		public var ints:Array
		public var uints:Array
		public var doubles:Array
		public var strings:Array
		public var namespaces:Array
		public var nssets:Array
		public var names:Array
		
		public var defaults:Array = new Array(Constants.constantKinds.length)

		public var methods:Array
		public var instances:Array
		public var classes:Array
		public var scripts:Array
		
		public var publicNs:Namespace = new Namespace("");
		public var anyNs:Namespace = new Namespace("*");

		public var magic:int;
		
		protected var metadata:Array;
		
		public function Abc(data:ByteArray)
		{
			Constants.reinitConstants();
			data.position = 0
			this.data = data
			magic = data.readInt()

			Constants.print("magic " + magic.toString(16))

			if (magic != (46<<16|14) && magic != (46<<16|15) && magic != (46<<16|16))
				throw new Error("not an abc file.  magic=" + magic.toString(16))
			
			parseCpool()
			
			defaults[Constants.CONSTANT_Utf8] = strings
			defaults[Constants.CONSTANT_Int] = ints
			defaults[Constants.CONSTANT_UInt] = uints
			defaults[Constants.CONSTANT_Double] = doubles
			defaults[Constants.CONSTANT_Int] = ints
			defaults[Constants.CONSTANT_False] = { 10:false }
			defaults[Constants.CONSTANT_True] = { 11:true }
			defaults[Constants.CONSTANT_Namespace] = namespaces
			defaults[Constants.CONSTANT_PrivateNs] = namespaces
			defaults[Constants.CONSTANT_PackageNs] = namespaces
			defaults[Constants.CONSTANT_PackageInternalNs] = namespaces
			defaults[Constants.CONSTANT_ProtectedNs] = namespaces
			defaults[Constants.CONSTANT_StaticProtectedNs] = namespaces
			defaults[Constants.CONSTANT_StaticProtectedNs2] = namespaces
			defaults[Constants.CONSTANT_Null] = { 12: null }		
			
			parseMethodInfos()
			parseMetadataInfos()
			parseInstanceInfos()
			parseClassInfos()
			parseScriptInfos()
			parseMethodBodies()
		}
	
		public function readU32():int
		{
			var result:int = data.readUnsignedByte();
			if (!(result & 0x00000080))
				return result;
			result = result & 0x0000007f | data.readUnsignedByte()<<7;
			if (!(result & 0x00004000))
				return result;
			result = result & 0x00003fff | data.readUnsignedByte()<<14;
			if (!(result & 0x00200000))
				return result;
			result = result & 0x001fffff | data.readUnsignedByte()<<21;
			if (!(result & 0x10000000))
				return result;
			return   result & 0x0fffffff | data.readUnsignedByte()<<28;
		}
		
		public function parseCpool():void
		{
			var i:int, j:int
			var n:int
			var kind:int

			var start:int = data.position
			
			// ints
			n = readU32()
			ints = [0]
			for (i=1; i < n; i++)
				ints[i] = readU32()
				
			// uints
			n = readU32()
			uints = [0]
			for (i=1; i < n; i++)
				uints[i] = uint(readU32())
				
			// doubles
			n = readU32()
			doubles = [NaN]
			for (i=1; i < n; i++)
				doubles[i] = data.readDouble()

			Constants.print("Cpool numbers size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position
			
			// strings
			n = readU32()
			strings = [""]
			for (i=1; i < n; i++)
				strings[i] = data.readUTFBytes(readU32())

			Constants.print("Cpool strings count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position
			
			// namespaces
			n = readU32()
			namespaces = [publicNs]
			for (i=1; i < n; i++)
				switch (data.readByte())
				{
				case Constants.CONSTANT_Namespace:
				case Constants.CONSTANT_PackageNs:
				case Constants.CONSTANT_PackageInternalNs:
				case Constants.CONSTANT_ProtectedNs:
				case Constants.CONSTANT_StaticProtectedNs:
				case Constants.CONSTANT_StaticProtectedNs2:
				{
					namespaces[i] = new Namespace(strings[readU32()])
					// todo mark kind of namespace.
					break;
				}
				case Constants.CONSTANT_PrivateNs:
					readU32();
					namespaces[i] = new Namespace(null, "private")
					break;
				}

			Constants.print("Cpool namespaces count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position
			
			// namespace sets
			n = readU32()
			nssets = [null]
			for (i=1; i < n; i++)
			{
				var count:int = readU32()
				var nsset = nssets[i] = []
				for (j=0; j < count; j++)
					nsset[j] = namespaces[readU32()]
			}

			Constants.print("Cpool nssets count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position
			
			// multinames
			n = readU32()
			names = [null]
			namespaces[0] = anyNs
			strings[0] = "*" // any name
			for (i=1; i < n; i++)
				switch (data.readByte())
				{
				case Constants.CONSTANT_Qname:
				case Constants.CONSTANT_QnameA:
					names[i] = new QName(namespaces[readU32()], strings[readU32()])
					break;
				
				case Constants.CONSTANT_RTQname:
				case Constants.CONSTANT_RTQnameA:
					names[i] = new QName(strings[readU32()])
					break;
				
				case Constants.CONSTANT_RTQnameL:
				case Constants.CONSTANT_RTQnameLA:
					names[i] = null
					break;
				
				case Constants.CONSTANT_NameL:
				case Constants.CONSTANT_NameLA:
					names[i] = new QName(new Namespace(""), null)
					break;
				
				case Constants.CONSTANT_Multiname:
				case Constants.CONSTANT_MultinameA:
					var name:String = strings[readU32()]
					names[i] = new Multiname(nssets[readU32()], name)
					break;

				case Constants.CONSTANT_MultinameL:
				case Constants.CONSTANT_MultinameLA:
					names[i] = new Multiname(nssets[readU32()], null)
					break;
					
				default:
					throw new Error("invalid kind " + data[data.position-1])
				}

			Constants.print("Cpool names count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position

			namespaces[0] = publicNs
			strings[0] = "*"
		}
		
		public function parseMethodInfos():* //Kidwell added *
		{
			var start:int = data.position
			names[0] = new QName(publicNs,"*")
			var method_count:int = readU32()
			methods = []
			for (var i:int=0; i < method_count; i++)
			{
				var m:MethodInfo = methods[i] = new MethodInfo()
				var param_count:int = readU32()
				m.returnType = names[readU32()]
				m.paramTypes = []
				for (var j:int=0; j < param_count; j++)
					m.paramTypes[j] = names[readU32()]
				m.debugName = strings[readU32()]
				m.flags = data.readByte()
				if (m.flags & Constants.HAS_OPTIONAL)
				{
					// has_optional
					var optional_count:int = readU32();
					m.optionalValues = []
					for( var k:int = param_count-optional_count; k < param_count; ++k)
					{
						var index = readU32()    // optional value index
						var kind:int = data.readByte() // kind byte for each default value
						if (index == 0)
						{
							// kind is ignored, default value is based on type
							m.optionalValues[k] = undefined
						}
						else
						{
							if (!defaults[kind])
								Constants.print("ERROR kind="+kind+" method_id " + i)
                            else
							    m.optionalValues[k] = defaults[kind][index]
						}
					}
				}
				if (m.flags & Constants.HAS_ParamNames)
				{
					// has_paramnames
					for( var k2:int = 0; k2 < param_count; ++k2)
                    {
                        readU32();
                    }
                }
                Constants.print(m.format());
			}
			Constants.print("MethodInfo count " +method_count+ " size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}

		public function parseMetadataInfos():void
		{
			var count:int = readU32()
			metadata = []
			for (var i:int=0; i < count; i++)
	        {
				// MetadataInfo
				var m = metadata[i] = new MetaData()
				m.name = strings[readU32()];
	            var values_count:int = readU32();
	            var names:Array = []
	            for(var q:int = 0; q < values_count; ++q)
					names[q] = strings[readU32()] // name 
				for(var q2:int = 0; q2 < values_count; ++q2)
					m[names[q2]] = strings[readU32()] // value
			}
		}

		public function parseInstanceInfos():void 
		{
			var start:int = data.position
			var count:int = readU32()
			instances = []
			for (var i:int=0; i < count; i++) {
	        	var t = instances[i] = new Traits()
	        	t.name = names[readU32()]
	        	t.base = names[readU32()]
	        	t.flags = data.readByte()
				if (t.flags & 8)
					t.protectedNs = namespaces[readU32()]
	        	var interface_count = readU32()
	        	for (var j:int=0; j < interface_count; j++)
	        		t.interfaces[i] = names[readU32()]
	        	var m = t.init = methods[readU32()]
	        	m.name = t.name
	        	m.kind = Constants.TRAIT_Method
	        	m.id = -1
	        	parseTraits(t)
	        }
			Constants.print("InstanceInfo size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}
		
		public function parseTraits(t:Traits):* //Kidwell added *
		{
			var namecount = readU32()
			for (var i:int=0; i < namecount; i++)
			{
				var name = names[readU32()]
				var tag = data.readByte()
				var kind = tag & 0xf
				var member
				switch(kind) {
				case Constants.TRAIT_Slot:
				case Constants.TRAIT_Const:
				case Constants.TRAIT_Class:
					var slot = member = new SlotInfo()
					slot.id = readU32()
					t.slots[slot.id] = slot
					if (kind==Constants.TRAIT_Slot || kind==Constants.TRAIT_Const)
					{
						slot.type = names[readU32()]
						var index=readU32()
						if (index)
							slot.value = defaults[data.readByte()][index]
					}
					else // (kind == TRAIT_Class)
					{
						slot.value = classes[readU32()]
					}
					break;
				case Constants.TRAIT_Method:
				case Constants.TRAIT_Getter:
				case Constants.TRAIT_Setter:
					var disp_id = readU32()
					var method = member = methods[readU32()]
					t.methods[disp_id] = method
					method.id = disp_id
					//print("\t",traitKinds[kind],name,disp_id,method,"// disp_id", disp_id)
					break;
				}
				if (!member)
					Constants.print("error trait kind "+kind)
				member.kind = kind
				member.name = name
				t.names[String(name)] = t.members[i] = member
				
	            if ( (tag >> 4) & Constants.ATTR_metadata ) {
					member.metadata = []
					for(var j:int=0, mdCount:int=readU32(); j < mdCount; ++j)
						member.metadata[j] = metadata[readU32()]
				}
			}
		}

		public function parseClassInfos():void
		{
			var start:int = data.position
			var count:int = instances.length
			classes = []
			for (var i:int=0; i < count; i++)
	        {
	        	var t:Traits = classes[i] = new Traits()
	        	t.init = methods[readU32()]
	        	t.base = "Class"
	        	t.itraits = instances[i]
	        	t.name = t.itraits.name + "$"
	        	t.init.name = t.itraits.name + "$cinit"
	        	t.init.kind = Constants.TRAIT_Method
	        	parseTraits(t)
	        	Constants.print(t.toString());
			}			
			Constants.print("ClassInfo size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+"%")
		}

		public function parseScriptInfos():void
		{
			var start:int = data.position
			var count:int = readU32()
			scripts = []
			for (var i:int=0; i < count; i++)
	        {
	        	var t = new Traits()
				scripts[i] = t
	        	t.name = "script" + i
	        	t.base = names[0] // Object
	        	t.init = methods[readU32()]
	        	t.init.name = t.name + "$init"
				t.init.kind = Constants.TRAIT_Method	    
	        	parseTraits(t)
	        }
			Constants.print("ScriptInfo size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}

		public function parseMethodBodies():void
		{
			var start:int = data.position
			var count:int = readU32()
			for (var i:int=0; i < count; i++)
	        {
	        	var m = methods[readU32()]
				m.max_stack = readU32()
	        	m.local_count = readU32()
	        	var initScopeDepth:Number = readU32()
	        	var maxScopeDepth:Number = readU32()
	        	m.max_scope = maxScopeDepth - initScopeDepth
	        	var code_length:Number = readU32()
	        	m.code = new ByteArray()
				m.code.endian = "littleEndian"
	        	if (code_length > 0)
		        	data.readBytes(m.code, 0, code_length)
	       		var ex_count:Number = readU32()
	       		for (var j:int = 0; j < ex_count; j++)
	       		{
	       			var from:Number = readU32()
	       			var to:Number = readU32()
	       			var target:Number = readU32()
	       			var type:Number = names[readU32()]
					//print("magic " + magic.toString(16))
					//if (magic >= (46<<16|16))
					var name:Number = names[readU32()];
	       		}
	       		parseTraits(m.activation = new Traits)
	        }
			Constants.print("MethodBodies size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}
		
		public function dump(indent:String=""):void {
			for each (var t:Traits in scripts)
			{
				Constants.print(indent+t.name)
				t.dump(this,indent)
				t.init.dump(this,indent)
			}

			for each (var m:MethodInfo in methods)
			{
				if (m.anon) {
					m.dump(this,indent)
				}
			}
			
			Constants.print("OPCODE\tSIZE\t% OF "+Constants.totalSize)
			var done = []
			for (;;)
			{
				var max:int = -1;
				var maxsize:int = 0;
				for (var i:int=0; i < 256; i++)
				{
					if (Constants.opSizes[i] > maxsize && !done[i])
					{
						max = i;
						maxsize = Constants.opSizes[i];
					}
				}
				if (max == -1)
					break;
				done[max] = 1;
				Constants.print(Constants.opNames[max]+"\t"+int(Constants.opSizes[max])+"\t"+int(100*Constants.opSizes[max]/Constants.totalSize)+"%")
			}
		}
	}
}

