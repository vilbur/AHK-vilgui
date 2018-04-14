/** Class EventBind_vgui
*/
Class EventBind_vgui
{

	events	:=	{}

	/*-----------------------------------------
		SET & CALL CALLBACK
	-----------------------------------------
	*/
	/** 
	*/
	call($event, $event_data:="")
	{	
		return % this._call($event, $event_data)
	}
	/**
	*/
	_call($event, $event_data:="")
	{
		$EventObj := this._getEventObject($event, $event_data)
	
		return % this.events[$event].call($EventObj)
	}
	/** Find if event is defined
	 */
	has( $event )
	{
		return % this.events.hasKey($event)
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
		PAUSE & RESUME EVENTS
	-----------------------------------------
	*/
	/**
	  * @param string|array $events
	 */
	pause( $events )
	{
		this._pauseOrResume( "pause", $events )
	}
	/**
	 */
	resume( $events )
	{
		this._pauseOrResume( "resume", $events )
	}
	/**
	 */
	_pauseOrResume( $method, $events )
	{
		if( ! isObject($events) )
			$events := [$events] 
		
		For $e, $event in $events
			this["_" $method]( $event ) 
	} 
	/**
	 */
	_pause( $event )
	{
		this._paused[$event] := this.events[$event]
		
		this.events.delete($event)
	}
	/**
	 */
	_resume( $event )
	{
		this.events[$event] := this._paused[$event]
		
		this._paused.delete($event)
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
