/** Class KeyEvents_vgui
*/
Class KeyEvents_vgui extends EventBind_vgui
{
	/** Fired on escape pressed.
	*/
	onEscape($callback, $params*)
	{
		this.bind("Escape", $callback, $params*)
		return this
	}
	/** Fired on enter pressed.
	*/
	onEnter($callback, $params*)
	{
		this.bind("Enter", $callback, $params*)
		return this
	}
	/**
	 */
	bind( $key, $callback, $params* )
	{
		this._bindKeyMainCallBack()
		this._setUserOrDefaultCallback( $key, $callback, $params* )
		
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
	_bindKeyMainCallBack()
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
		
	}else {
		;$control := $GUI.List.get(H, "hwnd" )
		$GUI.List.get(H, "hwnd" ).Event.callEventCallback("keyPress", {"key": GetKeyName(Format("vk{:x}", W))})
		;Dump($control, "control", 1)
	}

}
