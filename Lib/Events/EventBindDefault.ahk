/** Class EventBindDefault_vgui
*/
Class EventBindDefault_vgui extends EventBind_vgui
{

	/** _setUserOrDefaultCallback
	*/
	_setUserOrDefaultCallback($event, $callback, $params*)
	{
		if( $callback )
		{ 
			if ( RegExMatch( $callback, "i)^(close|exit)$") )
				this._bindDefaultCallback($event, $callback, $params* )
			
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


}
