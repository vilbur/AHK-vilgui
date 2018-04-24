/** Class WindowEvents_vgui
*/
Class WindowEvents_vgui extends EventBind_vgui
{
	_messages	:= {}
	_paused	:= {}	
	Message 	:= new WindowMessage_vgui().WindowEvents(this)
	
	/** 
	*/
	call($event, $event_data:="")
	{	
		this._call($event, $event_data)
	}
	
	/**
	 */
	on( $event, $callback, $params* )
	{
		this.setMessages($event)
		this._bindCallback( $event, $callback, $params* )
		
		return this 
	}
	/** Call function on window event
	*/
	setMessages($event)
	{
		if $event in  created,close,focus,blur
			this._setOnMessageMain()
			
		else if $event in size,move,sizedmoved
			this["_setOn" $event "Message"]()						
	}
	/*-----------------------------------------
		BIND ON WINDOW MESSAGES
	-----------------------------------------
	*/
	/** Call function on window event
	*/
	_setOnMessageMain()
	{
		if( this._messages.main )
			return
		Gui +LastFound
		
		hWnd := WinExist()
		DllCall( "RegisterShellHookWindow", UInt,Hwnd )
		MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
		OnMessage( MsgNum, "onWindowMessage" )
		
		this._messages.main	:= true
	}
	/** Call function on window event
	*/
	_removeOnMessageMain()
	{
		OnMessage(  DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" ), "" )
		
		this._messages.main	:= false
	}
	/** Call function on window event
	*/
	_setOnMoveMessage()
	{
		if( ! this._messages.moved )
			OnMessage(0x03 , "onWindowMoveMessage")			
			
			this._messages.moved	:= true
	}
	/** Call function on window event
	*/
	_setOnSizedMovedMessage()
	{
		if( ! this._messages.sizedmoved )
			OnMessage(0x232, "onWindowSizedMovedMessage")			
			
			this._messages.sizedmoved	:= true
	}
	/*-----------------------------------------
		PAUSE & RESUME EVENT
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





















