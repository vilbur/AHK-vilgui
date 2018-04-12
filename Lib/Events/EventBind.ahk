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
	call($event, $event_data:="")
	{
		$EventObj := this._getEventObject($event, $event_data)
	
		this._callCallback($event, $EventObj)
	}
	/** Find if event is defined
	 */
	has( $event )
	{
		return % this.events.hasKey($event)
	}
	/**
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
	/**
	 */
	_setCallback($event, $callback, $params*)
	{
		this.events[$event] := new Callback_vgui($callback, $params*)
	}

	/** _removeCallback
	 */
	_removeCallback($event)
	{
		this.events[$event] := ""
	}
	/*-----------------------------------------
		
	-----------------------------------------
	*/
	/**
	 */
	_getEventObject($event, $event_data:="")
	{		
		$EventObj := new EventObj_vgui()
		
		$EventObj.set("event", $event)
		
		if( $event_data )
			$EventObj.set($event_data)
			
		return $EventObj 
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
