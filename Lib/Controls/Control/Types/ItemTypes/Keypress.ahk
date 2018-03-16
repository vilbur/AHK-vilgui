/** Class Keypress_vgui
  
  MOVE THIS FILE SOMEWHERE, IT SHOULD BE NOT PLACED IN itemTypes
  
*/
Class Keypress_vgui extends Edit_vgui{
	/** Add to GUI
	*/
	add($name:=""){
		;MsgBox,262144,, ADD,2
		this.name($name)
		;this.Controls().edit()
						;.options("AltSubmit")
						
		this.type("Edit")
				this.callback(&this ".test")
						;.add()
		;this._type := "Edit"
		;MsgBox,262144,, Keypress,2
		return % this.Controls()
						.add(this) ; clone added object if user insert one object multiple times
	}

	/** test
	*/
	test($Event){
		$Event.message()
		MsgBox,262144,Test, %A_EventInfo%,2
	}

}