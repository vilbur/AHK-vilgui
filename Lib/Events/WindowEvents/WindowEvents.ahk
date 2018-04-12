/** Class WindowEvents_vgui
*/
Class WindowEvents_vgui extends EventBind_vgui
{
	_binded_events	:= {}
	_paused	:= {}	
	Message 	:= new WindowMessage_vgui().WindowEvents(this)
	
	/**
	 */
	bind( $event, $callback, $params* )
	{
		this.bindEvents($event)
		this._bindCallback( $event, $callback, $params* )
		
		return this 
	}
	/**
	 */
	_getEventObject($event, $event_data)
	{
		$EventObj := new EventObj_vgui()
		
		$EventObj.set("event", $event)
		
		if( $event_data )
			$EventObj.set($event_data)
		

		;return this._setWindowInfo($EventObj)
		return $EventObj 		
	}
	/** Call function on window event
	*/
	bindEvents($event)
	{
		
		if $event in  created,close,focus,blur
			this._bindMainEvents()
			
		else if $event in size,move,sizedmoved
			this["_bind" $event "Events"]()			
			;this._bindResizeEvents()			
			
	}
	/*-----------------------------------------
		BIND ON WINDOW MESSAGES
	-----------------------------------------
	*/
	/** Call function on window event
	*/
	_bindMainEvents()
	{
		if( ! this._binded_events.main )
		{
			Gui +LastFound
			
			hWnd := WinExist()
			DllCall( "RegisterShellHookWindow", UInt,Hwnd )
			MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
			OnMessage( MsgNum, "onWindowMessage" )
			
			this._binded_events.main	:= true
		}
	}
	/** Call function on window event
	*/
	_bindSizeEvents()
	{
		if( ! this._binded_events.size )
			OnMessage(0x05, "onWindowSizeMessage")
			
			this._binded_events.size	:= true
	}
	/** Call function on window event
	*/
	_bindMoveEvents()
	{
		if( ! this._binded_events.moved )
			OnMessage(0x03 , "onWindowMoveMessage")			
			
			this._binded_events.moved	:= true
	}
	/** Call function on window event
	*/
	_bindSizedMovedEvents()
	{
		if( ! this._binded_events.sizedmoved )
			OnMessage(0x232, "onWindowSizedMovedMessage")			
			
			this._binded_events.sizedmoved	:= true
	}
	/*-----------------------------------------
		
	-----------------------------------------
	*/
	/**
	 */
	pause( $event )
	{
		if( ! this.events[$event] )
			return 
		
		this._paused[$event] := this.events[$event]
		
		this.events.delete($event)
	}
	/**
	 */
	resume( $event )
	{
		if( ! this._paused[$event] )
			return 
		
		this.events[$event] := this._paused[$event]
		
		this._paused.delete($event)
	}
}





















