/** Class KeyEvents_vgui
*/
Class KeyEvents_vgui extends EventBindDefault_vgui
{
	_modifiers	:=	{"control":	0
			,"alt":	0
			,"shift":	0			
			,"Lwin":	0
			,"Rwin":	0}						
	
	/**
	  * @param string|array $key name of key or array with modifiers E.G.: "space" OR ["control", "alt", "space"]
	 */
	on( $key, $callback, $params* )
	{
		this._setOnMessage()
		this._setUserOrDefaultCallback( this._getModifiersEvent($key), $callback, $params* )		
		
		return this
	}
	/** 
	*/
	call($key, $event_data:="")
	{
		if $key in control,alt,shift,lwin,rwin
			return
		
		$EventObj 	:= this._getEventObject($event, $event_data)
		$modifiers	:= this._getModifiersPressed()
		$key_event	:= this._modifiersToString( $modifiers, $key )

		if( $modifiers )
			$EventObj.modifiers := $modifiers 
		
		$call_event := this.has($key_event) ? $key_event : (this.has($key) ? $key : false )

		if( $key_event )
			return % this._call( $call_event, $EventObj)
		
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

	/** Call function on keypress
	*/
	_setOnMessage()
	{
		if( this.allready_bind)
			return 
		
		OnMessage(0x100, "onKeyDownMessage")
		this.allready_bind	:= true
	}
	/** get string for event binding
	  * @return string "hotkey" OR hotkey with modifiers E.G.: "cas+space"
	 */
	_getModifiersEvent($keys)
	{
		if( ! isObject($keys) )
			return $keys
		
		$modifiers	:= this._modifiers.clone()
		;$hotkey	:= ""
		
		For $i, $hotkey in $keys
			if( $modifiers.hasKey($hotkey) )
				$modifiers[$hotkey] := true
			else
				$key := $hotkey
		
		return % this._modifiersToString( $modifiers, $key )

	}
	/** get currently pressed modifiers for event call
	 */
	_getModifiersPressed()
	{
		$modifiers	:= {}
		
		For $modifier, $value in this._modifiers
			if( GetKeyState($modifier) )
				$modifiers[$modifier] := true
			
		return $modifiers.GetCapacity() ? $modifiers : false
	}
	/**
	  * @return string "hotkey" OR hotkey with modifiers E.G.: "cas+space"
	 */
	_modifiersToString( $modifiers, $key )
	{
		$string  := this._joinModifires( $modifiers )
		return $string $key
	} 
	/**
	 */
	_joinModifires( $modifiers )
	{
		For $modifier, $value in $modifiers
			if( $value )
				$string .= $modifier "+"
	
		return $string 	
	} 
	
	
}

/** Recive Key Down Message
	https://autohotkey.com/board/topic/88725-detecting-keypress-in-edit-control/
  */
onKeyDownMessage(wParam, lParam, msg, hwnd)
{
	$GUI := $_GUI[WinExist("A")]	

	if($GUI && A_TimeIdleKeyboard==0 )
	{
		$Events	:= $GUI.Events.Key
		$key	:=  GetKeyName(Format("vk{:x}", wParam))
		
		if( $Events.has("number") && RegExMatch( $key, "[0-9]" ) )
			$Events.call("number", {key:$key})
			
		else
			$Events.call($key)
		
	}else 
		$GUI.List.get(H, "hwnd" ).Event.callEventCallback("keyPress", {"key": GetKeyName(Format("vk{:x}", wParam))})	

}



