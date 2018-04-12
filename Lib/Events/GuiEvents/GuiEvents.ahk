/** Class GuiEvents_vgui
*/
Class GuiEvents_vgui extends EventBindDefault_vgui
{
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
		;this.parent().Window.bindEvents()
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
	;/**
	; */
	;_getEventObject($event)
	;{
	;	$EventObj := new EventObj_vgui()
	;						.set("event", $event)
	;	
	;	return $EventObj 
	;} 


}
	