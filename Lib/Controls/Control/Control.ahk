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
	/** Get configured Control object which is able passed to Controls.add()
	*/
	get()
	{
		this.preAdd()
		return this
	}
	/** _getValueOrItems
	*/
	_getValueOrItems()
	{
		return % RegExMatch( this._type, "i)(Tab|ListView|ListBox|Dropdown)") ? this._items.string: this._value ; this._value
	}
	/** sanitizeName
	*/
	_sanitizeName()
	{
		;this._name := RegExReplace( this._name, "\s+", "" )
		;this._name := RegExReplace( this._name, "[\s_-]+", "" )
		this._name := RegExReplace( this._name, "i)[^A-Z0-9_]+", "" )
		return this
	}

	/*---------------------------------------
		PARENTS
	-----------------------------------------
	*/
	/** Controls
	*/
	Controls(){
		return % Object(this._Controls)
	}
	/** Get Base lass VilGUI
		@return object
	*/
	Base(){
		return % this.Controls().Parent()
	}

}
