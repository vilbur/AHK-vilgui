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
		this._setUserOrDefaultCallback("onSubmit", $callback, $params*)
		return this
	}
	/** Fired on gui close with "X" button.
	*/
	onClose($callback, $params*)
	{
		this.parent().Window.bindEvents()
		this._setUserOrDefaultCallback("onClose", $callback, $params*)

		return this
	}
	/** Fired on gui is exiting script.
	*/
	onExit($callback, $params*)
	{
		this._setUserOrDefaultCallback("onExit", $callback, $params*)
		return this
	}

	/*-----------------------------------------
		SET & CALL CALLBACK
	-----------------------------------------
	*/

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
		this._bindCallback( $event, &this.parent().parent() "." $callback ) 
	}
	/**
	 */
	_getEventObject($event)
	{
		$EventObj := new EventObj_vgui()
							.set("event", $event)
		
		return $EventObj 
	} 


}
	