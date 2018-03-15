/** Class ControlsList
*/
Class ControlsList_vgui{

	_ControlsTypes	:= new ControlsListTypes_vgui()
	;_List	:= {}
	;__New(){
	;	MsgBox,262144,, ControlsList, 2
	;}

	/** Set Control to list
	*/
	set($Control){
		this[$Control._name] := $Control
		this._ControlsTypes.add($Control)
	}
	/** get control from list by given key
	*/
	get($value, $key:="name"){
		;MsgBox,262144,variable, %$value%,3
		For $c, $Control in this
			if($Control[$key]==$value)
				return %$Control%
	}
	/** getUniqueName
	*/
	getUniqueName($Control){
		$control_name := $Control._name
		;Dump($control_name, "control_name A", 1)
		While, this[$control_name]
			$control_name := RegExReplace( $Control._name, "i)\d+$", "" ) A_Index ; remove digind on end of name, for right counting "button1, button2, button3'

		;Dump($control_name, "control_name B", 1)
		;Dump("----------------", "", 1)
		return %$control_name%
	}

	/** Class of control exists allready ?
	*/
	controlClassExists($Control){
		$control_address := &$Control
		For $control_name, $address_in_list in this._ControlsTypes[$Control._type]
			if($control_address==$address_in_list)
				return true
		return
	}


}
