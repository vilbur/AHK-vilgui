/** Class Gui
*/
Class Gui_vgui extends GuiLayout_vgui
{
	Monitor	:= new Monitor()
	
	_last_active_window	:= "" ; store last active window for centering
	   
	/** wrapper for https://autohotkey.com/docs/commands/Gui.htm
	 ;*	@param string $options strings from documentation 
	*/
	gui($command, $param1:="", $param2:="", $param3:="")
	{
		Gui, % this._gui($command), %$param1%, %$param2%, %$param3%		
		return this
	}
	/**	wrapper for https://autohotkey.com/docs/commands/Gui.htm#Show
	 *	@param string $options
	 */
	show($options:="")
	{
		Gui, % this._gui("Show"), %$options%, % this._title
		
		this._setHwnd()

		return this
	}	
	/** wrapper for https://autohotkey.com/docs/commands/Gui.htm#Options
	 *	@param string $options strings from documentation 
	*/
	options($option:="")
	{
		;MsgBox,262144,option, %$option%,3 
		;Gui, % this._name ":" $option
		Gui, % this._gui($option)	
		return this
	}
	/** set window always on top
	*/
	alwaysOnTop($toggle:=true)
	{
		this.options(this._getPlusMinus($toggle) "AlwaysOnTop")
		return this
	}
	
	/** submit gui
		@return object values of all controls
	*/
	submit()
	{
		$form_data := this.Controls.values()
		
		For $tabs_name, $address in this.Controls.Types.Tabs
			$form_data[$tabs_name] := this[$tabs_name].getControlsValues()

		this.Events.gui.call("onSubmit", {data:$form_data})	; call GUI events
		return %$form_data%
	}
	/** close window
	*/
	close()
	{
		;MsgBox,262144,, CLOSE,2		
		this.Events.gui.call("onClose")
		this.options("Destroy")
	}
	/** exit script
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
		this._hwnd := WinExist("A")
		
		$_GUI[$hwnd]	:= this
	} 


}
