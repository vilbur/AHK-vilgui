/** Class WindowMessage_vgui
*/
Class WindowMessage_vgui
{
	_data	:= {}
	_events	:=	{1:	"created"
			,2:	"close"
			,32772:	"focus"}
	
	/** Recive Window Message
	*/
	callEvent( wParam, lParam )
	{
		$event	:= this._getEvent( wParam )
		$method	:= this._getEventMethod( $event )
					
		if( ! this.WindowEvents().has( $event ) )
			return
			
		this._setEventData(lParam)
		this._setWindowData(lParam)
		
		if( this._methodExists($method) )
			this[$method]($event)
		
		else
			this.WindowEvents().call($event, this._data)
	}
	/**
	 */
	_setEventData( $ahk_id )
	{
		WinGetTitle, $win_title,	ahk_id %$ahk_id%
		WinGetClass, $class,	ahk_id %$ahk_id%

		this._data	:= {class: $class, title: $win_title}
	} 
	/**
	 */
	_setWindowData( $ahk_id )
	{
		WinGetPos, $X, $Y, $width, $height, ahk_id %$ahk_id%

		this._data.x 	:= $X
		this._data.y 	:= $Y
		this._data.width	:= $width
		this._data.height 	:= $height
	} 
	/*-----------------------------------------
		EVENT METHODS
	-----------------------------------------
	*/
	/**
	 */
	_callCreated($event)
	{
		if( $_last_window != this._data.title ) ; prevent multiple fires on gui created
			this.WindowEvents().call($event, this._data)	
	}
	/*-----------------------------------------
		SETUP
	-----------------------------------------
	*/
	/**
	 */
	_getEvent( wParam )
	{
		;return % wParam is number ? this._events[wParam] : wParam
		return % this._events[wParam] ? this._events[wParam] : wParam		
	} 
	/**
	 */
	_getEventMethod( $event )
	{
		return % "_call" $event
	}
	/**
	 */
	_methodExists($method)
	{
		;return % this.HasKey( this._method )
		return % this[$method] != ""
	}
	/** WindowEvents
	*/
	WindowEvents($Parent:="")
	{
		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}

}
/*-----------------------------------------
	ON MESSAG CALLBACKS
-----------------------------------------
*/
/**
 */
onWindowMoveMessage( wParam )
{
	onWindowMessage( "move", WinExist("A") )
}

/**
 */
onWindowSizeMessage( wParam )
{
	onWindowMessage( "size", WinExist("A") )
}

/**
 */
onWindowSizedMovedMessage( wParam )
{
	;MsgBox,262144,wParam, %$wParam%,3 
	onWindowMessage( "sizedmoved", WinExist("A") )
}

/** Recive Window Message
*/
onWindowMessage( wParam, lParam )
{
	DetectHiddenWindows, On

	$GUI	:= $_GUI[lParam]	
						
	if( $GUI )
	{
		$_last_window	:= lParam ; save gui name for blur
		$GUI.Events.Window.Message.callEvent(wParam, lParam)
		
		if( wParam==2 )
			$GUI.Events.gui.call("onClose")
			
		else if( wParam=="sizedmoved" )
			$GUI._scrollbar()
			
	}
	else if( wParam==32772 ) { ; if blur
		$_GUI[$_last_window].Events.Window.Message.callEvent("blur", lParam)
		$_last_window	:= ""
	}
}



