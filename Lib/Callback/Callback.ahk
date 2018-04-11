/** Set Function name
	Set parameters
	Call function
*/
Class Callback_vgui
{
	_callback	:= ""
	_params	:= []
	_params_call	:= []

	__New($callback:="", $aParams*)
	{
		if($callback)
			this.callback($callback)
		if($aParams)
			this.params($aParams*)
		return this
	}
	/** _callback
		@params string $callback name of callback function or object address and method E.G: "globalFunction" OR "123456789.methodName"
	*/
	callback($callback:="")
	{
		this._callback := $callback
		return this
	}
	/** setParams
		@param mixin $aParams any count of parameters E.G: .params("param1", "param2", "param3")
	*/
	params($aParams*)
	{
		For $i, $param in $aParams
			this._params.push($param)

		return this
	}
	/** Call this._callback function
	*/
	call($Event:="")
	{
		this._setCallParams($Event)
		if(!RegExMatch( this._callback, "i)^\d+", $string_match ))
			return % this._callFunction()
		else
			return % this._callObjectMethod()
	}

	/** call global Function
	*/
	_callFunction()
	{
		;Dump(this, "this.", 1)
		if(this._callback)
			return % Func(this._callback).call(this._params_call*)
	}
	/** call method in object
	*/
	_callObjectMethod()
	{
		;MsgBox,262144,, _callObjectMethod,2
		;Dump(this, "this.", 1)
		$obj_func_split	:= StrSplit(this._callback, ".")
		$object	:= Object($obj_func_split[1])
		;Dump($object, "object", 1)
		$method	:= $obj_func_split[2]
		return % $object[$method]( this._params_call* )
	}
	/** _setCallParams
	*/
	_setCallParams($Event:="")
	{
		this._params_call	:= this._params.clone()
		;$Event	:=  new EventObj_vgui()
		if($Event!="")
			this._params_call.InsertAt( 1, $Event )

	}


}
