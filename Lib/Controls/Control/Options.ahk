/** Class Options_vgui
*/
Class Options_vgui
{

	options	:= ""

	/** Set Control Options
		@param string options of control // https://autohotkey.com/docs/commands/Gui.htm#Controls_Uncommon_Styles_and_Options
		@param string $control_type_defaults ALLOWS CHANGE TYPE OF CONTROL for default values E.G: for control type Text set defaults of "Label"
	*/
	set($options)
	{
		this.options := $options
		;if($control_type_defaults!="")
			;this.control_type := $control_type_defaults
	}
	/** add
	*/
	add($options)
	{
		this.options .= " " $options
	}
	/** get All or on of options
		@param string $option "key" part of option to return
			E.G:	get()	;// return whole options string like: "x16 y32 w128 h24 border"
				get("w")	;// return value of "w" option  like :"128"

		@return string $option given option or all options
	*/
	get($option:="")
	{
		if($option!=""){
			$option_match := this._getOptionFromString(this.options, $option )
			return % $option_match ? $option_match : ""
		}else
			return % this.options  ; " border"
	}
	/** _getOptionFromString
	*/
	_getOptionFromString($options, $option)
	{
		RegExMatch( $options, "i)(?:^|\s)" $option "([^\s]+)" , $option_match )
		return % $option_match1
	}


}
