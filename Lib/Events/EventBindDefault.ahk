/** Class EventBindDefault_vgui
*/
Class EventBindDefault_vgui
{

	_default_callbacks := "close|exit"

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
			if ( RegExMatch( $callback, "i)^" this._default_callbacks "$") )
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
