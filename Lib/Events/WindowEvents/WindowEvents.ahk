/** Class WindowEvents_vgui
*/
Class WindowEvents_vgui extends EventBind_vgui
{
	
	/**
	 */
	bind( $event, $callback, $params* )
	{
		this.bindEvents()
		this._setUserOrDefaultCallback( $event, $callback, $params* )
		
		return this 
	}
	/**
	 */
	_getEventObject($event)
	{
		$EventObj := new EventObj_vgui()
							.set("event", $event)
		
		return $EventObj 
	}
	
	/** Call function on window event
	*/
	bindEvents()
	{
		if(!this.allready_bind)
		{
			Gui +LastFound
			
			hWnd := WinExist()
			DllCall( "RegisterShellHookWindow", UInt,Hwnd )
			MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
			OnMessage( MsgNum, "onWindowMessage" )

			this.allready_bind	:= true
		}
	}

}



/** Recive Window Message
*/
onWindowMessage( wParam, lParam )
{
	DetectHiddenWindows, On
	WinGetTitle, $winTitle, ahk_id %lParam%
	
	$GUI := $_GUI[$winTitle]
	
	$events :=	{2:	"close"
		,6:	"created"
		,32772:	"focus"}
	
	$event	:= $events[wParam]
	$event_data	:= {title:$winTitle, event: $event}
	
	if($GUI && $event)
	{
		if($event=="created"){
			if( $_GUI_title_last != $winTitle ) ; prevent multiple fires on gui created
				$GUI.Events.Window.call($event, $event_data)
		
		} else if($event=="close")
			$GUI.Events.Gui.call("close", $event_data)
		
		else
			$GUI.Events.Window.call($event, $event_data)
	
		$_GUI_title_last := $winTitle
				
	}else if($event=="focus")
		$_GUI[$_GUI_title_last].Events.Window.call("blur", $event_data)
			
}



