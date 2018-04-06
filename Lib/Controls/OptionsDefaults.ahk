/** Class OptionsDefault_vgui
*/
Class OptionsDefault_vgui{


	/* this.defaults[keys]:
			shared	= options shared for multiple types
			w	= width	of control
			h	= height	of control
			options	= defaults options added to control
	*/
	defaults :=	{"Text":	{"shared":	"common"}
		,"Button":	{"shared":	"common"}
		,"Edit":	{"shared":	"common"}
		,"Checkbox":	{"shared":	"common"}
		,"Radio":	{"shared":	"common"}
		,"Label":	{"shared":	"common", "w":	64}
		,"Path":	{"shared":	"browse"}
		,"File":	{"shared":	"browse"}		
		,"Folder":	{"shared":	"browse"}
		,"Tabs":	{"options":	"AltSubmit", "w":"auto"}
		,"Dropdown":	{"shared":	"commonW"}
		,"ListBox":	{"shared":	"commonW",	"options":	"Multi",	"h":	128}
		,"ListView":	{"w":	512,	"options":	"AltSubmit"}}

	shared  := 	{"common":	{"w":128, "h":24}
		,"commonW":	{"w":128}
		,"browse":	{"w":512, "h":24}}

	/** set
	*/
	set($control_type, $param1, $param2:=""){
		if(!$param2){
			 $param2	:= $param1
			 $param1	:= "options"
		}

		this.defaults[$control_type][$param1] := $param2
	}
	/** get
	*/
	get($control_type){
		return % this._getOptionsString(this.shared [this.defaults[$control_type].shared]) " " this._getOptionsString(this.defaults[$control_type])
	}
	/** getDefaulOption
	*/
	getDefaultOption($control_type, $option){
		$value_for_type	:= this.defaults[$control_type][$option]
		return % $value_for_type ? $value_for_type : this.shared[this.defaults[$control_type].shared][$option]
	}
	/** _getOptionsString
	*/
	_getOptionsString($options){
		$string := ""
		For $key, $value in $options
			$string .= this._getPairString($key, $value)
		return %$string%
	}
	/** _getPairString
	*/
	_getPairString($key, $value){
		if($key!="shared" && $value!="auto")
			$string := $key=="w"||$key=="h"? $key $value : $value
		return % $string ? " " $string : ""
	}



}
