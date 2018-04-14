/** Class ControlsList
*/
Class ControlsList_vgui
{

	_ControlsTypes	:= new ControlsListTypes_vgui()
	
	
	/** Set Control to list
	*/
	set($Control)
	{
		this[$Control.hwnd] := $Control
		this._ControlsTypes.add($Control)
	}
	/** get control from list by given control name and key
	 *
	 * @param string $control_name
	 * @param string $key_in_Control is key in Control object
	 *
	 */
	get($control_name, $key_in_Control:="_name")
	{
		For $c, $Control in this
			if($Control[$key_in_Control]==$control_name)
				return %$Control%		
	}
	/** getUniqueName
	*/
	getUniqueName($Control)
	{
		$control_name := $Control._name
		While, this[$control_name]
			$control_name := RegExReplace( $Control._name, "i)\d+$", "" ) A_Index ; remove digind on end of name, for right counting "button1, button2, button3'

		return %$control_name%
	}

	/** Class of control exists allready ?
	*/
	controlClassExists($Control)
	{
		$control_address := &$Control
		For $control_name, $address_in_list in this._ControlsTypes[$Control._type]
			if($control_address==$address_in_list)
				return true
		return
	}
	/** delelte all controls
	 */
	deleteAllControls()
	{
		For $key, $Control in this
			if($key!="_ControlsTypes") {
				;MsgBox,262144,DELETE CONTROL, % $Control._name ,3
				$Control.delete()
				;sleep, 1500
			}
	}


}
