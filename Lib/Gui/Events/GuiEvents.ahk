/** Class GuiEvents_vgui
*/
Class GuiEvents_vgui{

	;events	:=	{"close":	{"default":"", "callback":""}
	;		,"escape":	{"default":"", "callback":""}
	;		,"submit":	{"default":"", "callback":""}}
	events	:=	{}


	/*-----------------------------------------
		BIND EVENTS
	-----------------------------------------
	*/
	/** on Escape pressed
		@param string $callback event "close|exit" or user defined function

			E.G:	.onEscape("onCloseCallback")	; 1) Call this function on escape pressed
				.onEscape("exit|close")	; 2) then exit script or destroy GUI
	*/
	escape($callback, $aParams*){
		this.parent().Key.bindEvents()
		this._setCallback("escape", $callback, $aParams*)
		return this
	}
	/** On Window Closed
		@param string $callback event "close|exit" or user defined function

			E.G:	.onClose("onCloseCallback")	; 1) Call this function on window closed
				.onClose("exit|close")	; 2) then exit script or destroy GUI
	*/
	close($callback, $aParams*){
		this.parent().Window.bindEvents()
		this._setCallback("close", $callback, $aParams*)
		return this
	}
	/** On Window Closed
		@param string $callback event "close|exit" or user defined function

			E.G:	.onClose("onCloseCallback")	; 1) Call this function on window closed
				.onClose("exit|close")	; 2) then exit script or destroy GUI
	*/
	submit($callback, $aParams*){
		this._setCallback("submit", $callback, $aParams*)
		return this
	}
	/*-----------------------------------------
		SET & CALL CALLBACK
	-----------------------------------------
	*/
	/** 1) Call custom  callback
		2) Call default callback
	*/
	call($event, $event_data:=""){
		;MsgBox,262144,, Call,2
		this.events[$event].callEventCallback($event,	$event_data)
		this.events[$event].callEventCallback("default",	$event_data)
		;Dump(this.events[$event], "this.events."$event, 1)
	}
	/** _setCallback
	*/
	_setCallback($event, $callback, $aParams*){
		if(!this.events[$event])
			this.events[$event] :=  new Event_vgui()

		if(RegExMatch( $callback, "i)^close|exit$"))
			this.events[$event].bind( "default", &this.parent().parent() "." $callback ) ; callback of VilGUIv3.close()|.exit()
		else
			this.events[$event].bind( $event, $callback, $aParams*)
	}

	/*-----------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** parent
	*/
	parent($Parent:=""){
		if($Parent)
			this._Parent	:= &$Parent
		return % $Parent ? this : Object(this._Parent)
	}

}
