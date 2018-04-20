/** Class ControlSetup
*/
Class ControlSetup_vgui extends GuiControl_vgui{

	_name	:= ""
	_type	:= ""
	_value	:= ""

	/** Set\Get control name
	*/
	name($name:="")
	{
		if($name)
			this._name	:= $name

		return % $name ? this : this._name
	}
	/** Set value of control if not added in GUI yet
	*/
	value($value:="~null")
	{
		if($value=="~null"){
			GuiControlGet, $value,, % this.hwnd
			return %$value%
		}
		this._value := $value

		return this
	}
	/** Set Control Options
		@param string options of control // help: https://autohotkey.com/docs/commands/Gui.htm#OtherOptions
		@param string $control_type_defaults allows change type of control for default values E.G: for control type Text set defaults of "Label"
	*/
	options($options:="~null")
	{
		if($options=="~null")
			return % this._Options.get()

		this._Options.set($options)
		return this
	}
	/*---------------------------------------
		PRIVATE
	-----------------------------------------
	*/

	/** _setToEmptyValue
	*/
	_setToEmptyValue($name)
	{
		MsgBox,262144,, SMAZAT METHODU ? `n`n ControlSetup._setToEmptyValue(),2
		if(this._value=="")
			this._value := $name
	}
	/*---------------------------------------
		LABEL
	-----------------------------------------
	*/
	/** Set label
	*/
	label($label:="", $options:="")
	{
		if($label!=false)
			this._label	:= isObject($label) ? $label : this.Controls()
			.Label($label)
			;.Label()
			.name( $label "Label")
			.options($options).controlIsLabel()

		else
			this._label := false ; this allows set label false to turn off default labels of "File" and "Folder" controls
		return this
	}
	/** add Label before
		TODO: RENAME THIS TO PRIVATE
	*/
	addLabel()
	{
		;MsgBox,262144,, addLabel,2
		;Dump(this._label, "this._label", 1)
		if(this._label)
			this._Label.add()
	}
	/** Indicates if control is label
		Used by Layout.Container.Section
	*/
	controlIsLabel($is_label:=true){
		this._is_label := $is_label
		return this
	}

}
