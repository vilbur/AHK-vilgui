/** Class Gui
*/
Class Gui_vgui extends GuiLayout_vgui
{
	Monitor	:= new Monitor()
	
	_last_active_window	:= "" ; store last active window for centering

	/** Add tabs control
	*/
	Tabs($tabs)
	{
		return % new Tabs_vgui(this.Controls).items($tabs)
	}
	/*---------------------------------------
		SHOW METHODS
	-----------------------------------------
	*/
	/** Wrapper for [Gui, command](https://autohotkey.com/docs/commands/Gui.htm)
	 *	 
	 *	@param string $command command from documentation
	 
	 *	@param string $param1 param from documentation	 
	 *	@param string $param2 param from documentation
	 *	@param string $param3 param from documentation 	 	 	 
	 *
	 * @return self
	 */
	gui($command, $param1:="", $param2:="", $param3:="")
	{
		Gui, % this._gui($command), %$param1%, %$param2%, %$param3%		
		return this
	}
	/** Wrapper for [Gui, Show](https://autohotkey.com/docs/commands/Gui.htm#Show)
	 *
	 *	@param string $options options from documentation
	 *
	 * @return self
	 */
	show($options:="")
	{
		Gui, % this._gui("Show"), %$options%, % this._title
		return this
	}
	/** Wrapper for [Gui +/- option](https://autohotkey.com/docs/commands/Gui.htm#Options)
	 *
	 *	@param string $options options from documentation 
	 */
	options($options:="")
	{
		Gui, % this._gui($options)	 
		;MsgBox,262144,options, %$options%,3 
		return this
	}
	/** Set window always on top
	 *
	 * @param	boolean	$toggle
	 *
	 * @return self
	 */
	alwaysOnTop($toggle:=true)
	{
		this.options(this._getPlusMinus($toggle) "AlwaysOnTop")
	
		return this
	}
	/*---------------------------------------
		HIDE & RESTORE
	-----------------------------------------
	*/
	/** Hide gui to tray 
	 */
	hide()
	{
		this.Events.Window._removeOnMessageMain() ; remove onMessage, it breaks restore()
		WinHide, % this.ahkId()		
	}
	/** Restore gui from tray
	 */
	restore()
	{
		this.Events.Window._setOnMessageMain()
		this.show()
	}
	/*---------------------------------------
		Freeze\Unfreeze
	-----------------------------------------
	*/
	/** Freeze\Unfreeze
	 */
	redraw($toggle:=true)
	{
		if( $toggle )
			DllCall("LockWindowUpdate", Uint, 0)
		else
			DllCall("LockWindowUpdate", Uint, this._hwnd)
	}

	/*---------------------------------------
		SUBMIT, CLOSE & EXIT  METHODS
	-----------------------------------------
	*/
	/** Submit gui
	 *
	 *	@return {control_name:value}
	 */
	submit()
	{
		$form_data := this.Controls.values()
		
		For $tabs_name, $address in this.Controls.Types.Tabs
			$form_data[$tabs_name] := this[$tabs_name].getControlsValues()

		this.Events.gui.call("onSubmit", {data:$form_data})	; call GUI events
		return %$form_data%
	}
	/** Close window
	*/
	close()
	{
		;MsgBox,262144,, CLOSE,2		
		this.Events.gui.call("onClose")
		this.gui("Destroy")
	}
	/** Exit script
	*/
	exit()
	{
		;MsgBox,262144,, EXIT,2		
		this.Events.gui.call("onExit")
		ExitApp
	} 
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** return string "GuiName"  OR "GuiName:command"
	 */
	_gui($command:="")
	{
		return % this._name ( $command ? ":" $command : $command )
	} 
	/** @return string "ahk_id hwnd"
	 */
	ahkId($hwnd:="")
	{
		return % "ahk_id " ( $hwnd ? $hwnd : this._hwnd )
	}
	
	/** contvert boolean to string "+|-"
	*/
	_getPlusMinus($toggle)
	{
		return % $toggle ? "+" : "-"
	}
	/**
	 */
	_setHwnd()
	{
		sleep, 10
		this._hwnd := WinExist("A")
		
		$_GUI[this._hwnd]	:= this
	} 


}
