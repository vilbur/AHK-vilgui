/** Class EventBind_vgui
*/
Class EventBind_vgui
{

	events	:=	{}

	/*-----------------------------------------
		SET & CALL CALLBACK
	-----------------------------------------
	*/
	/** 1) Call custom  callback
		2) Call default callback
	*/
	_callCallback($event, $EventObj)
	{
		this.events[$event].call($EventObj)		
	}
	/**
	 */
	_bindCallback( $event, $callback, $params* )
	{
		if( $callback )
			this._setCallback($event, $callback, $params*)
		else
			this._removeCallback($event)
	}
	/** Find if event is defined
	 */
	_has( $event )
	{
		return % this.events.hasKey($event)
	}
	/**
	 */
	_setCallback($event, $callback, $params*)
	{
		this.events[$event] := new Callback_vgui($callback, $aParams*)
	}

	/** _removeCallback
	 */
	_removeCallback($event)
	{
		this.events[$event] := ""
	}
	/*-----------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** parent
	*/
	Parent($Parent:="")
	{
		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}

}
