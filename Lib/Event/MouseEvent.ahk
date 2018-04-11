/** Class MouseEvent_vgui

   TODO: ADD SUPPORT FOR MOUSE EVENTS https://msdn.microsoft.com/en-us/library/windows/desktop/ms645617(v=vs.85).aspx

*/
Class MouseEvent_vgui {


	/** event
	*/
	event($event:=""){
		$events :=	{"leftClick":	"0x0201"
			,"activate":	"0x0021"
			,"wheel":	"0x020A"
			,"hover":	"0x02A0"}
		return % $events[$event]
	}

	/** call
	*/
	call(W, L, M, H){
		;MsgBox,262144,msg, %M%,3
		this[M].call()
		;Dump(this, "this.", 1)
		;this.leftClick.call()
	}

	/** Bind new event to class
	*/
	bind($on_event, $callback:="", $aParams*){
		;MsgBox,262144, MouseEvent_vgui, %$callback%,2

		this.bindMouseEvent(this.event($on_event))
		this[this.event($on_event)+0] := new Callback_vgui($callback, $aParams*)

	}
	/** bindMouseEvent
	*/
	bindMouseEvent($message)
	{
		MsgBox,262144,, MouseEvent_vgui.bindMouseEvent(),2 
		;MsgBox,262144,BIND, % $message +0,3
		OnMessage($message , "MouseEventsMainCallback")
	}


}
