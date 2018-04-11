/** Class EventBind_vgui
*/
Class EventBind_vgui extends EventBindDefault_vgui
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
		$EventObj := this._getEventObject($event)
		
		if( $event_data )
			$EventObj.set($event_data)
		
		this._callCallback($event, $EventObj)
		this._callCallback($event "-default", $EventObj)		
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
		this.events[$event] := new Callback_vgui($callback, $params*)
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
