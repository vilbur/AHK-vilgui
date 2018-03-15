/** Class ControlsListTypes
*/
Class ControlsListTypes_vgui{

	_control_types :=  ["GroupBox","Button","Edit","Text","Checkbox"
					   ,"Dropdown","Radio"
					   ,"File","Folder"
					   ,"ListView","ListBox","Keypress"
					   ,"Tabs"]

	__New(){
		For $t, $type in this._control_types
			this[$type] := {}
	}
	/** add
	*/
	add($Control){
		this[$Control._type][$Control._name] := &$Control
		;this[$Control._type][$Control.hwnd] := &$Control
	}
	/** getCountOfType
	*/
	getCountOfType($control_type){
		$count := 0
		if(this[$control_type])
			for $name, $address in this[$control_type]
				$count++
				;MsgBox,262144,variable, %$name%,3
		return %$count%
	}

	;/** _setObjectForType
	;*/
	;_setObjectForType($Control){
	;	if(!this[$Control._type])
	;		 this[$Control._type] := {}
	;}

}
