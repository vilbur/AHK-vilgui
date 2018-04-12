/** Class WindowMessage_vgui
*/
Class WindowMessage_vgui
{
	_data	:= {}
	_events	:=	{2:	"close"
			,6:	"created"
			,32772:	"focus"}
	
	/** Recive Window Message
	*/
	callEvent( wParam, lParam )
	{
		$event	:= this._getEvent( wParam )
		$method	:= this._getEventMethod( $event )
		
		$_last_window	:= this._data.title

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
	/** Recive Window Message
	*/
	_onWindowMessage( wParam, lParam:="" )
	{

		;else if( $event == "size" )
		;	$GUI.Events.Window.call($event, $event_data)
		;
		;else if $event in "size,move,sized,moved"

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
onWindowMoveMessage( wParam, lParam )
{
	onWindowMessage( "move" )
}

/**
 */
onWindowSizeMessage( wParam, lParam )
{
	onWindowMessage( "size" )
}

/**
 */
onWindowSizedMovedMessage( wParam, lParam )
{
	onWindowMessage( "sizedmoved" )
}

/** Recive Window Message
*/
onWindowMessage( wParam, lParam:="" )
{
	DetectHiddenWindows, On
	
	if( ! lParam )
		WinGet, lParam,	ID, A
			
	WinGetTitle, $winTitle, ahk_id %lParam%

	$GUI	:= $_GUI[$winTitle]
			
	if( $GUI ) ; if blur
		$GUI.Events.Window.Message.callEvent(wParam, lParam)

	else if( wParam==32772 ) ; if blur
		$_GUI[$_last_window].Events.Window.Message.callEvent("blur", lParam)

}



