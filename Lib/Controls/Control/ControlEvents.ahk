/** Class Control_vgui

	WHEN USER INTERACT WITH CONTROL:
		1) MAIN	CALLBACK	- Shared with all controls, it fires other callbacks
		2) DEFAULT	CALLBACK	- Do default actions and send event data to custom callback
		3) CUSTOM	CALLBACK 	- User defined callback for all events, NOT FIRED IF CALLBACK FOR EVENT EXISTS
		4) EVENT	CALLBACK	- User defined callback for event type
*/
Class ControlEvents_vgui
{

	Event	:= new ControlEvent_vgui()


	/*---------------------------------------
		CUSTOM CALLBACK
	-----------------------------------------
	*/
	/** Bind Custom Callback for all events
		FIRED ON EACH EVENT, IF CALLBACK FOR EVENT IS NOT DEFINED
	*/
	callback($callback:="", $aParams*)
	{
		;MsgBox,262144,, callback ,2
		this.Event.bind("custom", $callback, $aParams*)
		return this
	}
	/** Bind Custom Callback for all events
		@param	string $on_event
	*/
	on($on_event, $callback:="", $aParams*)
	{
		this.Event.bind($on_event, $callback, $aParams*)
		return this
	}
	
	/*---------------------------------------
		MAIN CALLBACK
	-----------------------------------------
	*/
	/** Bind main callback to control
		All controls callback fires this method first
	*/
	bindMainCallback()
	{
		fn := this._mainCallback.bind( this )
		GuiControl, +g, % this.hwnd, % fn
	}

	/** DEFAULT CALLBACK - FIRED BEFORE EVERY CUSTOM CALLBACK
	  * 
	  * This Method is called, when user interact with control
	  * It Calls Custom Events
	*/
	_mainCallback($params*)
	{
		/* Set focus color
		*/
		this._setFocusColor()
		;MsgBox,262144,, % this._name,2 
		/* Call user callback
		*/		
		this.Event.control(this).callAllCallbacks()
	}
	/*---------------------------------------
		DEFAULT CALLBACK
	-----------------------------------------
	*/
	/** Bind Default Event
	*/
	_bindDefaultCallback($callback, $aParams*)
	{
		;MsgBox,262144,, _bindDefaultCallback,2
		this.Event.bind("default", $callback, $aParams*)
	}


}
