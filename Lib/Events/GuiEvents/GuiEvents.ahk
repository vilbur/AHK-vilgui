/** Class GuiEvents_vgui
*/
Class GuiEvents_vgui
{

	;events	:=	{"close":	{"default":"", "callback":""}
	;		,"escape":	{"default":"", "callback":""}
	;		,"submit":	{"default":"", "callback":""}}
	events	:=	{}

	/*-----------------------------------------
		BIND EVENTS
	-----------------------------------------
	*/
	/** Fired on gui is submitted.

		@param string $callback event "close|exit|false|callbackFn"
	*/
	onSubmit($callback, $params*)
	{
		this._setCallback("submit", $callback, $params*)
		return this
	}
	/** Fired on gui is exiting script.
	*/
	onExit($callback, $params*)
	{
		this._setCallback("exit", $callback, $params*)
		return this
	}
	/** Fired on gui close with "X" button.
	*/
	onClose($callback, $params*)
	{
		this.parent().Window.bindEvents()
		this._setCallback("close", $callback, $params*)
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
	_setCallback($event, $callback, $params*)
	{
		if( $callback!=0 )
			(! RegExMatch( $callback, "i)^close|exit$") )? this._setCustomCallback($event, $callback, $params*) : this._setDefaultCallback($event, $callback )
		else
			this._removeCallback($event)
		;Dump(this.events, "this.events", 1)
	}
	/** set Event object if not defined yet
	*/
	_setEventObject($event)
	{
		if(!this.events[$event])
			this.events[$event] :=  new Event_vgui()
	}
	/**
	 */
	_setDefaultCallback($event, $callback)
	{
		this._setEventObject($event)
		this.events[$event].bind( "default", &this.parent().parent() "." $callback ) ; callback of VilGUI.close()|.exit()
	}
	/**
	 */
	_setCustomCallback($event, $callback, $params*)
	{
		this._setEventObject($event)
		this.events[$event].bind( $event, $callback, $params*)
	}
	/** _removeCallback
	 */
	_removeCallback($event){
		this.events[$event] := ""
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
