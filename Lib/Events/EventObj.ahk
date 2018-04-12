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
	message($timeout:=10)
	{
		MsgBox,262144,Event message, % this._getMessageString(this), %$timeout%
	}
	/** set value of Control
	*/
	set($key, $value)
	{
		if($value || $value==0)
			this[$key]	:= $value
		return this
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
		return %$msg%
	}

}
