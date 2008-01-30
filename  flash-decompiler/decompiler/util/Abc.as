package com.ludicast.decompiler.util {
	import flash.utils.ByteArray;
//	import avmplus.System
	/*
	const TAB = "  "
	
	// method flags
	const NEED_ARGUMENTS:int = 		0x01
	const NEED_ACTIVATION:int = 	0x02
	const NEED_REST:int = 			0x04
	const HAS_OPTIONAL:int = 		0x08
	const IGNORE_REST:int = 		0x10
	const NATIVE:int =				0x20
    const HAS_ParamNames:int =      0x80
	
	const CONSTANT_Utf8					:int = 0x01
	const CONSTANT_Int					:int = 0x03
	const CONSTANT_UInt					:int = 0x04
	const CONSTANT_PrivateNs			:int = 0x05 // non-shared namespace
	const CONSTANT_Double				:int = 0x06
	const CONSTANT_Qname				:int = 0x07 // o.ns::name, ct ns, ct name
	const CONSTANT_Namespace			:int = 0x08
	const CONSTANT_Multiname			:int = 0x09 // o.name, ct nsset, ct name
	const CONSTANT_False				:int = 0x0A
	const CONSTANT_True					:int = 0x0B
	const CONSTANT_Null					:int = 0x0C
	const CONSTANT_QnameA				:int = 0x0D // o.@ns::name, ct ns, ct attr-name
	const CONSTANT_MultinameA			:int = 0x0E // o.@name, ct attr-name
	const CONSTANT_RTQname				:int = 0x0F // o.ns::name, rt ns, ct name
	const CONSTANT_RTQnameA				:int = 0x10 // o.@ns::name, rt ns, ct attr-name
	const CONSTANT_RTQnameL				:int = 0x11 // o.ns::[name], rt ns, rt name
	const CONSTANT_RTQnameLA			:int = 0x12 // o.@ns::[name], rt ns, rt attr-name
	const CONSTANT_NameL				:int = 0x13	// o.[], ns=public implied, rt name
	const CONSTANT_NameLA				:int = 0x14 // o.@[], ns=public implied, rt attr-name
	const CONSTANT_NamespaceSet			:int = 0x15
	const CONSTANT_PackageNs			:int = 0x16
	const CONSTANT_PackageInternalNs	:int = 0x17
	const CONSTANT_ProtectedNs			:int = 0x18
	const CONSTANT_StaticProtectedNs	:int = 0x19
	const CONSTANT_StaticProtectedNs2	:int = 0x1a
	const CONSTANT_MultinameL           :int = 0x1B
	const CONSTANT_MultinameLA          :int = 0x1C
	
	const constantKinds:Array = [ "0", "utf8", "2",
		"int", "uint", "private", "double", "qname", "namespace",
		"multiname", "false", "true", "null", "@qname", "@multiname", "rtqname",
		"@rtqname", "[qname]", "@[qname]", "[name]", "@[name]", "nsset"
	]
	
	const TRAIT_Slot		:int = 0x00
	const TRAIT_Method		:int = 0x01
	const TRAIT_Getter		:int = 0x02
	const TRAIT_Setter		:int = 0x03
	const TRAIT_Class		:int = 0x04
	const TRAIT_Function	:int = 0x05
	const TRAIT_Const		:int = 0x06
	
	const traitKinds:Array = [
		"var", "function", "function get", "function set", "class", "function", "const"
	]

	const OP_bkpt:int = 0x01
	const OP_nop:int = 0x02
	const OP_throw:int = 0x03
	const OP_getsuper:int = 0x04
	const OP_setsuper:int = 0x05
	const OP_dxns:int = 0x06
	const OP_dxnslate:int = 0x07
	const OP_kill:int = 0x08
	const OP_label:int = 0x09
	const OP_ifnlt:int = 0x0C
	const OP_ifnle:int = 0x0D
	const OP_ifngt:int = 0x0E
	const OP_ifnge:int = 0x0F
	const OP_jump:int = 0x10
	const OP_iftrue:int = 0x11
	const OP_iffalse:int = 0x12
	const OP_ifeq:int = 0x13
	const OP_ifne:int = 0x14
	const OP_iflt:int = 0x15
	const OP_ifle:int = 0x16
	const OP_ifgt:int = 0x17
	const OP_ifge:int = 0x18
	const OP_ifstricteq:int = 0x19
	const OP_ifstrictne:int = 0x1A
	const OP_lookupswitch:int = 0x1B
	const OP_pushwith:int = 0x1C
	const OP_popscope:int = 0x1D
	const OP_nextname:int = 0x1E
	const OP_hasnext:int = 0x1F
	const OP_pushnull:int = 0x20
	const OP_pushundefined:int = 0x21
	const OP_pushconstant:int = 0x22
	const OP_nextvalue:int = 0x23
	const OP_pushbyte:int = 0x24
	const OP_pushshort:int = 0x25
	const OP_pushtrue:int = 0x26
	const OP_pushfalse:int = 0x27
	const OP_pushnan:int = 0x28
	const OP_pop:int = 0x29
	const OP_dup:int = 0x2A
	const OP_swap:int = 0x2B
	const OP_pushstring:int = 0x2C
	const OP_pushint:int = 0x2D
	const OP_pushuint:int = 0x2E
	const OP_pushdouble:int = 0x2F
	const OP_pushscope:int = 0x30
	const OP_pushnamespace:int = 0x31
	const OP_hasnext2:int = 0x32
	const OP_newfunction:int = 0x40
	const OP_call:int = 0x41
	const OP_construct:int = 0x42
	const OP_callmethod:int = 0x43
	const OP_callstatic:int = 0x44
	const OP_callsuper:int = 0x45
	const OP_callproperty:int = 0x46
	const OP_returnvoid:int = 0x47
	const OP_returnvalue:int = 0x48
	const OP_constructsuper:int = 0x49
	const OP_constructprop:int = 0x4A
	const OP_callsuperid:int = 0x4B
	const OP_callproplex:int = 0x4C
	const OP_callinterface:int = 0x4D
	const OP_callsupervoid:int = 0x4E
	const OP_callpropvoid:int = 0x4F
	const OP_newobject:int = 0x55
	const OP_newarray:int = 0x56
	const OP_newactivation:int = 0x57
	const OP_newclass:int = 0x58
	const OP_getdescendants:int = 0x59
	const OP_newcatch:int = 0x5A
	const OP_findpropstrict:int = 0x5D
	const OP_findproperty:int = 0x5E
	const OP_finddef:int = 0x5F
	const OP_getlex:int = 0x60
	const OP_setproperty:int = 0x61
	const OP_getlocal:int = 0x62
	const OP_setlocal:int = 0x63
	const OP_getglobalscope:int = 0x64
	const OP_getscopeobject:int = 0x65
	const OP_getproperty:int = 0x66
	const OP_getpropertylate:int = 0x67
	const OP_initproperty:int = 0x68
	const OP_setpropertylate:int = 0x69
	const OP_deleteproperty:int = 0x6A
	const OP_deletepropertylate:int = 0x6B
	const OP_getslot:int = 0x6C
	const OP_setslot:int = 0x6D
	const OP_getglobalslot:int = 0x6E
	const OP_setglobalslot:int = 0x6F
	const OP_convert_s:int = 0x70
	const OP_esc_xelem:int = 0x71
	const OP_esc_xattr:int = 0x72
	const OP_convert_i:int = 0x73
	const OP_convert_u:int = 0x74
	const OP_convert_d:int = 0x75
	const OP_convert_b:int = 0x76
	const OP_convert_o:int = 0x77
	const OP_coerce:int = 0x80
	const OP_coerce_b:int = 0x81
	const OP_coerce_a:int = 0x82
	const OP_coerce_i:int = 0x83
	const OP_coerce_d:int = 0x84
	const OP_coerce_s:int = 0x85
	const OP_astype:int = 0x86
	const OP_astypelate:int = 0x87
	const OP_coerce_u:int = 0x88
	const OP_coerce_o:int = 0x89
	const OP_negate:int = 0x90
	const OP_increment:int = 0x91
	const OP_inclocal:int = 0x92
	const OP_decrement:int = 0x93
	const OP_declocal:int = 0x94
	const OP_typeof:int = 0x95
	const OP_not:int = 0x96
	const OP_bitnot:int = 0x97
	const OP_concat:int = 0x9A
	const OP_add_d:int = 0x9B
	const OP_add:int = 0xA0
	const OP_subtract:int = 0xA1
	const OP_multiply:int = 0xA2
	const OP_divide:int = 0xA3
	const OP_modulo:int = 0xA4
	const OP_lshift:int = 0xA5
	const OP_rshift:int = 0xA6
	const OP_urshift:int = 0xA7
	const OP_bitand:int = 0xA8
	const OP_bitor:int = 0xA9
	const OP_bitxor:int = 0xAA
	const OP_equals:int = 0xAB
	const OP_strictequals:int = 0xAC
	const OP_lessthan:int = 0xAD
	const OP_lessequals:int = 0xAE
	const OP_greaterthan:int = 0xAF
	const OP_greaterequals:int = 0xB0
	const OP_instanceof:int = 0xB1
	const OP_istype:int = 0xB2
	const OP_istypelate:int = 0xB3
	const OP_in:int = 0xB4
	const OP_increment_i:int = 0xC0
	const OP_decrement_i:int = 0xC1
	const OP_inclocal_i:int = 0xC2
	const OP_declocal_i:int = 0xC3
	const OP_negate_i:int = 0xC4
	const OP_add_i:int = 0xC5
	const OP_subtract_i:int = 0xC6
	const OP_multiply_i:int = 0xC7
	const OP_getlocal0:int = 0xD0
	const OP_getlocal1:int = 0xD1
	const OP_getlocal2:int = 0xD2
	const OP_getlocal3:int = 0xD3
	const OP_setlocal0:int = 0xD4
	const OP_setlocal1:int = 0xD5
	const OP_setlocal2:int = 0xD6
	const OP_setlocal3:int = 0xD7
	const OP_debug:int = 0xEF
	const OP_debugline:int = 0xF0
	const OP_debugfile:int = 0xF1
	const OP_bkptline:int = 0xF2

	const opNames = [
	    "OP_0x00       ",
	    "bkpt          ",
	    "nop           ",
	    "throw         ",
	    "getsuper      ",
	    "setsuper      ",
	    "dxns          ",
	    "dxnslate      ",
	    "kill          ",
	    "label         ",
	    "OP_0x0A       ",
	    "OP_0x0B       ",
	    "ifnlt         ",
	    "ifnle         ",
	    "ifngt         ",
	    "ifnge         ",
	    "jump          ",
	    "iftrue        ",
	    "iffalse       ",
	    "ifeq          ",
	    "ifne          ",
	    "iflt          ",
	    "ifle          ",
	    "ifgt          ",
	    "ifge          ",
	    "ifstricteq    ",
	    "ifstrictne    ",
	    "lookupswitch  ",
	    "pushwith      ",
	    "popscope      ",
	    "nextname      ",
	    "hasnext       ",
	    "pushnull      ",
	    "pushundefined ",
	    "pushconstant  ",
	    "nextvalue     ",
	    "pushbyte      ",
	    "pushshort     ",
	    "pushtrue      ",
	    "pushfalse     ",
	    "pushnan       ",
	    "pop           ",
	    "dup           ",
	    "swap          ",
	    "pushstring    ",
	    "pushint       ",
	    "pushuint      ",
	    "pushdouble    ",
	    "pushscope     ",
	    "pushnamespace ",
	    "hasnext2      ",
	    "OP_0x33       ",
	    "OP_0x34       ",
	    "OP_0x35       ",
	    "OP_0x36       ",
	    "OP_0x37       ",
	    "OP_0x38       ",
	    "OP_0x39       ",
	    "OP_0x3A       ",
	    "OP_0x3B       ",
	    "OP_0x3C       ",
	    "OP_0x3D       ",
	    "OP_0x3E       ",
	    "OP_0x3F       ",
	    "newfunction   ",
	    "call          ",
	    "construct     ",
	    "callmethod    ",
	    "callstatic    ",
	    "callsuper     ",
	    "callproperty  ",
	    "returnvoid    ",
	    "returnvalue   ",
	    "constructsuper",
	    "constructprop ",
	    "callsuperid   ",
	    "callproplex   ",
	    "callinterface ",
	    "callsupervoid ",
	    "callpropvoid  ",
	    "OP_0x50       ",
	    "OP_0x51       ",
	    "OP_0x52       ",
	    "OP_0x53       ",
	    "OP_0x54       ",
	    "newobject     ",
	    "newarray      ",
	    "newactivation ",
	    "newclass      ",
	    "getdescendants",
	    "newcatch      ",
	    "OP_0x5B       ",
	    "OP_0x5C       ",
	    "findpropstrict",
	    "findproperty  ",
	    "finddef       ",
	    "getlex        ",
	    "setproperty   ",
	    "getlocal      ",
	    "setlocal      ",
	    "getglobalscope",
	    "getscopeobject",
	    "getproperty   ",
	    "OP_0x67       ",
	    "initproperty  ",
	    "OP_0x69       ",
	    "deleteproperty",
	    "OP_0x6A       ",
	    "getslot       ",
	    "setslot       ",
	    "getglobalslot ",
	    "setglobalslot ",
	    "convert_s     ",
	    "esc_xelem     ",
	    "esc_xattr     ",
	    "convert_i     ",
	    "convert_u     ",
	    "convert_d     ",
	    "convert_b     ",
	    "convert_o     ",
	    "checkfilter   ",
	    "OP_0x79       ",
	    "OP_0x7A       ",
	    "OP_0x7B       ",
	    "OP_0x7C       ",
	    "OP_0x7D       ",
	    "OP_0x7E       ",
	    "OP_0x7F       ",
	    "coerce        ",
	    "coerce_b      ",
	    "coerce_a      ",
	    "coerce_i      ",
	    "coerce_d      ",
	    "coerce_s      ",
	    "astype        ",
	    "astypelate    ",
	    "coerce_u      ",
	    "coerce_o      ",
	    "OP_0x8A       ",
	    "OP_0x8B       ",
	    "OP_0x8C       ",
	    "OP_0x8D       ",
	    "OP_0x8E       ",
	    "OP_0x8F       ",
	    "negate        ",
	    "increment     ",
	    "inclocal      ",
	    "decrement     ",
	    "declocal      ",
	    "typeof        ",
	    "not           ",
	    "bitnot        ",
	    "OP_0x98       ",
	    "OP_0x99       ",
	    "concat        ",
	    "add_d         ",
	    "OP_0x9C       ",
	    "OP_0x9D       ",
	    "OP_0x9E       ",
	    "OP_0x9F       ",
	    "add           ",
	    "subtract      ",
	    "multiply      ",
	    "divide        ",
	    "modulo        ",
	    "lshift        ",
	    "rshift        ",
	    "urshift       ",
	    "bitand        ",
	    "bitor         ",
	    "bitxor        ",
	    "equals        ",
	    "strictequals  ",
	    "lessthan      ",
	    "lessequals    ",
	    "greaterthan   ",
	    "greaterequals ",
	    "instanceof    ",
	    "istype        ",
	    "istypelate    ",
	    "in            ",
	    "OP_0xB5       ",
	    "OP_0xB6       ",
	    "OP_0xB7       ",
	    "OP_0xB8       ",
	    "OP_0xB9       ",
	    "OP_0xBA       ",
	    "OP_0xBB       ",
	    "OP_0xBC       ",
	    "OP_0xBD       ",
	    "OP_0xBE       ",
	    "OP_0xBF       ",
	    "increment_i   ",
	    "decrement_i   ",
	    "inclocal_i    ",
	    "declocal_i    ",
	    "negate_i      ",
	    "add_i         ",
	    "subtract_i    ",
	    "multiply_i    ",
	    "OP_0xC8       ",
	    "OP_0xC9       ",
	    "OP_0xCA       ",
	    "OP_0xCB       ",
	    "OP_0xCC       ",
	    "OP_0xCD       ",
	    "OP_0xCE       ",
	    "OP_0xCF       ",
	    "getlocal0     ",
	    "getlocal1     ",
	    "getlocal2     ",
	    "getlocal3     ",
	    "setlocal0     ",
	    "setlocal1     ",
	    "setlocal2     ",
	    "setlocal3     ",
	    "OP_0xD8       ",
	    "OP_0xD9       ",
	    "OP_0xDA       ",
	    "OP_0xDB       ",
	    "OP_0xDC       ",
	    "OP_0xDD       ",
	    "OP_0xDE       ",
	    "OP_0xDF       ",
	    "OP_0xE0       ",
	    "OP_0xE1       ",
	    "OP_0xE2       ",
	    "OP_0xE3       ",
	    "OP_0xE4       ",
	    "OP_0xE5       ",
	    "OP_0xE6       ",
	    "OP_0xE7       ",
	    "OP_0xE8       ",
	    "OP_0xE9       ",
	    "OP_0xEA       ",
	    "OP_0xEB       ",
	    "OP_0xEC       ",
	    "OP_0xED       ",
	    "OP_0xEE       ",
	    "debug         ",
	    "debugline     ",
	    "debugfile     ",
	    "bkptline      ",
	    "timestamp     ",
	    "OP_0xF4       ",
	    "verifypass    ",
	    "alloc         ",
	    "mark          ",
	    "wb            ",
	    "prologue      ",
	    "sendenter     ",
	    "doubletoatom  ",
	    "sweep         ",
	    "codegenop     ",
	    "verifyop      ",
	    "decode        "
	];
	
	var totalSize:int
	var opSizes:Array = new Array(256)


	const ATTR_final			:int = 0x01; // 1=final, 0=virtual
	const ATTR_override         :int = 0x02; // 1=override, 0=new
    const ATTR_metadata         :int = 0x04; // 1=has metadata, 0=no metadata
	const ATTR_public           :int = 0x08; // 1=add public namespace
	
	const CLASS_FLAG_sealed		:int = 0x01;
    const CLASS_FLAG_final		:int = 0x02;
    const CLASS_FLAG_interface	:int = 0x04;
*/	
	public class Abc
	{
		private var data:ByteArray
		
		var major:int
		var minor:int
		
		var ints:Array
		var uints:Array
		var doubles:Array
		var strings:Array
		var namespaces:Array
		var nssets:Array
		var names:Array
		
		var defaults:Array = new Array(Constants.constantKinds.length)
		
		var methods:Array
		var instances:Array
		var classes:Array
		var scripts:Array
		
		var publicNs = new Namespace("")
		var anyNs = new Namespace("*")

		var magic:int
		
		public function Abc(data:ByteArray)
		{
			data.position = 0
			this.data = data
			magic = data.readInt()

			Constants.print("magic " + magic.toString(16))

			if (magic != (46<<16|14) && magic != (46<<16|15) && magic != (46<<16|16))
				throw new Error("not an abc file.  magic=" + magic.toString(16))
			
			parseCpool()
			
			defaults[CONSTANT_Utf8] = strings
			defaults[CONSTANT_Int] = ints
			defaults[CONSTANT_UInt] = uints
			defaults[CONSTANT_Double] = doubles
			defaults[CONSTANT_Int] = ints
			defaults[CONSTANT_False] = { 10:false }
			defaults[CONSTANT_True] = { 11:true }
			defaults[CONSTANT_Namespace] = namespaces
			defaults[CONSTANT_PrivateNs] = namespaces
			defaults[CONSTANT_PackageNs] = namespaces
			defaults[CONSTANT_PackageInternalNs] = namespaces
			defaults[CONSTANT_ProtectedNs] = namespaces
			defaults[CONSTANT_StaticProtectedNs] = namespaces
			defaults[CONSTANT_StaticProtectedNs2] = namespaces
			defaults[CONSTANT_Null] = { 12: null }		
			
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
		
		public function parseCpool()
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

			print("Cpool numbers size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position
			
			// strings
			n = readU32()
			strings = [""]
			for (i=1; i < n; i++)
				strings[i] = data.readUTFBytes(readU32())

			print("Cpool strings count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position
			
			// namespaces
			n = readU32()
			namespaces = [publicNs]
			for (i=1; i < n; i++)
				switch (data.readByte())
				{
				case CONSTANT_Namespace:
				case CONSTANT_PackageNs:
				case CONSTANT_PackageInternalNs:
				case CONSTANT_ProtectedNs:
				case CONSTANT_StaticProtectedNs:
				case CONSTANT_StaticProtectedNs2:
				{
					namespaces[i] = new Namespace(strings[readU32()])
					// todo mark kind of namespace.
					break;
				}
				case CONSTANT_PrivateNs:
					readU32();
					namespaces[i] = new Namespace(null, "private")
					break;
				}

			print("Cpool namespaces count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
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

			print("Cpool nssets count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position
			
			// multinames
			n = readU32()
			names = [null]
			namespaces[0] = anyNs
			strings[0] = "*" // any name
			for (i=1; i < n; i++)
				switch (data.readByte())
				{
				case CONSTANT_Qname:
				case CONSTANT_QnameA:
					names[i] = new QName(namespaces[readU32()], strings[readU32()])
					break;
				
				case CONSTANT_RTQname:
				case CONSTANT_RTQnameA:
					names[i] = new QName(strings[readU32()])
					break;
				
				case CONSTANT_RTQnameL:
				case CONSTANT_RTQnameLA:
					names[i] = null
					break;
				
				case CONSTANT_NameL:
				case CONSTANT_NameLA:
					names[i] = new QName(new Namespace(""), null)
					break;
				
				case CONSTANT_Multiname:
				case CONSTANT_MultinameA:
					var name = strings[readU32()]
					names[i] = new Multiname(nssets[readU32()], name)
					break;

				case CONSTANT_MultinameL:
				case CONSTANT_MultinameLA:
					names[i] = new Multiname(nssets[readU32()], null)
					break;
					
				default:
					throw new Error("invalid kind " + data[data.position-1])
				}

			print("Cpool names count "+ n +" size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
			start = data.position

			namespaces[0] = publicNs
			strings[0] = "*"
		}
		
		public function parseMethodInfos()
		{
			var start:int = data.position
			names[0] = new QName(publicNs,"*")
			var method_count:int = readU32()
			methods = []
			for (var i:int=0; i < method_count; i++)
			{
				var m = methods[i] = new MethodInfo()
				var param_count:int = readU32()
				m.returnType = names[readU32()]
				m.paramTypes = []
				for (var j:int=0; j < param_count; j++)
					m.paramTypes[j] = names[readU32()]
				m.debugName = strings[readU32()]
				m.flags = data.readByte()
				if (m.flags & HAS_OPTIONAL)
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
								print("ERROR kind="+kind+" method_id " + i)
                            else
							    m.optionalValues[k] = defaults[kind][index]
						}
					}
				}
				if (m.flags & HAS_ParamNames)
				{
					// has_paramnames
					for( var k:int = 0; k < param_count; ++k)
                    {
                        readU32();
                    }
                }
			}
			print("MethodInfo count " +method_count+ " size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}

		public function parseMetadataInfos()
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
				for(var q:int = 0; q < values_count; ++q)
					m[names[q]] = strings[readU32()] // value
			}
		}

		public function parseInstanceInfos()
		{
			var start:int = data.position
			var count:int = readU32()
			instances = []
			for (var i:int=0; i < count; i++)
	        {
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
	        	m.kind = TRAIT_Method
	        	m.id = -1
	        	parseTraits(t)
	        }
			print("InstanceInfo size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}
		
		public function parseTraits(t:Traits)
		{
			var namecount = readU32()
			for (var i:int=0; i < namecount; i++)
			{
				var name = names[readU32()]
				var tag = data.readByte()
				var kind = tag & 0xf
				var member
				switch(kind) {
				case TRAIT_Slot:
				case TRAIT_Const:
				case TRAIT_Class:
					var slot = member = new SlotInfo()
					slot.id = readU32()
					t.slots[slot.id] = slot
					if (kind==TRAIT_Slot || kind==TRAIT_Const)
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
				case TRAIT_Method:
				case TRAIT_Getter:
				case TRAIT_Setter:
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

		public function parseClassInfos()
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
	        	t.init.kind = TRAIT_Method
	        	parseTraits(t)
			}			
			print("ClassInfo size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+"%")
		}

		public function parseScriptInfos()
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
				t.init.kind = TRAIT_Method	    
	        	parseTraits(t)
	        }
			print("ScriptInfo size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}

		public function parseMethodBodies()
		{
			var start:int = data.position
			var count:int = readU32()
			for (var i:int=0; i < count; i++)
	        {
	        	var m = methods[readU32()]
				m.max_stack = readU32()
	        	m.local_count = readU32()
	        	var initScopeDepth = readU32()
	        	var maxScopeDepth = readU32()
	        	m.max_scope = maxScopeDepth - initScopeDepth
	        	var code_length = readU32()
	        	m.code = new ByteArray()
				m.code.endian = "littleEndian"
	        	if (code_length > 0)
		        	data.readBytes(m.code, 0, code_length)
	       		var ex_count = readU32()
	       		for (var j:int = 0; j < ex_count; j++)
	       		{
	       			var from = readU32()
	       			var to = readU32()
	       			var target = readU32()
	       			var type = names[readU32()]
					//print("magic " + magic.toString(16))
					//if (magic >= (46<<16|16))
						var name = names[readU32()];
	       		}
	       		parseTraits(m.activation = new Traits)
	        }
			print("MethodBodies size "+(data.position-start)+" "+int(100*(data.position-start)/data.length)+" %")
		}
		
		public function dump(indent:String="")
		{
			for each (var t in scripts)
			{
				print(indent+t.name)
				t.dump(this,indent)
				t.init.dump(this,indent)
			}

			for each (var m in methods)
			{
				if (m.anon) {
					m.dump(this,indent)
				}
			}
			
			print("OPCODE\tSIZE\t% OF "+totalSize)
			var done = []
			for (;;)
			{
				var max:int = -1;
				var maxsize:int = 0;
				for (var i:int=0; i < 256; i++)
				{
					if (opSizes[i] > maxsize && !done[i])
					{
						max = i;
						maxsize = opSizes[i];
					}
				}
				if (max == -1)
					break;
				done[max] = 1;
				print(opNames[max]+"\t"+int(opSizes[max])+"\t"+int(100*opSizes[max]/totalSize)+"%")
			}
		}
	}
}

