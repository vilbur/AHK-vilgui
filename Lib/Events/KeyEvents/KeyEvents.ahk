/** Class KeyEvents_vgui
*/
Class KeyEvents_vgui extends EventBind_vgui
{
	
	/**
	 */
	bind( $key, $callback, $params* )
	{
		this._bindEvents()
		this._bindCallback( $key, $callback, $params* )
	}
	/**
	 */
	call($key, $event_data:="")
	{
		this._callCallback($key, this._getEventObject($key))
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
	_bindEvents()
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
