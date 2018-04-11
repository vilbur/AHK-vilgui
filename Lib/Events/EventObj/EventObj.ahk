/** Class Event
*/
Class EventObj_vgui
{

	/** Control set or get control of event
		@return object of Control which fires callback
	*/
	control($address:="~null")
	{
		if($address=="~null")
			return % Object(this.address)

		if($address)
			this.address	:= $address
		return this
	}
	/** Msgbox of Events properties
	*/
	message($timeout:=3)
	{
		MsgBox,262144,Event message, % this._getMessageString(this), %$timeout%
	}
	/** set value of Control
	  * @param string|object	$param1 key of property or object
	  * @param mixin	$param2 value of key
	  */
	set($param1, $param2:="")
	{
		if( isObject($param1) )
			For $key, $value in $param1
				this[$key]	:= $value
		
		else if( $param2 || $param2==0 )
			this[$param1]	:= $param2
			
		return this
	}
	/**
	 */
	setData( $event_data )
	{
		For $key, $value in $event_data
			this.set($key, $value)
	}
	/** _getMessageString
	*/
	_getMessageString($obj, $indent:="")
	{
		For $key, $value in $obj
			if(!isObject($value))
				$msg .= "`n" $indent $key ":`t"	$value
			else
				$msg .= "`n" $key ": {" this._getMessageString($value, "    ") "`n}"
				
		return $msg
	}

}
