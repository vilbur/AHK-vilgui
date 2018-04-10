/** Class GuiEvents_vgui
*/
Class GuiEvents_vgui extends EventBind_vgui
{

	;events	:=	{"close":	{"default":"", "callback":""}
	;		,"escape":	{"default":"", "callback":""}
	;		,"submit":	{"default":"", "callback":""}}
	;events	:=	{}

	/*-----------------------------------------
		BIND EVENTS
	-----------------------------------------
	*/
	/** Fired on gui is submitted.

		@param string $callback event "close|exit|false|callbackFn"
	*/
	onSubmit($callback, $params*)
	{
		this._setUserOrDefaultCallback("submit", $callback, $params*)
		return this
	}
	/** Fired on gui close with "X" button.
	*/
	onClose($callback, $params*)
	{
		this.parent().Window.bindEvents()
		this._setUserOrDefaultCallback("close", $callback, $params*)
		return this
	}
	/** Fired on gui is exiting script.
	*/
	onExit($callback, $params*)
	{
		this._setUserOrDefaultCallback("exit", $callback, $params*)
		return this
	}

	/*-----------------------------------------
		SET & CALL CALLBACK
	-----------------------------------------
	*/
	/** 1) Call custom  callback
		2) Call default callback
	*/
	call($event)
	{
		$EventObj := this._getEventObject($event)
							;Dump(this, "this.", 1)
		this._callCallback($event, $EventObj)
		this._callCallback($event "-default", $EventObj)		

	}
	/** _setUserOrDefaultCallback
	*/
	_setUserOrDefaultCallback($event, $callback, $params*)
	{
		if( $callback )
		{
			if ( RegExMatch( $callback, "i)^close|exit$") )
				this._bindDefaultCallback($event, $callback )
			
			else
				this._bindCallback($event, $callback, $params*)
			
		} else
			this._removeCallback($event)
	}
	/** Bind default callback
	  * Callback is method from class VilGUI E.G.: VilGUI.close() OR VilGUI.exit()
	 */
	_bindDefaultCallback($event, $callback)
	{
		this._bindCallback( $event "-default", &this.parent().parent() "." $callback ) 
	}
	/**
	 */
	_getEventObject($event)
	{
		$EventObj := new EventObj_vgui()
							.set("event", $event)
		
		return $EventObj 
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
