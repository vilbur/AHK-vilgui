/** Class Control
*/
Class Control_vgui extends ControlSetup_vgui{

	_Options := new Options_vgui()

	__New($Controls){
		this._Controls	:= &$Controls
		this._guihwnd	:= $Controls._hwnd
		this._type	:= RegExReplace(  this.__class, "_vgui$", "" )
		this.address()
	}
	/** add
	*/
	add($name:="")
	{
		this.name($name)
		return % this.Controls().add(this) ; clone added object if user insert one object multiple times
	}
	/** delete control from Layout, ControlList and Gui 
	 */
	delete()
	{
		;MsgBox,262144,DELETE CONTROL, % this._name ,3
		Object(this._layout_container).deleteControlFromSection(this)

	}
	/**
	 */
	removeFromGui()
	{
		;MsgBox,262144,DELETE CONTROL, % this._name ,3

		;this.Controls()._List.delete(this.hwnd)
		WM_CLOSE=0x10
		PostMessage, %WM_CLOSE%,,,, % "ahk_id " this.hwnd
	}
	/** Get configured Control object which is able passed to Controls.add()
	*/
	get()
	{
		this.preAdd()
		return this
	}
	/** set Value Or Items
	*/
	_setValue($value)
	{
		if(this._isControlItemType())
			this.items($value)
		else 
			this.value($value)			
	}
	/** _getValueOrItems
	*/
	_getValueOrItems()
	{
		return % this._isControlItemType() ? this._items.string : this._value ; this._value
	}
	/**
	 */
	_isControlItemType()
	{
		return % RegExMatch( this._type, "i)(Tab|ListView|ListBox|Dropdown)")
	} 
	/** sanitizeName
	*/
	_sanitizeName()
	{
		this._name := RegExReplace( this._name, "i)[^A-Z0-9_]+", "" )
		return this
	}

	/*---------------------------------------
		PARENTS
	-----------------------------------------
	*/
	/** Controls
	*/
	Controls()
	{
		return % Object(this._Controls)
	}
	/** Get Base class VilGUI
		@return object
	*/
	Base()
	{
		MsgBox,262144,, "Control.Base() SMAZAT METODU",2 
		return % this.Controls().Parent()
	}

}
