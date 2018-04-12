/** Class KeyEvents_vgui
*/
Class KeyEvents_vgui extends EventBindDefault_vgui
{
	/**
	 */
	on( $key, $callback, $params* )
	{
		this._setOnMessage()
		this._setUserOrDefaultCallback( $key, $callback, $params* )
		
		return this
	}
	/** Fired on escape pressed.
	*/
	onEscape($callback, $params*)
	{
		this.on("Escape", $callback, $params*)
		return this
	}
	/** Fired on enter pressed.
	*/
	onEnter($callback, $params*)
	{
		this.on("Enter", $callback, $params*)
		return this
	}
	/**
	 */
	_getEventObject($key)
	{
		$EventObj := new EventObj_vgui()
						.set("key", $key)
		
		return $EventObj 
	} 
	/** Call function on keypress
	*/
	_setOnMessage()
	{
		if(!this.allready_bind)
		{
			WM_KEYDOWN := 0x100
			OnMessage(WM_KEYDOWN, "onKeyDownMessage")
			this.allready_bind	:= true
		}
	}

}

/** Recive Key Down Message
	https://autohotkey.com/board/topic/88725-detecting-keypress-in-edit-control/
  */
onKeyDownMessage(W, L, M, H)
{
	WinGetTitle, $winTitle, A
	$GUI := $_GUI[$winTitle]
	
	if($GUI && A_TimeIdleKeyboard==0 )
	{
		$Events	:= $GUI.Events.Key
		$key	:=  GetKeyName(Format("vk{:x}", W))

		$Events.call($key)
		
	}else 
		$GUI.List.get(H, "hwnd" ).Event.callEventCallback("keyPress", {"key": GetKeyName(Format("vk{:x}", W))})	

}
