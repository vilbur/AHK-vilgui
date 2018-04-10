/** Class Event store multiple callbacks for control
*/
Class ControlEvent_vgui
{

	mouse	:= new MouseEvent_vgui()
	default	:= "" ; fired as first, default callback for control, E.G: submit() for submit button
	custom	:= "" ; fired as second, defined callback, called after default callback

	/** Get\Set control of event
	*/
	control($Control:="")
	{
		if( ! $Control )
			return % Object(this._ctr_addr)

		this._ctr_addr	:= &$Control
		return this
	}
	/** Bind new event to class
	*/
	bind($on_event, $callback:="", $aParams*)
	{
		if(RegExMatch( $on_event, "i)^mouse(.*)", $event_match ))
			this.mouse.bind($event_match1, $callback, $aParams*)
		else
			this[$on_event] := new Callback_vgui($callback, $aParams*)			

		return this
	}
	/** Call all callbacks in sequence:
		1) Default callback - get event data
		2) Custom or Event callback
	*/
	callAllCallbacks()
	{
		;this._event_type	:= this._getEventType()
		this._callDefaultCallback()
		;;;; DEACTIVATED: if(this.event_data!=false) ; IF DEFAULT EVENT RETURN FALSE E.G: SUBMIT dialog itself call Event Callback and return false to avoid double triggering
		return % this.callEventCallback( )
	}
	/** Call default callback for control
		Control can has default callback which is fired BEFORE custom callback
		Default callback allows perform GUI action before user`s custom callback	E.G: Submit button calls .submit() method first
		RETURNED DATA ARE BIND TO Event.data of custom callback
		@return mixin
	*/
	_callDefaultCallback()
	{
		this.event_data	:= this.default.call(this)	; bind events to callback, default callback then can custom callback	E.G: VilGUI.submit()
	}
	/** Call Event callback
		@param string	$event_type name of
		@param mixin	$event_data for bind to call back
	*/
	callEventCallback($event_type:="", $event_data:="")
	{
		this._event_type := $event_type ? $event_type :  this._getEventType()
		$event_callback	:= this[this._event_type] ? this._event_type : "custom"

		if($event_data)
			this.event_data := $event_data

		if(this[$event_callback])
			return % this[$event_callback].call(this._getEventObject())

	}
	/*---------------------------------------
		EVENT OBJECT METHODS
	-----------------------------------------
	*/
	/** _getEventObject
	*/
	_getEventObject()
	{
		this.Event := new EventObj_vgui()
							.control(this._ctr_addr)
							.set("type",	this._event_type)
							.set("value", this.control().value() )
							.set("key",	this._event_type == "KeyPress" ? GetKeyName(Format("vk{:x}", A_EventInfo)) : "")
							.set("data",	this.event_data)
							
		this._event_type := "" ; reset event type for next call
		return % this.Event
	}
	/** _getEventType https://autohotkey.com/docs/commands/ListView.htm#notify
		$event.types = "LeftClick|RightClick|DoubleClick|DoubleClickRight|Drag|Activated|Edit|MouseRelease|Focus|ItemChanged|KeyPress|Selection|Scroll"
	*/
	_getEventType()
	{
		$events := 	{Normal:	"LeftClick"
			,R:	"DoubleClickRight"
			,D:	"Drag"
			,A:	"Activated"
			,E:	"Edit"
			,C:	"MouseRelease"
			,F:	"Focus"
			,I:	"ItemChanged"
			,K:	"KeyPress"
			,M:	"Selection"
			,S:	"Scroll"}

		$event := !$events[A_GuiEvent] ? A_GuiEvent : $events[A_GuiEvent] (RegExMatch(A_GuiEvent, "[defs]" ) ? "End" : "")
		return %$event%
	}




}
