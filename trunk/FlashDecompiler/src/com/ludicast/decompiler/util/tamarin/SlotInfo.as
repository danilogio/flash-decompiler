package com.ludicast.decompiler.util.tamarin
{
	
	public class SlotInfo extends MemberInfo
	{
		public var type:*
		public var value:*
		public function format():String
		{
			return Constants.traitKinds[kind] + " " + name + ":" + type + 
				(value !== undefined ? (" = " + (value is String ? ('"'+value+'"') : value)) : "") + 
				"\t/* slot_id " + id + " */"
		}
		public function dump(abc:Abc, indent:String, attr:String=""):void
		{
					
			if (kind ==  Constants.TRAIT_Const || kind ==  Constants.TRAIT_Slot)
			{
				if (metadata) {
					for each (var md:* in metadata)
						 Constants.print(indent+md)
				}
				 Constants.print(indent+attr+format())
				return
			}
			
			// else, class
			
			var ct:Traits = value
			var it:Traits = ct.itraits
			 Constants.print('')
			if (metadata) {
				for each (var metad:* in metadata)
					 Constants.print(indent+metad)
			}
			var def:String;
			if (it.flags &  Constants.CLASS_FLAG_interface)
				def = "interface"
			else {
				def = "class";
				if (!(it.flags &  Constants.CLASS_FLAG_sealed))
					def = "dynamic " + def;
				if (it.flags &  Constants.CLASS_FLAG_final)
					def = "final " + def;
					
			}
			Constants.print(indent+attr+def+" "+name+" extends "+it.base)
			var oldindent:* = indent
			indent +=  Constants.TAB
			if (it.interfaces.length > 0)
				 Constants.print(indent+"implements "+it.interfaces)
			 Constants.print(oldindent+"{")
			it.init.dump(abc,indent)
			it.dump(abc,indent)
			ct.dump(abc,indent,"static ")
			ct.init.dump(abc,indent,"static ")
			 Constants.print(oldindent+"}\n")
		}
	}
}

