/** Class GuiEvents_vgui
*/
Class GuiEvents_vgui extends EventBindDefault_vgui
{
	/** Fired on gui is submitted.
	 * 
	 * @param string $callback callback function "close|exit|false|customCallback"
	 * @param	mixed	$params*	any number of parameters
	 *
	 * @return self
	*/
	onSubmit($callback, $params*)
	{
		this._setUserOrDefaultCallback("onSubmit", $callback, $params*)
		
		return this
	}
	/** Fired on gui close with "X" button.
	 * 
	 * @param string $callback callback function "close|exit|false|customCallback"
	 * @param	mixed	$params*	any number of parameters
	 *
	 * @return self
	*/
	onClose($callback, $params*)
	{
		this.parent().Window.setMessages("close")
		this._setUserOrDefaultCallback("onClose", $callback, $params*)

		return this
	}
	/** Fired on gui is exiting script.
	 * 
	 * @param string $callback callback function "close|exit|false|customCallback"
	 * @param	mixed	$params*	any number of parameters
	 *
	 * @return self
	*/
	onExit($callback, $params*)
	{
		this._setUserOrDefaultCallback("onExit", $callback, $params*)
		
		return this
	}
	
}
	